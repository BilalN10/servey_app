import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:survey_markus/View/Screen/AuthScreen/Controller/auth_controller.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class OtpVerifiedScreen extends StatelessWidget {
  OtpVerifiedScreen({super.key});

  final AuthController controller = Get.find<AuthController>();

  // @override
  // void dispose() {
  //   _timer.cancel(); // Cancel the timer to avoid memory leaks
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: AppStaticStrings.verification,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        body: Obx(() {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 98.h,
                      ),

                      ///==============================Enter 4 digit code ===========================
                      CustomText(
                        textAlign: TextAlign.start,
                        text: "Enter 6 digits code",
                        fontSize: 24.w,
                        fontWeight: FontWeight.w500,
                        bottom: 12.h,
                      ),

                      // ///==============================email verification Text===========================
                      // CustomText(
                      //   textAlign: TextAlign.start,
                      //   maxLines: 2,
                      //   text:"Enter the 6 digits code that you received on your email",
                      //   fontSize: 14.w,
                      // ),
                      //

                      SizedBox(
                        height: 40.h,
                      ),

                      ///<====================== otp field =======================>

                      PinCodeTextField(
                        // controller:controller.otpController,
                        length: 6,
                        cursorColor: AppColors.yellowNormal,
                        keyboardType: TextInputType.text,
                        enablePinAutofill: true,
                        appContext: (context),
                        onCompleted: (value) {
                          // controller.otp = value.toString();
                          //controller.update();

                          //  print("=-=-==-=-=--==-=-=-=-=-=-=-=-This is an otp ${controller.otp}");
                        },
                        autoFocus: true,
                        textStyle: const TextStyle(
                            color: AppColors.whiteNormal, fontSize: 24),
                        pinTheme: PinTheme(
                          disabledColor: Colors.transparent,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 54.h,
                          fieldWidth: 44,
                          activeFillColor: AppColors.yellowNormal,
                          selectedFillColor: AppColors.yellowNormal,
                          inactiveFillColor: AppColors.grayDark,
                          borderWidth: 0.5,
                          errorBorderColor: Colors.red,
                          activeBorderWidth: 0,
                          selectedColor: AppColors.whiteNormal,
                          inactiveColor: const Color(0xFFCCCCCC),
                          activeColor: AppColors.whiteNormal,
                        ),
                        enableActiveFill: true,
                      ),

                      SizedBox(
                        height: 24.h,
                      ),

                      /// <================= send again =======================>

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "I didn't find confirmation code",
                            fontSize: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.secondsRemaining.value == 0) {
                                controller.secondsRemaining.value = 3;
                                controller.startTimer();
                                controller.resendOTP().then((value) {
                                  if (value == false) {
                                    controller.timer.cancel();
                                    controller.secondsRemaining.value = 0;
                                  }
                                });
                              }
                            },
                            child: CustomText(
                                text: controller.secondsRemaining.value == 0
                                    ? "Resend OTP".tr
                                    : "Resend OTP in ${controller.secondsRemaining}",
                                color: AppColors.redColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),

                  ///<=====================  button ========================>

                  CustomButton(
                    fillColor: AppColors.yellowNormal,
                    onTap: () {
                      Get.toNamed(AppRoute.homeScreen);
                    },
                    title: "Verify code",
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
