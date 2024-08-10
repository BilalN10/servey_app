import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Controller/surve_controller.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class CustomToggleButton extends StatelessWidget {
  CustomToggleButton({super.key});

  final SurveyController controller = Get.find<SurveyController>();
  final GeneralController generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: 150.w,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(width: 1.w, color: AppColors.yellowLightActive),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///<============================ This is the German section =========================>

            GestureDetector(
              onTap: () {
                controller.lenguageTab.value = 0;
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: controller.lenguageTab.value == 0
                      ? AppColors.yellowNormalHover
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    // CustomNetworkImage(
                    //   imageUrl:
                    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSETMhcFjElcDkakVa7YaBna8Tgw2QFePey4BY1AyQfg1ujOLGj4LLEpvK6SO9ufkSEUGM&usqp=CAU",
                    //   height: 24.h,
                    //   width: 24.w,
                    //   borderRadius: BorderRadius.circular(100.r),
                    // ),
                    CustomText(
                      text: generalController.transLangu.value,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      left: 8.w,
                      right: 5.w,
                    ),
                  ],
                ),
              ),
            ),

            ///<=========================== This is the England section =========================>
            GestureDetector(
              onTap: () {
                controller.lenguageTab.value = 1;
                controller.update();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: controller.lenguageTab.value == 1
                      ? AppColors.yellowNormalHover
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    // CustomNetworkImage(
                    //   imageUrl:
                    //       "https://vectorflags.s3.amazonaws.com/flags/uk-sphere-01.png",
                    //   height: 24.h,
                    //   width: 24.w,
                    //   borderRadius: BorderRadius.circular(100.r),
                    // ),
                    CustomText(
                      text: "EN",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      left: 8.w,
                      right: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
