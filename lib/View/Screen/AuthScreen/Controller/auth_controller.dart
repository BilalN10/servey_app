import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
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

  ///<==================== This is verify otp ======================>

  TextEditingController otpController = TextEditingController();

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
}
