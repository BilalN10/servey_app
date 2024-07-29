import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AllResultScreen/all_result.dart';
import 'package:survey_markus/View/Screen/AllSurveyScreen/all_survey_screen.dart';
import 'package:survey_markus/View/Screen/Allproject/all_project_screen.dart';
import 'package:survey_markus/View/Screen/AuthScreen/otp_verified_screen.dart';
import 'package:survey_markus/View/Screen/AuthScreen/sign_in.dart';
import 'package:survey_markus/View/Screen/AuthScreen/sign_up.dart';
import 'package:survey_markus/View/Screen/ForgotPassScreen/forgot_otp.dart';
import 'package:survey_markus/View/Screen/ForgotPassScreen/forgot_pass.dart';
import 'package:survey_markus/View/Screen/ForgotPassScreen/reset_pass.dart';
import 'package:survey_markus/View/Screen/HistoryScreen/history.dart';
import 'package:survey_markus/View/Screen/HomeScreen/home.dart';
import 'package:survey_markus/View/Screen/Result/result.dart';
import 'package:survey_markus/View/Screen/SplashScreen/splash.dart';
import 'package:survey_markus/View/Screen/SurveyHistory/survey_history.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/main_survey.dart';
import 'package:survey_markus/View/Screen/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:survey_markus/View/Screen/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:survey_markus/View/Screen/profile_screen/profile_screen.dart';
import 'package:survey_markus/View/Screen/scan_qr_code_screen/scan_qr_code_screen.dart';
import 'package:survey_markus/View/Screen/terms_and_condition_screen/terms_and_condition_screen.dart';

class AppRoute {
  ///==================== Initial Routes ====================

  static const String splashScreen = "/splash_screen";

  ///<======================== Auth section ========================>
  static const String signInScreen = "/signIn";
  static const String signUpScreen = "/signUp";
  static const String otpVerifiedScreen = "/otpVerifiedScreen";
  static const String forgotOTP = "/forgotOTP";

  ///=========================Profile==================
  static const String editProfileScreen = "/EditProfileScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String scanQrCodeScreen = "/ScanQrCodeScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String termsAndConditionScreen = "/TermsAndConditionScreen";

  ///<================================== This is for forgot pass ========================>
  static const String forgotPass = "/forgotPass";
  static const String resetPassScreen = "/resetPassScreen";

  ///<=============================== All project  section ========================>

  static const String allProjectScreen = "/allProjectScreen";

  ///<========================== This is the all survey section =====================>

  static const String allSurvey = "/allSurvey";

  ///<==================== This is the main survey  ===============================>

  static const String mainSurvey = "/mainSurvey";

  ///<======================= All result screen ====================================>

  static const String allResultScreeen = "/allResultScreeen";

  ///<====================== This is for  survey history =========================>

  static const String surveyHistoryScreen = "/surveyHistoryScreen";

  static const String historyScreen = "/historyScreen";
  static const String resultScreen = "/resultScreen";

  static const String homeScreen = "/homeScreen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),

    ///<=============================== Auth Section ============================>

    GetPage(name: signInScreen, page: () => SignInScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: otpVerifiedScreen, page: () => const OtpVerifiedScreen()),
    GetPage(name: forgotOTP, page: () => const ForgotOtp()),

    ///<========================= Home section ====================>
    GetPage(name: homeScreen, page: () => HomeScreen()),

    ///<======================== This is the all survey section =====================>
    GetPage(name: allProjectScreen, page: () => const AllProjectScreen()),

    ///========================Profile=======================
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: scanQrCodeScreen, page: () => const ScanQrCodeScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(
        name: termsAndConditionScreen,
        page: () => const TermsAndConditionScreen()),

    ///<========================= Forgot pass section ====================>
    GetPage(name: forgotPass, page: () => ForgotPassScreen()),

    GetPage(name: resetPassScreen, page: () => ResetPassScreen()),

    ///<======================== this is for  all survey section ===================>

    GetPage(name: allSurvey, page: () => const AllSurveyScreen()),

    ///<====================== This is for main Survey ===========================>
    GetPage(name: mainSurvey, page: () => MainSurveySCreen()),

    ///<============================== All result screen ==========================>

    GetPage(name: allResultScreeen, page: () => const AllResultScreen()),

    ///<========================== This is for survey screden =========================>

    GetPage(name: surveyHistoryScreen, page: () => const SurveyHistory()),

    GetPage(name: historyScreen, page: () => const HistoryScreen()),

    GetPage(name: resultScreen, page: () => const ResultScreen()),
  ];
}
