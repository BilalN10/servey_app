import 'package:get/get.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode == 401) {
      await SharePrefsHelper.remove(SharedPreferenceValue.token);
      await SharePrefsHelper.remove(SharedPreferenceValue.isRemember);

      Get.offAllNamed(AppRoute.signInScreen);
    } else {
      showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
    }
  }
}
