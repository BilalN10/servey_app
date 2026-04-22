import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/Screen/home/model/project_configuration_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class EditIssueController extends GetxController {
  final selectedIndex = 0.obs;
  final selectedSystem = Rx<String?>(null);
  final selectedSubsystem = Rx<String?>(null);
  final selectedCategory = Rx<String?>(null);
  final selectedLocation = Rx<String?>(null);
  final selectedPriority = Rx<String?>(null);
  final selectedStatus = Rx<String?>(null);
  final systemList = ['WMS System', 'B', 'C', 'D'].obs;
  final recordingDate = Rx<DateTime?>(null);
  final deadlineDate = Rx<DateTime?>(null);
  final isEditMode = false.obs;
  final descriptionController = TextEditingController();
  final responsibleController = TextEditingController();
  final responsibleCompanyController = TextEditingController();
  final selectedImage = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeLanguage();
  }

  void _initializeLanguage() {
    final generalController = Get.find<GeneralController>();
    if (generalController.transLangu.value == 'en') {
      selectedIndex.value = 1;
    } else {
      selectedIndex.value = 0; // Default to DE
    }
  }

  // Dynamic dropdown options from API
  final systemOptions = <String>[].obs;
  final subsystemOptions = <String>[].obs;
  final categoryOptions = <String>[].obs;
  final locationOptions = <String>[].obs;
  final priorityOptions = <String>[].obs;
  final statusOptions = <String>[].obs;
  final responsibleOptions = <String>[].obs;

  // Loading state for configurations
  final configurationsLoading = false.obs;

  // Images from API
  final issueImages = <String>[].obs;
  final imagesLoading = false.obs;

  void changeLanguage(int index) {
    selectedIndex.value = index;
    final generalController = Get.find<GeneralController>();
    String langCode = (index == 0) ? 'de' : 'en';
    generalController.transLangu.value = langCode;
    SharePrefsHelper.setString(AppConstants.transLan, langCode);
  }

  void changeSystem(String? value) {
    selectedSystem.value = value;
  }

  void setRecordingDate(DateTime? date) {
    recordingDate.value = date;
  }

  void setDeadlineDate(DateTime? date) {
    deadlineDate.value = date;
  }

  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  /// Update project issue
  Future<void> updateProjectIssue({
    required String issueId,
    required String projectId,
    required String system,
    required String subsystem,
    required String category,
    required String location,
    required String description,
    required String descriptionOriginalLanguage,
    required String responsibleCompany,
    required String responsibleEmployer,
    required String status,
    required String priority,
    required String deadLine,
  }) async {
    try {
      // Translate description to German for the database
      final generalController = Get.find<GeneralController>();
      final originalDescription = description;
      final germanDescription = await generalController.translateString(
        originalDescription,
        targetLanguage: 'de',
      );

      final homeController = Get.find<HomeController>();

      final result = await homeController.updateProjectIssue(
        projectId: projectId,
        issueId: issueId,
        system: system,
        subsystem: subsystem,
        category: category,
        location: location,
        description: germanDescription,
        descriptionOriginalLanguage: originalDescription,
        responsibleCompany: responsibleCompany,
        responsibleEmployer: responsibleEmployer,
        status: status,
        priority: priority,
        deadLine: deadLine,
      );

      if (result['success']) {
        Get.snackbar(
          'Success',
          'Project issue updated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        toggleEditMode(); // Exit edit mode
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to update project issue',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
  }

  void showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        height: 250,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Color(0xffebb105)),
              title: Text('Take Photo'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Color(0xffebb105)),
              title: Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Check if a field is hidden based on configurations
  bool isFieldHidden(String fieldName) {
    try {
      final homeController = Get.find<HomeController>();
      final config = homeController.projectConfigurationsList.firstWhere(
        (config) => config.fieldName == fieldName,
        orElse: () => FieldConfiguration(
          id: 0,
          projectId: 0,
          fieldName: fieldName,
          fieldLabel: '',
          fieldType: '',
          isRequired: false,
          isHidden: false, // Default to visible if not found
          isActive: true,
          sortOrder: 0,
          createdAt: '',
          updatedAt: '',
        ),
      );
      return config.isHidden;
    } catch (e) {
      return false; // Default to visible if error
    }
  }

  /// Fetch project configurations and populate dropdown options
  Future<void> fetchProjectConfigurations(String projectId) async {
    try {
      configurationsLoading.value = true;

      final homeController = Get.find<HomeController>();
      await homeController.getProjectIssuesWithConfigurations(
          projectId: projectId);

      // Clear existing options
      systemOptions.clear();
      subsystemOptions.clear();
      categoryOptions.clear();
      locationOptions.clear();
      priorityOptions.clear();
      statusOptions.clear();
      responsibleOptions.clear();

      // Populate options from configurations
      for (final config in homeController.projectConfigurationsList) {
        if (config.isActive &&
            !config.isHidden &&
            config.dropdownOptions != null) {
          switch (config.fieldName) {
            case 'system':
              systemOptions.addAll(config.dropdownOptions!);
              break;
            case 'subsystem':
              subsystemOptions.addAll(config.dropdownOptions!);
              break;
            case 'category':
              categoryOptions.addAll(config.dropdownOptions!);
              break;
            case 'location':
              locationOptions.addAll(config.dropdownOptions!);
              break;
            case 'priority':
              priorityOptions.addAll(config.dropdownOptions!);
              break;
            case 'status':
              statusOptions.addAll(config.dropdownOptions!);
              break;
            case 'responsible_employer':
              responsibleOptions.addAll(config.dropdownOptions!);
              break;
          }
        }
      }

      // Remove duplicates and sort
      systemOptions.value = systemOptions.toSet().toList()..sort();
      subsystemOptions.value = subsystemOptions.toSet().toList()..sort();
      categoryOptions.value = categoryOptions.toSet().toList()..sort();
      locationOptions.value = locationOptions.toSet().toList()..sort();
      priorityOptions.value = priorityOptions.toSet().toList()..sort();
      statusOptions.value = statusOptions.toSet().toList()..sort();
      responsibleOptions.value = responsibleOptions.toSet().toList()..sort();
    } catch (e) {
      print('Error fetching project configurations: $e');
      Get.snackbar(
        'Error',
        'Failed to load dropdown options',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      configurationsLoading.value = false;
    }
  }

  /// Add missing values to dropdown options (for initial values from issue)
  void addMissingValuesToOptions({
    String? system,
    String? subsystem,
    String? category,
    String? location,
    String? priority,
    String? status,
    String? responsible,
  }) {
    if (system != null && !systemOptions.contains(system)) {
      systemOptions.add(system);
      systemOptions.value = systemOptions.toSet().toList()..sort();
    }
    if (subsystem != null && !subsystemOptions.contains(subsystem)) {
      subsystemOptions.add(subsystem);
      subsystemOptions.value = subsystemOptions.toSet().toList()..sort();
    }
    if (category != null && !categoryOptions.contains(category)) {
      categoryOptions.add(category);
      categoryOptions.value = categoryOptions.toSet().toList()..sort();
    }
    if (location != null && !locationOptions.contains(location)) {
      locationOptions.add(location);
      locationOptions.value = locationOptions.toSet().toList()..sort();
    }
    if (priority != null && !priorityOptions.contains(priority)) {
      priorityOptions.add(priority);
      priorityOptions.value = priorityOptions.toSet().toList()..sort();
    }
    if (status != null && !statusOptions.contains(status)) {
      statusOptions.add(status);
      statusOptions.value = statusOptions.toSet().toList()..sort();
    }
    if (responsible != null && !responsibleOptions.contains(responsible)) {
      responsibleOptions.add(responsible);
      responsibleOptions.value = responsibleOptions.toSet().toList()..sort();
    }
  }

  /// Fetch images for project issue
  Future<void> fetchIssueImages(String issueId) async {
    try {
      imagesLoading.value = true;
      issueImages.clear();

      final response = await ApiClient.getData(
        ApiUrl.getProjectIssueImages(issueId: issueId),
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData != null && responseData['data'] != null) {
          final images = responseData['data'];
          if (images is List) {
            // Extract image URLs from the response
            for (var image in images) {
              if (image is Map && image['file_path'] != null) {
                String filePath = image['file_path'];
                // Construct full URL - ensure file_path starts with /
                String imageUrl = filePath.startsWith('/')
                    ? '${ApiUrl.baseUrl}$filePath'
                    : '${ApiUrl.baseUrl}/$filePath';
                issueImages.add(imageUrl);
              }
            }
          } else if (images is Map) {
            // If single image object
            if (images['file_path'] != null) {
              String filePath = images['file_path'];
              // Construct full URL - ensure file_path starts with /
              String imageUrl = filePath.startsWith('/')
                  ? '${ApiUrl.baseUrl}$filePath'
                  : '${ApiUrl.baseUrl}/$filePath';
              issueImages.add(imageUrl);
            }
          }
        }
      } else {
        print('Failed to fetch images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching issue images: $e');
    } finally {
      imagesLoading.value = false;
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    responsibleController.dispose();
    responsibleCompanyController.dispose();
    super.onClose();
  }
}
