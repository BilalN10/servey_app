import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: AppStaticStrings.history,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.resultScreen);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 100.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.yellowNormal,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const CustomText(
                    text: "Project 1",
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteNormal,
                    fontSize: 20,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
