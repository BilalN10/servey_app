import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class AuthController extends GetxController{

  bool isRemember=false;
  ///======================= Is Remember Me =======================
  updateRememberMe() async {
    isRemember  = !isRemember ;
    update();
    SharePrefsHelper.setBool(AppConstants.isRemember, isRemember);
  }



  TextEditingController signInEmailController= TextEditingController();
  TextEditingController signInPassController= TextEditingController();

  ///<==================== This is verify otp ======================>

   TextEditingController otpController=TextEditingController();


  //
  // TextEditingController signInEmailController= TextEditingController();
  // TextEditingController signInEmailController= TextEditingController();

}