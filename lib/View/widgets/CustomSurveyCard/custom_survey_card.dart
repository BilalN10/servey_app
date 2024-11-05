import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class CustomSurveyCard extends StatelessWidget {
  const CustomSurveyCard(
      {super.key,
      required this.image,
      required this.companyName,
      required this.buttonText,
      this.onTap});
  final String image;
  final String companyName;
  final String buttonText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.r),
      padding: EdgeInsets.symmetric(horizontal: 76.w, vertical: 9.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColors.yellowNormal),
      child: Column(
        children: [
          ///<=================== This is the company image section ==================>

          CustomNetworkImage(
            imageUrl: image,
            height: 78.h,
            width: 78.w,
            borderRadius: BorderRadius.circular(8.r),
          ),

          CustomText(
            text: companyName,
            color: AppColors.whiteNormal,
            maxLines: 10,
            top: 8.h,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),

          SizedBox(
            height: 12.h,
          ),

          ///<============================ This is the join button ==========================>

          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: AppColors.whiteNormal),
              child: CustomText(
                text: buttonText,
                color: AppColors.yellowNormal,
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
