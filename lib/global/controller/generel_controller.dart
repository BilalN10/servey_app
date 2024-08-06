import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';

class GeneralController extends GetxController {
  ///========================== Show Popup Loader ========================
  showPopUpLoader() {
    return showDialog(
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (_) {
          return const SizedBox(
            height: 70,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: CustomLoader(),
            ),
          );
        });
  }

  ///========================== Pick Image ========================
  Rx<File> imageFile = File("").obs;
  RxString imagePath = "".obs;
  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    refresh();
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      imagePath.value = getImages.path;
    }
  }

  //   final List<String> emojiList = [
  //   AppImages.rattingOneEmoji,
  //   AppImages.rattingThreeEmoji,
  //   AppImages.rattingTwoEmoji,
  //   AppImages.rattingFourEmoji,
  //   AppImages.rattingFiveEmoji,
  // ];

  String findEmoji({required int index}) {
    switch (index) {
      case 1:
        return AppImages.rattingOneEmoji;
      case 2:
        return AppImages.rattingThreeEmoji;
      case 3:
        return AppImages.rattingTwoEmoji;
      case 4:
        return AppImages.rattingFourEmoji;
      case 5:
        return AppImages.rattingFiveEmoji;
      default:
        throw ArgumentError('Invalid index: $index');
    }
  }
}
