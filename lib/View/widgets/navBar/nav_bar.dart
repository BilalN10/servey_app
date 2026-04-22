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
  final int? initialIndex;
  final bool isNotification;

  const NavBar({this.initialIndex, super.key, this.isNotification = false});

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
    super.initState();
    bottomNavIndex = widget.initialIndex ?? 0;
  }

  final MyNotificationController notificationController =
      Get.find<MyNotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: bottomNavIndex,
        children: [
          HomeScreen(),
          AllSurveyCompany(),
          NotificationScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.h + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.greenLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.greenLight,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: bottomNavIndex,
            onTap: (index) {
              setState(() {
                bottomNavIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: CustomImage(
                  imageSrc: AppIcons.homeIcon,
                  imageType: ImageType.svg,
                  size: 24.r,
                ),
                activeIcon: CustomImage(
                  imageSrc: AppIcons.homeActive,
                  imageType: ImageType.svg,
                  size: 24.r,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: CustomImage(
                  imageSrc: AppIcons.allSurvey,
                  imageType: ImageType.svg,
                  size: 24.r,
                ),
                activeIcon: CustomImage(
                  imageSrc: AppIcons.allSurveyActive,
                  imageType: ImageType.svg,
                  size: 24.r,
                ),
                label: 'Survey',
              ),
              BottomNavigationBarItem(
                icon: Obx(() {
                  return Badge.count(
                    textColor: AppColors.blueDark,
                    backgroundColor: AppColors.yellowLightHover,
                    count: notificationController.unreadCount.value,
                    child: CustomImage(
                      imageSrc: AppIcons.notification,
                      imageType: ImageType.svg,
                      size: 24.r,
                    ),
                  );
                }),
                activeIcon: Obx(() {
                  return Badge.count(
                    textColor: AppColors.blueDark,
                    backgroundColor: AppColors.yellowLightHover,
                    count: notificationController.unreadCount.value,
                    child: CustomImage(
                      imageSrc: AppIcons.notificationActive,
                      imageType: ImageType.svg,
                      size: 24.r,
                    ),
                  );
                }),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: CustomImage(
                  imageSrc: AppIcons.profile,
                  imageType: ImageType.svg,
                  size: 24.r,
                ),
                activeIcon: CustomImage(
                  imageSrc: AppIcons.profileActive,
                  imageType: ImageType.svg,
                  size: 24.r,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
