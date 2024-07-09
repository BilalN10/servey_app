import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
           centerTitle: true,
           title: const CustomText(text:AppStaticStrings.newPass,fontWeight: FontWeight.w500,fontSize: 24,),
           ),
           body: SingleChildScrollView(
             padding: EdgeInsets.symmetric(horizontal: 24.w),
             child: Form(
               child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
               ///<================================= this is for password =====================>
               CustomText(
                 text: AppStaticStrings.password,
                 bottom: 16.h,
                 fontWeight: FontWeight.w400,
                 fontSize: 16,
                 top: 16.h,
               ),

               const CustomTextField(
                 isPassword: true,
                 hintText: AppStaticStrings.enterYourPassword,
                 fillColor: AppColors.blueLight,
               ),

               ///<===================== This is the Confirm password section ========================>

               CustomText(
                 text: AppStaticStrings.confirmPass,
                 bottom: 16.h,
                 fontWeight: FontWeight.w400,
                 fontSize: 16,
                 top: 16.h,
               ),

               const CustomTextField(
                 isPassword: true,
                 hintText: AppStaticStrings.enterYourPassword,
                 fillColor: AppColors.blueLight,
               ),

               SizedBox(height: 308.h,),


               CustomButton(onTap:(){
               Get.offNamed(AppRoute.signInScreen);
               },fillColor: AppColors.yellowNormal,title: AppStaticStrings.submit,),
               ],
               ),
             ),
           ),
    );
  }
}
