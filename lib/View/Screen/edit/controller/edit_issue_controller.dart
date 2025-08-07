import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditIssueController extends GetxController {
  final selectedIndex = 0.obs;
  final selectedSystem = Rx<String?>(null);
  final systemList = ['WMS System', 'B', 'C', 'D'].obs;
  final recordingDate = Rx<DateTime?>(null);
  final deadlineDate = Rx<DateTime?>(null);
  final isEditMode = false.obs;
  final descriptionController = TextEditingController();
  final selectedImage = Rx<XFile?>(null);

  void changeLanguage(int index) {
    selectedIndex.value = index;
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
}
