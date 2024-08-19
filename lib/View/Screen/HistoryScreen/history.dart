import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HistoryScreen/controller/history_controller.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final HistoryController historyController = Get.find<HistoryController>();
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
        body: Obx(() {
          switch (historyController.rxLoading.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  historyController.getSubmittedProject();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  historyController.getSubmittedProject();
                },
              );

            case Status.completed:
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: ListView.builder(
                  itemCount: historyController.projectList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.resultScreen,
                            arguments: historyController.projectList[index].id
                                .toString());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 5.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 100.w,
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.yellowNormal,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: CustomText(
                          text: historyController
                                  .projectList[index].projectName ??
                              "",
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteNormal,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  },
                ),
              );
          }
        }));
  }
}
