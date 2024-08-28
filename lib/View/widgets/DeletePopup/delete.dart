import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class DeletePopup extends StatelessWidget {
  DeletePopup({
    super.key,
  });
  // final TextEditingController controller;

  // final void Function()? onTap;

  final GeneralController generalController = Get.find<GeneralController>();

  final TextEditingController passController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();

  final scaffoldkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: scaffoldkey,
      child: Column(
        children: [
          CustomText(
            fontSize: 14.r,
            fontWeight: FontWeight.w600,
            text: "We will miss you a lot",
            maxLines: 3,
            top: 8.h,
            bottom: 40.h,
          ),

          CustomText(
            text:
                "Why do you want to delete the account? Enter the reason in the form below",
            maxLines: 3,
            top: 8.h,
            bottom: 40.h,
          ),

          CustomTextField(
            validator: (value) {
              if (value.isEmpty) {
                return AppStaticStrings.fieldCantNotBeEmpty;
              }
              return null;
            },
            hintStyle: TextStyle(fontSize: 12.r),
            fieldBorderColor: AppColors.blueDark,
            textEditingController: passController,
            hintText: "Enter your Password",
          ),
          SizedBox(
            height: 8.h,
          ),

          CustomTextField(
            validator: (value) {
              if (value.isEmpty) {
                return AppStaticStrings.fieldCantNotBeEmpty;
              }
              return null;
            },
            hintStyle: TextStyle(fontSize: 12.r),
            fieldBorderColor: AppColors.blueDark,
            textEditingController: confPassController,
            hintText: "Enter your password again",
          ),
          SizedBox(
            height: 50.h,
          ),

          ///<============================ This is the send request button ===========================>
          Center(
            child: GestureDetector(
              onTap: () {
                if (scaffoldkey.currentState!.validate()) {
                  generalController.deleteAccount(
                      passController: passController,
                      confPassController: confPassController);
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: AppColors.blueNormal),
                  borderRadius: BorderRadius.circular(90.r),
                ),
                child: const CustomText(
                  text: "Send Request",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.blueNormal,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 40.w,
          ),
        ],
      ),
    );
  }
}
