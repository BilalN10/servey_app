
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigate()async{
    bool? onBoarding = await SharePrefsHelper.getBool(AppConstants.onBoard);

    bool? isRememberMe =
    await SharePrefsHelper.getBool(AppConstants.isRemember);
    print("This value is    bool value =========${isRememberMe}");
    Future.delayed(const Duration(seconds: 3),(){
        if(isRememberMe==true && isRememberMe!=null){
          Get.offAllNamed(AppRoute.homeScreen);
        }else{Get.offAllNamed(AppRoute.signInScreen);
        }
    });
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
           body:Container(
           color:AppColors.blueNormal,
           height: double.maxFinite,
           width: double.maxFinite,
           child:CustomImage(imageSrc:AppImages.splashLogo,imageType: ImageType.png,size: 242.r,horizontal: 60.w,vertical: 60.h,)
           ),

    );
  }
}
