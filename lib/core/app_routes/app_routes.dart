

import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/sign_in.dart';
import 'package:survey_markus/View/Screen/AuthScreen/sign_up.dart';
import 'package:survey_markus/View/Screen/HomeScreen/home.dart';
import 'package:survey_markus/View/Screen/SplashScreen/splash.dart';
import 'package:survey_markus/View/Screen/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:survey_markus/View/Screen/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:survey_markus/View/Screen/profile_screen/profile_screen.dart';
import 'package:survey_markus/View/Screen/scan_qr_code_screen/scan_qr_code_screen.dart';
import 'package:survey_markus/View/Screen/terms_and_condition_screen/terms_and_condition_screen.dart';

class AppRoute {
  ///==================== Initial Routes ====================

  static const String splashScreen ="/splash_screen";

  ///<======================== Auth section ========================>
  static const String signInScreen="/signIn";
  static const String signUpScreen="/signUp";

  ///=========================Profile==================
  static const String editProfileScreen="/EditProfileScreen";
  static const String profileScreen="/ProfileScreen";
  static const String scanQrCodeScreen="/ScanQrCodeScreen";
  static const String privacyPolicyScreen="/PrivacyPolicyScreen";
  static const String termsAndConditionScreen="/TermsAndConditionScreen";






  static const String homeScreen = "/homeScreen";

  static List<GetPage> routes = [

    GetPage(name: splashScreen, page: () => const SplashScreen()),

///<=============================== Auth Section ============================>

    GetPage(name: signInScreen, page: () =>  SignInScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),



///<========================= Home section ====================>
    GetPage(name: homeScreen, page: () =>  HomeScreen()),

    ///========================Profile=======================
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: scanQrCodeScreen, page: () => const ScanQrCodeScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsAndConditionScreen, page: () => const TermsAndConditionScreen()),
  ];
}
