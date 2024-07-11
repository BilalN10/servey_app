
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/Controller/auth_controller.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Controller/surve_controller.dart';

class DependancyInjection extends Bindings {
  @override
  void dependencies() {

    // ///================ Home Controller =================
    // Get.lazyPut(() => HomeController(), fenix: true);
    //
    ///================ Auth Controller =================
    //
    Get.lazyPut(() => AuthController(), fenix: true);

    Get.lazyPut(() => SurveController(), fenix: true);





  }
}
