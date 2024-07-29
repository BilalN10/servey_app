import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/Controller/auth_controller.dart';
import 'package:survey_markus/View/Screen/profile_screen/controller/profilecontroller.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';

class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    // ///================ General Controller =================
    Get.lazyPut(() => GeneralController(), fenix: true);

    // ///================ Home Controller =================
    // Get.lazyPut(() => HomeController(), fenix: true);

    ///================ Auth Controller =================

    Get.lazyPut(() => AuthController(), fenix: true);

    ///================ Profile Controller =================

    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
