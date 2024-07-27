import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/Controller/auth_controller.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 217.h),
              Center(
                  child: CustomImage(
                imageSrc: AppImages.forgotPassImage,
                imageType: ImageType.png,
                size: 166.r,
              )),

              ///<========================================= This is forgot password text ========================>
              Center(
                  child: CustomText(
                text: AppStaticStrings.forgotPassword,
                top: 25.h,
                fontSize: 25,
                bottom: 24.h,
                fontWeight: FontWeight.w500,
              )),

              ///<============================== This is the  dont worry text ===============================>

              Center(
                  child: CustomText(
                text: AppStaticStrings.dontWorry,
                fontSize: 12,
                bottom: 40.h,
                fontWeight: FontWeight.w400,
                maxLines: 3,
              )),

              ///<=========================== This is the  email section ============================>

              CustomText(
                text: AppStaticStrings.email,
                bottom: 16.h,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),

              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStaticStrings.enterValidEmail;
                  } else if (!AppStaticStrings.emailRegexp
                      .hasMatch(authController.signInEmailController.text)) {
                    return AppStaticStrings.enterValidEmail;
                  } else {
                    return null;
                  }
                },
                textEditingController: authController.signInEmailController,
                hintText: AppStaticStrings.enterYourEmail,
                fillColor: AppColors.blueLight,
              ),

              SizedBox(
                height: 71.h,
              ),

              ///<================================= This is the    button ==================>

              CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    authController.forgetPass();
                  }
                },
                fillColor: AppColors.yellowNormal,
                title: AppStaticStrings.sendCode,
              ),
              SizedBox(
                height: 97.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
