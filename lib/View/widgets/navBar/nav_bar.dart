import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

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
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.greenLight,
        boxShadow: const[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 20.h),
      alignment: Alignment.center,
      // color: AppColors.greenNormalGreen4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(2),

              child: CustomImage(imageSrc:
              bottomNavIndex==index?selectedIcon[index]:
              unselectedIcon[index],imageType: ImageType.svg,size: 24.r,),
              // child: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: index == bottomNavIndex ? Colors.transparent : null,
              //   ),
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 8,
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       ///==================== Icon ===================
              //
              //       index == bottomNavIndex
              //           ? SvgPicture.asset(
              //               selectedIcon[index],
              //               height: 18.w,
              //             )
              //           : SvgPicture.asset(
              //               unselectedIcon[index],
              //               height: 18.w,
              //             ),
              //     ],
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
       // Get.offAll(() => HomeScreen());
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        //Get.offAll(() => MyPlan());
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        //Get.offAll(() =>  ProfileScreen());
      }
    }
    //
    else if (index == 3) {
      if (!(widget.currentIndex == 3)){
        //Get.to(() => MessageScreen());
      }
    }
  }
}
