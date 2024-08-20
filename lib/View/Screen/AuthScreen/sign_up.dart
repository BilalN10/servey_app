import 'package:flutter/gestures.dart';
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

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24.h,
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
                        text: AppStaticStrings.signUp,
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

                  CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStaticStrings.enterValidEmail;
                      } else if (!AppStaticStrings.emailRegexp.hasMatch(
                          authController.signUPEmailController.text)) {
                        return AppStaticStrings.enterValidEmail;
                      } else {
                        return null;
                      }
                    },
                    textEditingController: authController.signUPEmailController,
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

                  CustomTextField(
                    textEditingController: authController.signUPPassController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppStaticStrings.passWordMustBeAtLeast;
                      } else if (value.length < 8 ||
                          !AppStaticStrings.passRegexp.hasMatch(value)) {
                        return AppStaticStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
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

                  CustomTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppStaticStrings.fieldCantNotBeEmpty;
                      } else if (value !=
                          authController.signUPPassController.text) {
                        return "Password should match";
                      }
                      return null;
                    },
                    textEditingController:
                        authController.signUPConfiPassController,
                    isPassword: true,
                    hintText: AppStaticStrings.enterYourPassword,
                    fillColor: AppColors.blueLight,
                  ),

                  SizedBox(
                    height: 16.h,
                  ),

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

                      SizedBox(
                        width: 10.w,
                      ),

                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: AppStaticStrings.byRegistasion,
                                style: TextStyle(
                                  color: AppColors.blueDarker,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: " ${AppStaticStrings.termsAndCondition}",
                                style: const TextStyle(
                                    color: AppColors.yellowNormal,
                                    fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(
                                        AppRoute.termsAndConditionScreen);
                                  },
                              ),
                              const TextSpan(
                                text: " and ",
                                style: TextStyle(
                                  color: AppColors.blueDarker,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "${AppStaticStrings.privacyPolicy}.",
                                style: const TextStyle(
                                    color: AppColors.yellowNormal,
                                    fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoute.privacyPolicyScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 52.h,
                  ),

                  ///<======================= This is the signUp button =====================>

                  CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        authController.signUp();
                      }
                    },
                    fillColor: AppColors.yellowNormal,
                    title: AppStaticStrings.signUp,
                  ),

                  SizedBox(
                    height: 16.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(text: "If you have an account?   "),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.signInScreen);
                          },
                          child: const CustomText(
                            text: AppStaticStrings.login,
                            color: AppColors.yellowDark,
                          )),
                    ],
                  ),

                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
