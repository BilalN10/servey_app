import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard(
      {super.key,
      required this.title,
      this.onTap,
      this.backGroundColor = AppColors.yellowNormal});
  final String title;
  final void Function()? onTap;
  final Color backGroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
        child: Center(
          child: CustomText(
            maxLines: 3,
            text: title,
            color: AppColors.whiteNormal,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
