import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      TextEditingController(text: kDebugMode ? "mdh95831@gmail.com" : "");
  TextEditingController signInPassController =
      TextEditingController(text: kDebugMode ? "1234567RRr" : "");

  TextEditingController signUPEmailController =
      TextEditingController(text: kDebugMode ? "employee2@gmail.com" : "");
  TextEditingController signUPPassController =
      TextEditingController(text: kDebugMode ? "1234567Rr" : "");

  TextEditingController signUPConfiPassController =
      TextEditingController(text: kDebugMode ? "1234567Rr" : "");

  TextEditingController otpController = TextEditingController();

  ///<============================= Sign In User =============================>

  signIn() async {
    generalController.showPopUpLoader();

    var body = {
      "email": signInEmailController.text,
      "password": signInPassController.text
    };
    var response =
        await ApiClient.postData(ApiUrl.login, body, contentType: false);
    if (response.statusCode == 200) {
      SharePrefsHelper.setString(
          SharedPreferenceValue.token, response.body["access_token"]);
      clearTxtFields();
      navigator!.pop();

      Get.offAllNamed(AppRoute.homeScreen);
    } else {
      navigator!.pop();

      toastMessage(
        message: response.body["message"],
      );
    }
  }

  ///<============================== Sign Up User =============================>
  signUp() async {
    generalController.showPopUpLoader();

    Map<String, String> body = {
      "role_type": "EMPLOYEE",
      "email": signUPEmailController.text,
      "password": signUPPassController.text,
      "password_confirmation": signUPConfiPassController.text,
    };

    var response =
        await ApiClient.postData(ApiUrl.register, body, contentType: false);
    if (response.statusCode == 200) {
      clearTxtFields();
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

  ///======================== Clear all Text Editing Field ==========================
  clearTxtFields() {
    // signInEmailController.clear();
    // signInPassController.clear();
    // signUPEmailController.clear();
    // signUPConfiPassController.clear();
    // signUPPassController.clear();
    // otpController.clear();
  }

  ///=============================== Forget Password =============================
  Future<bool> forgetPass({bool navigate = true}) async {
    generalController.showPopUpLoader();
    var body = {
      "email": signInEmailController.text,
    };
    var response =
        await ApiClient.postData(ApiUrl.forgetPass, body, contentType: false);

    if (response.statusCode == 200) {
      navigator?.pop();
      if (navigate) {
        Get.toNamed(AppRoute.forgotOTP);
      }
      toastMessage(message: response.body["message"], color: Colors.green);
      return true;
    } else {
      navigator?.pop();
      toastMessage(message: response.body["message"]);
      return false;
    }
  }

  ///=============================== Verify OTP =============================

  Future<void> verifyOTP() async {
    generalController.showPopUpLoader();
    var body = {
      "otp": otpController.text,
    };
    var response =
        await ApiClient.postData(ApiUrl.emailVarify, body, contentType: false);

    if (response.statusCode == 200) {
      navigator?.pop();
      Get.offNamed(AppRoute.resetPassScreen);
    } else {
      navigator?.pop();
      toastMessage(message: response.body["message"]);
    }
  }

  ///=============================== Set New Password =============================
  setNewPass() async {
    generalController.showPopUpLoader();
    var body = {
      "email": signInEmailController.text,
      "password": signUPPassController.text,
      "password_confirmation": signUPConfiPassController.text
    };
    var response =
        await ApiClient.postData(ApiUrl.resetPass, body, contentType: false);

    if (response.statusCode == 200) {
      navigator?.pop();
      Get.offAllNamed(AppRoute.signInScreen);
    } else {
      navigator?.pop();
      toastMessage(message: response.body["message"]);
    }
  }
}
