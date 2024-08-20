import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/notification_screen/controller/notification_controller.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/helper/time_converter/time_converter.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final MyNotificationController controller =
      Get.find<MyNotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavBar(currentIndex: 2),
        backgroundColor: AppColors.backgroundColor,

        ///=====================Notification Appbar================
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          title: CustomText(
            text: AppStaticStrings.notifications,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.grayDarker,
          ),
        ),

        // Body with ListView builder
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  controller.getNotifications();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  controller.getNotifications();
                },
              );

            case Status.completed:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ///====================== Read All Button ======================

                  TextButton(
                      onPressed: () {
                        controller.readNotifications();
                      },
                      child: CustomText(
                        text: AppStaticStrings.readAll,
                        fontSize: 14.r,
                        color: AppColors.yellowNormal,
                        fontWeight: FontWeight.w500,
                      )),

                  ///====================== Rest of the Content ======================

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      itemCount: controller.notificationList
                          .length, // Assuming 5 notifications for the example
                      itemBuilder: (context, index) {
                        var data = controller.notificationList[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: data.readAt == ""
                                  ? AppColors.whiteNormalActive
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //===================== Image ====================

                              CustomNetworkImage(
                                  boxShape: BoxShape.circle,
                                  imageUrl:
                                      "${ApiUrl.baseUrl}/${data.data?.image ?? ""}",
                                  height: 50.w,
                                  width: 50.w),

                              SizedBox(width: 18.w),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ///========================= Title ===========================

                                        CustomText(
                                          textAlign: TextAlign.left,
                                          text: data.data?.name ?? "",
                                          color: AppColors.blackNew,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                        ),
                                        const Spacer(),

                                        ///============================ Time ===========================

                                        CustomText(
                                          textAlign: TextAlign.left,
                                          text: DateConverter.formatTimeAgo(
                                              data.data?.time ?? ""),
                                          color: AppColors.grayDarkActive,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),

                                    ///========================= Sub-Title ===========================

                                    CustomText(
                                      textAlign: TextAlign.start,
                                      maxLines: 3,
                                      text: data.data?.message ?? "",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      color: AppColors.normalBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
          }
        }));
  }
}
