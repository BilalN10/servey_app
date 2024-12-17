import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/home.dart';
import 'package:survey_markus/View/Screen/all_survey_company/all_survey_company.dart';
import 'package:survey_markus/View/Screen/notification_screen/controller/notification_controller.dart';
import 'package:survey_markus/View/Screen/notification_screen/notification_screen.dart';
import 'package:survey_markus/View/Screen/profile_screen/profile_screen.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  final bool isNotification;

  const NavBar(
      {required this.currentIndex, super.key, this.isNotification = false});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var bottomNavIndex = 0;

  List<String> unselectedIcon = [
    AppIcons.homeIcon,
    AppIcons.allSurvey,
    AppIcons.notification,
    AppIcons.profile,
  ];

  List<String> selectedIcon = [
    AppIcons.homeActive,
    AppIcons.allSurveyActive,
    AppIcons.notificationActive,
    AppIcons.profileActive,
  ];

  @override
  void initState() {
    setState(() {
      bottomNavIndex = widget.currentIndex;
    });
    super.initState();
  }

  final MyNotificationController notificationController =
      Get.find<MyNotificationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.greenLight,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 20.h),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(2),
              child: index == 2 // Badge specifically for the notification icon
                  ? Obx(() {
                      return Badge.count(
                        textColor: AppColors.blueDark,
                        backgroundColor: AppColors.yellowLightHover,
                        count: notificationController.unreadCount
                            .value, // Change this count as per your requirements
                        child: CustomImage(
                          imageSrc: bottomNavIndex == index
                              ? selectedIcon[index]
                              : unselectedIcon[index],
                          imageType: ImageType.svg,
                          size: 24.r,
                        ),
                      );
                    })
                  : CustomImage(
                      imageSrc: bottomNavIndex == index
                          ? selectedIcon[index]
                          : unselectedIcon[index],
                      imageType: ImageType.svg,
                      size: 24.r,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.to(() => HomeScreen());
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.to(() => AllSurveyCompany());
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.to(() => NotificationScreen());
      }
    } else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.to(() => ProfileScreen());
      }
    }
  }
}
