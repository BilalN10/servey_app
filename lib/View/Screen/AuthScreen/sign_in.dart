import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/Controller/auth_controller.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GetBuilder<AuthController>(builder:(controller){
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                SizedBox(
                  height: 77.h,
                ),

                SizedBox(
                  height: 64.h,
                ),

                ///<============== This is logo section =====================>
                Align(
                    alignment: AlignmentDirectional.center,
                    child: CustomImage(
                      imageSrc: AppImages.signInAndSignUpIcon,
                      imageType: ImageType.png,
                      size: 102.r,
                    )),

                ///<============== This is Sign In text =====================>
                Align(
                    alignment: AlignmentDirectional.center,
                    child: CustomText(
                      text: AppStaticStrings.logIn,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      top: 24.h,
                      bottom: 19.h,
                    )),

                ///<===================== This is the email section ========================>

                CustomText(
                  text: AppStaticStrings.email,
                  bottom: 16.h,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),

                const CustomTextField(
                  hintText: AppStaticStrings.enterYourEmail,
                  fillColor: AppColors.blueLight,
                ),

                ///<===================== This is the password section ========================>

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

                SizedBox(
                  height: 16.h,
                ),

                ///<========================= This is the  remember section =====================>

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ///================ Remember me ===============

                        GestureDetector(
                          onTap: () {
                            controller.updateRememberMe();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 8,
                                    color: Colors.black.withOpacity(.15))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: controller.isRemember
                                  ? const Icon(
                                      Icons.check,
                                      color: AppColors.blueNormal,
                                      size: 24,
                                    )
                                  : const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                            ),
                          ),
                        ),

                        const CustomText(
                          left: 10,
                          text: 'Remember me',
                          fontSize: 12,
                        )
                      ],
                    ),
                    GestureDetector(
                        child: const CustomText(
                            text: AppStaticStrings.forgotPassword)),
                  ],
                ),

                SizedBox(
                  height: 52.h,
                ),

                ///<======================= This is the Login button =====================>

                CustomButton(
                  onTap: () {
                   Get.toNamed(AppRoute.homeScreen);
                  },
                  fillColor: AppColors.yellowNormal,
                  title: AppStaticStrings.login,
                ),

                SizedBox(
                  height: 16.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        text: "${AppStaticStrings.dontHaveAcount}?  "),
                    GestureDetector(
                        onTap: () {
                        Get.toNamed(AppRoute.signUpScreen);
                        },
                        child: const CustomText(
                          text: AppStaticStrings.signUp,
                          color: AppColors.yellowDark,
                        )),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
