import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/Controller/auth_controller.dart';
import 'package:survey_markus/View/Screen/HistoryScreen/controller/history_controller.dart';
import 'package:survey_markus/View/Screen/HomeScreen/controller/home_controller.dart';
import 'package:survey_markus/View/Screen/SurveyHistory/controller/que_report_controller.dart';
import 'package:survey_markus/View/Screen/all_survey_company/controller/companylist_controller.dart';
import 'package:survey_markus/View/Screen/notification_screen/controller/notification_controller.dart';
import 'package:survey_markus/View/Screen/privacy_policy_screen/controller/privacy_controller.dart';
import 'package:survey_markus/View/Screen/profile_screen/controller/profilecontroller.dart';
import 'package:survey_markus/View/Screen/terms_and_condition_screen/controller/terms_controller.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Controller/surve_controller.dart';

class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    // ///================ General Controller =================
    Get.lazyPut(() => GeneralController(), fenix: true);

    ///================ Auth Controller =================

    Get.lazyPut(() => AuthController(), fenix: true);

    ///================ Profile Controller =================

    Get.lazyPut(() => ProfileController(), fenix: true);

    ///================ Servey Controller =================

    Get.lazyPut(() => SurveyController(), fenix: true);

    ///================ Company Controller =================

    Get.lazyPut(() => CompanyListController(), fenix: true);

    // ///================ Home Controller =================

    Get.lazyPut(() => HomeControl(), fenix: true);

    ///================ Question Report Controller =================

    Get.lazyPut(() => QuestionReportController(), fenix: true);

    ///================ Privacy Controller =================

    Get.lazyPut(() => PrivacyController(), fenix: true);

    ///================ Terms and Condition Controller =================

    Get.lazyPut(() => TermsController(), fenix: true);

    ///================ History Controller =================

    Get.lazyPut(() => HistoryController(), fenix: true);

    ///================ Notification Controller =================

    Get.lazyPut(() => MyNotificationController(), fenix: true);
  }
}
