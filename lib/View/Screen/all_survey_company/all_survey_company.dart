import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class AllSurveyCompany extends StatelessWidget {
  const AllSurveyCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 1),
      backgroundColor: AppColors.backgroundColor,

      ///=====================All Survey Company Appbar================
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: CustomText(
          text: AppStaticStrings.allSurveyCompany,
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.grayDarker,
        ),
      ),

      // Body with ListView builder
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),

      ),
    );
  }
}