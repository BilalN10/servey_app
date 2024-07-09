import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ForgotOtp extends StatefulWidget{
  const ForgotOtp({super.key});

  @override
  State<ForgotOtp> createState() => _ForgotOtpState();
}

class _ForgotOtpState extends State<ForgotOtp> {
  int _secondsRemaining = 120;

  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {

          _secondsRemaining--;

        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState(){
    //startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: AppStaticStrings.verification,fontWeight: FontWeight.w500,fontSize: 24,
        ),
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 24.h,horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 98.h,),
                  ///==============================Enter 4 digit code ===========================
                  CustomText(
                    textAlign: TextAlign.start,
                    text:"Enter 4 digits code",
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
                    length: 4,
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
                    textStyle:
                    const TextStyle(color: AppColors.whiteNormal, fontSize: 24),
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
                      errorBorderColor:Colors.red,
                      activeBorderWidth:0,
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
                        fontSize: 14.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          // if (_secondsRemaining == 0) {
                          //   _secondsRemaining = 120;
                          //   startTimer();
                          //   controller.handleForgetPassword().then((value) {
                          //     if (value == false) {
                          //       setState(() {
                          //         _timer.cancel();
                          //         _secondsRemaining = 0;
                          //       });
                          //     }
                          //   });
                          // }
                        },
                        child: CustomText(
                            text: _secondsRemaining == 0
                                ? "Resend OTP".tr
                                : "Resend SMS $_secondsRemaining",
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
                onTap: (){
                  Get.offNamed(AppRoute.resetPassScreen);
                },
                title:"Verify code",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
