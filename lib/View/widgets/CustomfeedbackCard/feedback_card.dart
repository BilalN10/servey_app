import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class FeedbackCard extends StatelessWidget {
   FeedbackCard({super.key,required this.title,this.onTap});
  String title;
   void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 155.h,
        width: 155.w,
        decoration: BoxDecoration(
          color: AppColors.yellowNormal,
          borderRadius: BorderRadius.circular(8.r),

        ),
         padding: EdgeInsets.symmetric(horizontal: 39.w,vertical: 34.h),
        child:  Center(
          child: CustomText(
          maxLines:3,
          text:title,
          color: AppColors.whiteNormal,
          fontSize:14,
          fontWeight: FontWeight.w600,

          ),
        ),
      ),
    );
  }
}
