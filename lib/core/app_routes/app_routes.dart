

import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/sign_in.dart';
import 'package:survey_markus/View/Screen/AuthScreen/sign_up.dart';
import 'package:survey_markus/View/Screen/HomeScreen/home.dart';
import 'package:survey_markus/View/Screen/SplashScreen/splash.dart';
import 'package:survey_markus/View/Screen/profile_screen/edit_profile_screen/edit_profile_screen.dart';

class AppRoute {
  ///==================== Initial Routes ====================

  static const String splashScreen ="/splash_screen";

  ///<======================== Auth section ========================>
  static const String signInScreen="/signIn";
  static const String signUpScreen="/signUp";

  ///=========================Profile==================
  static const String editProfileScreen="/EditProfileScreen";






  static const String homeScreen = "/homeScreen";

  static List<GetPage> routes = [

    GetPage(name: splashScreen, page: () => const SplashScreen()),

///<=============================== Auth Section ============================>

    GetPage(name: signInScreen, page: () =>  SignInScreen()),
    GetPage(name: signUpScreen, page: () =>  SignUpScreen()),



///<========================= Home section ====================>
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
  ];
}
