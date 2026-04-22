import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';

import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/Screen/edit/controller/edit_issue_controller.dart';
import 'package:survey_markus/View/Screen/home/model/project_configuration_model.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';

class CreateIssueController extends EditIssueController {
  final isLoading = false.obs;
  final projectId = 1.obs; // Default project ID, can be made dynamic

  // Form validation
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // selectedIndex inherited from EditIssueController will be set by _initializeLanguage() called in super.onInit()
  }

  // Additional observables for form fields
  final selectedSubsystem = Rx<String?>(null);
  final selectedCategory = Rx<String?>(null);
  final selectedLocation = Rx<String?>(null);
  final selectedResponsible = Rx<String?>(null);
  final selectedPriority = Rx<String?>(null);
  final selectedStatus = Rx<String?>(null);

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

  // Additional fields for API
  final referenceController = TextEditingController();
  final locationController = TextEditingController();
  final responsibleCompanyController = TextEditingController();
  final responsibleEmployerController = TextEditingController();
  final erfasserController = TextEditingController(); // Creator/Recorder field

  // Multiple images support
  final selectedImages = <XFile>[].obs; // Support multiple images

  @override
  void onClose() {
    referenceController.dispose();
    locationController.dispose();
    responsibleCompanyController.dispose();
    responsibleEmployerController.dispose();
    erfasserController.dispose();
    super.onClose();
  }

  /// Create project issue using the API
  Future<void> createProjectIssue({
    required String projectId,
    required String system,
    required String subsystem,
    required String category,
    required String description,
    required String descriptionOriginalLanguage,
    required String reference,
    required String location,
    required String recorder,
    required String recorded,
    required String responsibleCompany,
    required String responsibleEmployer,
    required String deadLine,
    required String priority,
    required String status,
  }) async {
    try {
      isLoading.value = true;

      final homeController = Get.find<HomeController>();

      final result = await homeController.createProjectIssue(
        projectId: int.parse(projectId),
        system: system,
        subsystem: subsystem,
        category: category,
        description: description,
        descriptionOriginalLanguage: descriptionOriginalLanguage,
        reference: reference,
        location: location,
        recorder: recorder,
        recorded: recorded,
        responsibleCompany: responsibleCompany,
        responsibleEmployer: responsibleEmployer,
        deadLine: deadLine,
        priority: priority,
        status: status,
      );
      print('dsfds result is ${result}');

      if (result['success']) {
        // Extract issue ID from response
        String? issueId;
        try {
          final responseData = result['data'];
          if (responseData != null) {
            // Try different response structures
            if (responseData is Map) {
              if (responseData['data'] != null &&
                  responseData['data']['id'] != null) {
                issueId = responseData['data']['id']?.toString();
              } else if (responseData['id'] != null) {
                issueId = responseData['id']?.toString();
              }
            }
          }
          print('Extracted issue ID: $issueId');
        } catch (e) {
          print('Error extracting issue ID: $e');
        }

        // Upload images if selected
        if (selectedImages.isNotEmpty && issueId != null) {
          await uploadImages(issueId: issueId);
        } else if (selectedImages.isNotEmpty && issueId == null) {
          print('Warning: Images selected but could not extract issue ID');
        }

        Navigator.of(Get.context!).pop();
        Get.snackbar(
          'Success',
          'Project issue created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        await homeController.getProjectIssuesByProject(projectId: projectId);
        // Refresh the project issues list
// Navigate back after successful creation
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to create project issue',
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
    } finally {
      isLoading.value = false;
    }
  }

  /// Validate form and create issue
  /// Only mandatory fields: Trade (System), Location, Recording Date, Creator (Erfasser), Description
  Future<void> submitForm({
    required String system,
    required String subsystem,
    required String category,
    required String location,
    required String priority,
    required String status,
    required String projectId,
  }) async {
    // Validate mandatory fields only
    if (systemOptions.isNotEmpty && system.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please select a Trade/System',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (locationOptions.isNotEmpty && location.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please select a Location',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (recordingDate.value == null) {
      Get.snackbar(
        'Validation Error',
        'Please select a Recording Date',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (erfasserController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter Erfasser (Creator)',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Deadline is now optional

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter a Description',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // All other fields are optional - no validation needed

    if (formKey.currentState?.validate() ?? false) {
      // Format dates
      final recordedDate =
          recordingDate.value?.toIso8601String().split('T')[0] ??
              DateTime.now().toIso8601String().split('T')[0];
      final deadlineDateStr = deadlineDate.value != null
          ? deadlineDate.value!.toIso8601String().split('T')[0]
          : "";

      print('Submitting form with data:');
      print('System: $system');
      print('Subsystem: $subsystem');
      print('Category: $category');
      print('Description: ${descriptionController.text}');
      print('Location: $location');
      print('Responsible Company: ${responsibleCompanyController.text}');
      print('Responsible Employer: ${responsibleEmployerController.text}');
      print('Priority: $priority');
      print('Status: $status');
      print('Recorded Date: $recordedDate');
      print('Deadline: $deadlineDateStr');

      // Translate description to German for the database
      final generalController = Get.find<GeneralController>();
      final originalDescription = descriptionController.text;
      final germanDescription = await generalController.translateString(
        originalDescription,
        targetLanguage: 'de',
      );

      await createProjectIssue(
        projectId: projectId,
        system: systemOptions.isNotEmpty ? system : '',
        subsystem: subsystemOptions.isNotEmpty ? subsystem : '',
        category: categoryOptions.isNotEmpty
            ? category
            : '', // Already handled in UI (empty string if hidden)
        description: germanDescription,
        descriptionOriginalLanguage: originalDescription,
        reference: '',
        location: locationOptions.isNotEmpty ? location : '',
        recorder: erfasserController.text.trim().isNotEmpty
            ? erfasserController.text.trim()
            : '',
        recorded: recordedDate,
        responsibleCompany: isFieldHidden('responsible_company')
            ? ''
            : (responsibleCompanyController.text.isNotEmpty
                ? responsibleCompanyController.text
                : ""),
        responsibleEmployer: responsibleEmployerController.text.isNotEmpty
            ? responsibleEmployerController.text
            : "",
        deadLine: deadlineDateStr,
        priority: priority,
        status: status,
      );
    } else {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// Set project ID (can be called from parent widget)
  void setProjectId(int id) {
    projectId.value = id;
  }

  /// Update selected values from the form
  void updateSelectedValues({
    String? system,
    String? subsystem,
    String? category,
    String? location,
    String? priority,
    String? status,
  }) {
    if (system != null) selectedSystem.value = system;
    if (subsystem != null) selectedSubsystem.value = subsystem;
    if (category != null) selectedCategory.value = category;
    if (location != null) selectedLocation.value = location;
    if (priority != null) selectedPriority.value = priority;
    if (status != null) selectedStatus.value = status;
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

  /// Pick multiple images
  Future<void> pickMultipleImages(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images);
      }
    } catch (e) {
      print('Error picking images: $e');
      Get.snackbar(
        'Error',
        'Failed to pick images: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// Show image picker options for multiple images
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
              onTap: () async {
                Get.back();
                try {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    selectedImages.add(image);
                  }
                } catch (e) {
                  print('Error picking image: $e');
                  Get.snackbar(
                    'Error',
                    'Failed to pick image: ${e.toString()}',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Color(0xffebb105)),
              title: Text('Choose from Gallery (Multiple)'),
              onTap: () {
                Get.back();
                pickMultipleImages(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Upload multiple images for project issue one by one
  /// API accepts only one image at a time, so we upload them sequentially
  Future<void> uploadImages({required String issueId}) async {
    if (selectedImages.isEmpty) {
      return;
    }

    print(
        'Starting upload of ${selectedImages.length} image(s) for issue $issueId');

    // Track upload results
    int successCount = 0;
    int failureCount = 0;

    // Upload images one by one in a loop
    for (int i = 0; i < selectedImages.length; i++) {
      final xFile = selectedImages[i];
      final file = File(xFile.path);

      // Check if file exists before attempting upload
      if (!await file.exists()) {
        print('Warning: Image ${i + 1} file does not exist: ${file.path}');
        failureCount++;
        continue;
      }

      try {
        print(
            'Uploading image ${i + 1}/${selectedImages.length}: ${file.path}');

        // Upload one image at a time
        final response = await ApiClient.postMultipartData(
          ApiUrl.uploadProjectIssueImages(issueId: issueId),
          {},
          multipartBody: [MultipartBody('images', file)],
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          successCount++;
          print('✅ Image ${i + 1} uploaded successfully');
        } else {
          failureCount++;
          print(
              '❌ Failed to upload image ${i + 1}: Status ${response.statusCode}');
        }
      } catch (e) {
        failureCount++;
        print('❌ Error uploading image ${i + 1}: $e');
      }
    }

    // Show summary message
    if (successCount > 0 && failureCount == 0) {
      print('✅ All ${successCount} image(s) uploaded successfully');
    } else if (successCount > 0 && failureCount > 0) {
      print('⚠️ ${successCount} image(s) uploaded, ${failureCount} failed');
      Get.snackbar(
        'Partial Success',
        '$successCount image(s) uploaded, ${failureCount} failed',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      );
    } else {
      print('❌ All image uploads failed');
      Get.snackbar(
        'Upload Failed',
        'Failed to upload all images',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
