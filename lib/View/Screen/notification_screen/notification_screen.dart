import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: ListView.builder(
          itemCount: 5, // Assuming 5 notifications for the example
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h), // Added padding between items
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notification icon
                 Container(
                   padding:  const EdgeInsets.all(12),
                   decoration:  const BoxDecoration(
                     color: AppColors.yellowLight,
                     shape: BoxShape.circle
                   ),
                   child:  const CustomImage(
                     imageSrc: AppIcons.notification,
                     imageType: ImageType.svg,
                     imageColor: AppColors.yellowNormal,
                   ),
                 ),
                  SizedBox(width: 18.w),

                  // Notification text details
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              textAlign: TextAlign.left,
                              text: 'New Survey',
                              color: AppColors.blackNew,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                            const Spacer(),
                            CustomText(
                              textAlign: TextAlign.left,
                              text: '4 hours ago',
                              color: AppColors.normalGray,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          text: "offered by a truck owner for your trip.",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.normalBlack,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}