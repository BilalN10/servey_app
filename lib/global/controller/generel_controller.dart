import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class GeneralController extends GetxController {
  @override
  void onInit() {
    getTranLangua();
    super.onInit();
  }

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

  ///==================== Select the Translated Language ======================

  selectLanguage({required bool show}) async {
    String tranLan = await SharePrefsHelper.getString(AppConstants.transLan);
    getTranLangua();

    if (tranLan.isEmpty || tranLan == "null" || show) {
      Get.dialog(
        barrierDismissible: false,
        Dialog(
          // Wrap with Dialog widget to enforce size constraints
          child: Container(
            height: 150.h,
            width: 300.w,
            padding: EdgeInsets.all(30.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: AppStaticStrings.pleaseChoosYour,
                  bottom: 10.h,
                  maxLines: 3,
                ),
                LanguagePickerDropdown(
                  initialValue: transLangu.value == 'de'
                      ? Languages.german
                      : Languages.english,
                  onValuePicked: (Language language) {
                    SharePrefsHelper.setString(
                        AppConstants.transLan, language.isoCode);
                    debugPrint(language.isoCode);
                    getTranLangua();
                    Future.delayed(const Duration(seconds: 1), () {
                      navigator!.pop();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  ///==================== Get the Translated Language ======================

  RxString transLangu = "".obs;

  Future<String> getTranLangua() async {
    return transLangu.value =
        await SharePrefsHelper.getString(AppConstants.transLan);
  }

  ///======= Find The Emoji Based on index  1=Angry, 2=Bad, 3=Satisfied, 4=Good, 5=Very-satisfied =======

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

  ///==================== Delete Account =====================
  deleteAccount(
      {required TextEditingController passController,
      required TextEditingController confPassController}) async {
    showPopUpLoader();

    var body = {
      "password": passController.text,
      "password_confirmation": confPassController.text
    };

    var response = await ApiClient.postData(ApiUrl.deleteEmployee, body,
        contentType: false);

    if (response.statusCode == 200) {
      navigator?.pop();
      navigator?.pop();
      navigator?.pop();
      toastMessage(message: response.body["message"], color: Colors.green);
    } else {
      navigator?.pop();
      navigator?.pop();
      navigator?.pop();
      ApiChecker.checkApi(response);
    }
  }

  ///==================== Translation Logic =====================
  RxMap<String, String> translationCache = <String, String>{}.obs;

  Future<String> translateString(String text, {String? targetLanguage}) async {
    String targetLang = targetLanguage ?? transLangu.value;

    // If language is empty or null, assume English/Default and return original
    if (targetLang.isEmpty || targetLang == "null" || targetLang == "en") {
      return text;
    }

    // Check Cache
    String cacheKey = "$text|$targetLang";
    if (translationCache.containsKey(cacheKey)) {
      return translationCache[cacheKey]!;
    }

    try {
      print('debug mode ${kDebugMode}');
      final url = Uri.parse(
          'https://translation.googleapis.com/language/translate/v2?key=${AppConstants.googleApiClientKey}');

      final headers = {
        'X-Android-Package': 'com.servey.markus',
        'X-Android-Cert': kDebugMode
            ? '39:F3:7E:8A:8C:66:F9:92:CE:C9:BC:4C:14:2D:0D:81:19:D0:E7:B0'
            : 'FE:A0:C3:77:E7:83:B6:5B:D9:78:6F:6B:8D:55:8A:B1:32:9E:8B:7E',
      };

      debugPrint("Translation Request Headers: $headers");

      final response = await http.post(
        url,
        headers: headers,
        body: {
          'q': text,
          'target': targetLang,
          'format': 'text',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null &&
            data['data']['translations'] != null &&
            data['data']['translations'].isNotEmpty) {
          String translatedText =
              data['data']['translations'][0]['translatedText'];

          // Fix HTML entities if any (basic ones)
          translatedText = translatedText
              .replaceAll('&amp;', '&')
              .replaceAll('&quot;', '"')
              .replaceAll('&#39;', "'")
              .replaceAll('&lt;', '<')
              .replaceAll('&gt;', '>');

          translationCache[cacheKey] = translatedText;
          return translatedText;
        }
        return text;
      } else {
        debugPrint("Translation API Error: ${response.body}");
        return text;
      }
    } catch (e) {
      debugPrint("Translation Error: $e");
      return text;
    }
  }
}
