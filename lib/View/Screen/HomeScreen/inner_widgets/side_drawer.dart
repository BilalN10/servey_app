import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 35, right: 20, bottom: 5),
            width: MediaQuery.of(context).size.width / 1.3,
            color: AppColors.grayDarkHover,
            height: 100.h,
            child: const CustomImage(
              imageSrc: AppImages.forgotPassImage,
              imageType: ImageType.png,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            color: AppColors.whiteDark,
            width: MediaQuery.of(context).size.width / 1.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                ///=========================Terms and condition=================
               customRow(
                  onTap: () {
                    // Get.toNamed(AppRoutes.termsAndConditionScreen);
                  },
                  title: AppStaticStrings.today,
                  icon: AppIcons.termsCondition,
                ),

                ///======================================privacy policy================
               customRow(
                  onTap: () {
                    // Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
                  title: AppStaticStrings.profile,
                  icon: AppIcons.profile,
                ),



                ///============================Settings====================
               customRow(
                  onTap: () {
                    // Get.toNamed(AppRoutes.settingScreen);
                  },
                  title: AppStaticStrings.sendCode,
                  icon: AppIcons.search,
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }



  ///==============================Custom side drawer=========================
  Widget customRow(
      {required String title,
        required String icon,
        required VoidCallback onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                CustomImage(
                  imageSrc: icon,
                  imageType: ImageType.svg,
                ),
                CustomText(
                  color: AppColors.grayDarkHover,
                  left: 16.w,
                  text: title,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                ),
              ],
            )),
      );

}