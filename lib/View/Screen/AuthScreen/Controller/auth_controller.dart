import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class AuthController extends GetxController {
  bool isRemember = false;
  GeneralController generalController = Get.find<GeneralController>();

  ///======================= Is Remember Me =======================
  updateRememberMe() async {
    isRemember = !isRemember;
    update();
    SharePrefsHelper.setBool(AppConstants.isRemember, isRemember);
  }

  TextEditingController signInEmailController =
      TextEditingController(text: kDebugMode ? "employee@gmail.com" : "");
  TextEditingController signInPassController =
      TextEditingController(text: kDebugMode ? "1234567rr" : "");

  TextEditingController signUPEmailController =
      TextEditingController(text: kDebugMode ? "employee2@gmail.com" : "");
  TextEditingController signUPPassController =
      TextEditingController(text: kDebugMode ? "1234567rr" : "");

  TextEditingController signUPConfiPassController =
      TextEditingController(text: kDebugMode ? "1234567rr" : "");

  TextEditingController otpController = TextEditingController();

  ///<==================== Sign In User ======================>

  signIn() async {
    generalController.showPopUpLoader();

    var body = {
      "email": signInEmailController.text,
      "password": signInPassController.text
    };
    var response = await ApiClient.postData(ApiUrl.login, body);
    if (response.statusCode == 200) {
      SharePrefsHelper.setString(
          SharedPreferenceValue.token, response.body["access_token"]);
      navigator!.pop();

      Get.offAllNamed(AppRoute.homeScreen);
    } else {
      navigator!.pop();

      toastMessage(
        message: response.body["message"],
      );
    }
  }

  ///<==================== Sign Up User ======================>
  signUp() async {
    generalController.showPopUpLoader();

    var body = {
      "role_type": "EMPLOYEE",
      "email": signUPEmailController.text,
      "password": signUPPassController.text,
      "password_confirmation": signUPConfiPassController.text,
    };

    var response = await ApiClient.postData(ApiUrl.login, body);
    if (response.statusCode == 200) {
      navigator!.pop();
      Get.toNamed(AppRoute.otpVerifiedScreen);
    } else if (response.statusCode == 400) {
      navigator!.pop();

      toastMessage(
        message: response.body["message"]["email"][0] ??
            AppStaticStrings.somethingWentWrong,
      );
    } else {
      navigator!.pop();
      toastMessage(
        message: AppStaticStrings.somethingWentWrong,
      );
    }
  }
}
