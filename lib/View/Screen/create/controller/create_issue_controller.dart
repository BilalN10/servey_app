import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/Screen/edit/controller/edit_issue_controller.dart';

class CreateIssueController extends EditIssueController {
  final isLoading = false.obs;
  final projectId = 1.obs; // Default project ID, can be made dynamic

  // Form validation
  final formKey = GlobalKey<FormState>();

  // Additional fields for API
  final referenceController = TextEditingController();
  final locationController = TextEditingController();
  final responsibleCompanyController = TextEditingController();
  final responsibleEmployerController = TextEditingController();

  @override
  void onClose() {
    referenceController.dispose();
    locationController.dispose();
    responsibleCompanyController.dispose();
    responsibleEmployerController.dispose();
    super.onClose();
  }

  /// Create project issue using the API
  Future<void> createProjectIssue({
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
        projectId: projectId.value,
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

      if (result['success']) {
        Get.snackbar(
          'Success',
          'Project issue created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        Get.back(); // Navigate back after successful creation
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
  Future<void> submitForm({
    required String system,
    required String subsystem,
    required String category,
    required String location,
    required String responsible,
    required String priority,
    required String status,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      // Format dates
      final recordedDate =
          recordingDate.value?.toIso8601String().split('T')[0] ??
              DateTime.now().toIso8601String().split('T')[0];
      final deadlineDateStr = deadlineDate.value
              ?.toIso8601String()
              .split('T')[0] ??
          DateTime.now().add(Duration(days: 7)).toIso8601String().split('T')[0];

      await createProjectIssue(
        system: system,
        subsystem: subsystem,
        category: category,
        description: descriptionController.text,
        descriptionOriginalLanguage:
            descriptionController.text, // Same as description for now
        reference: referenceController.text.isNotEmpty
            ? referenceController.text
            : "REF-${DateTime.now().millisecondsSinceEpoch}",
        location: location,
        recorder: responsible,
        recorded: recordedDate,
        responsibleCompany: responsibleCompanyController.text.isNotEmpty
            ? responsibleCompanyController.text
            : "Default Company",
        responsibleEmployer: responsibleEmployerController.text.isNotEmpty
            ? responsibleEmployerController.text
            : responsible,
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
}
