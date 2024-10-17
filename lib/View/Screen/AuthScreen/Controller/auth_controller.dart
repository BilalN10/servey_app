import 'dart:async';
import 'package:http/http.dart' as http;

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
  bool isAgree = false;

  GeneralController generalController = Get.find<GeneralController>();

  ///======================= Is Remember Me =======================
  updateRememberMe() async {
    isRemember = !isRemember;
    update();
    SharePrefsHelper.setBool(AppConstants.isRemember, isRemember);
  }

  updateAgree() async {
    isAgree = !isAgree;
    update();
  }

  TextEditingController signInEmailController =
      TextEditingController(text: kDebugMode ? "mdh95831@gmail.com" : "");
  TextEditingController signInPassController =
      TextEditingController(text: kDebugMode ? "1234567Rr" : "");

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
    if (!isAgree) {
      return toastMessage(message: "Please agree with our terms & privacy");
    }
    var client = http.Client();
    String bearerToken =
        await SharePrefsHelper.getString(SharedPreferenceValue.token);
    generalController.showPopUpLoader();

    Map<String, String> body = {
      "role_type": "EMPLOYEE",
      "email": signUPEmailController.text,
      "password": signUPPassController.text,
      "password_confirmation": signUPConfiPassController.text,
    };

    http.Response response = await client.post(
      Uri.parse(ApiUrl.baseUrl + ApiUrl.register),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearerToken'
      },
    );
    debugPrint('====> API Call: ${ApiUrl.baseUrl}${ApiUrl.register}');
    debugPrint('====> API Body: $body');
    debugPrint('====> API Response: ${response.body}');

    if (response.statusCode == 200) {
      navigator!.pop();

      startTimer();
      Get.toNamed(AppRoute.otpVerifiedScreen);
    } else if (response.statusCode == 400) {
      navigator!.pop();
      toastMessage(
        message: "Email already taken. Please use a different email address.",
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

  ///=============================== Verify OTP Forget =============================

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

  ///=============================== Verify OTP Sign Up =============================
  RxInt secondsRemaining = 60.obs;
  late Timer timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        timer.cancel();
      }
    });
  }

  RxString otp = "".obs;
  Future<void> verifyOTPSignUp() async {
    generalController.showPopUpLoader();
    var body = {
      "otp": otp.value,
    };
    var response =
        await ApiClient.postData(ApiUrl.emailVarify, body, contentType: false);

    if (response.statusCode == 200) {
      SharePrefsHelper.setString(SharedPreferenceValue.token,
          response.body["token"]["original"]["access_token"]);
      Get.offAllNamed(AppRoute.homeScreen);
    } else {
      navigator?.pop();
      toastMessage(message: response.body["message"]);
    }
  }

  ///=============================== Resend OTP =============================

  Future<bool> resendOTP() async {
    generalController.showPopUpLoader();
    var response = await ApiClient.postData(
        ApiUrl.resendOTP, {"email": signUPEmailController.text},
        contentType: false);

    if (response.statusCode == 200) {
      secondsRemaining.value = 60;
      startTimer();
      toastMessage(message: response.body["message"], color: Colors.green);
      navigator?.pop();
      return true;
    } else {
      toastMessage(message: response.body["message"]);
      navigator?.pop();
      return false;
    }
  }
}
