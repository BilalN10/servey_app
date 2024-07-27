import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/AuthScreen/Controller/auth_controller.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ResetPassScreen extends StatelessWidget {
  ResetPassScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: AppStaticStrings.newPass,
          fontWeight: FontWeight.w500,
          fontSize: 24,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: formKey,
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
                textEditingController: authController.signUPConfiPassController,
                isPassword: true,
                hintText: AppStaticStrings.enterYourPassword,
                fillColor: AppColors.blueLight,
              ),

              SizedBox(
                height: 308.h,
              ),

              CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    authController.setNewPass();
                  }
                },
                fillColor: AppColors.yellowNormal,
                title: AppStaticStrings.submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
