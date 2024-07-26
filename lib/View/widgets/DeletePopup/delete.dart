import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class DeletePopup extends StatelessWidget {
  const DeletePopup({super.key, required this.controller, required this.onTap});
  final TextEditingController controller;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
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
          textEditingController: controller,
          hintText: "Enter your valid reason",
        ),
        SizedBox(
          height: 50.h,
        ),

        ///<============================ This is the send request button ===========================>
        Center(
          child: Expanded(
            child: GestureDetector(
              onTap: onTap,
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
        ),

        SizedBox(
          width: 40.w,
        ),
      ],
    );
  }
}
