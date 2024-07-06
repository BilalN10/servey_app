import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3),

      ///===============================Profile Appbar=====================
      appBar: AppBar(
        actions: [
          ///==============================Edit profile Icon=================
          InkWell(
              onTap: () {
                // Get.toNamed(AppRoutes.editProfileScreen);
              },
              child: const CustomImage(
                imageSrc: AppIcons.editIcon,
                imageType: ImageType.svg,
              )),
          SizedBox(
            width: 10.w,
          ),
        ],
        title: CustomText(
          text: AppStaticStrings.profile,
          color: AppColors.grayDarker,
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 25),
        child: Column(
          children: [
            ///=====================Profile Image==============
            Center(
              child: CustomNetworkImage(
                  boxShape: BoxShape.circle,
                  imageUrl: AppConstants.onlineImage,
                  height: 102.h,
                  width: 102.w),
            ),
            SizedBox(
              height: 32.h,
            ),

            ///==================================Company Name===================
            _customProfile(
              title: AppStaticStrings.companyName,
              name: 'Narayana Nethralaya',
            ),
            ///==================================Company Name===================
            _customProfile(
              title: AppStaticStrings.companyID,
              name: '789 012 345',
            ),
            ///==================================Email===================
            _customProfile(
              title: AppStaticStrings.email,
              name: 'masumrna927@gmail.com',
            ),
          ],
        ),
      ),
    );
  }

  ///================================Custom EditProfile===================
  Widget _customProfile({
    required String title,
    required String name,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          color: AppColors.grayDarker,
          text: title,
          fontWeight: FontWeight.w400,
          fontSize: 16.w,
          bottom: 16,
        ),
        Container(
          padding: const EdgeInsets.all(14),
          height: 48.h,
          decoration: BoxDecoration(
              color: AppColors.blueLightHover,
              borderRadius: BorderRadius.circular(5)),
          width: double.infinity,
          child: CustomText(
            textAlign: TextAlign.start,
            text: name,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.grayDarker,
          ),
        ),
        SizedBox(
          height: 24.h,
        )
      ],
    );
  }
}
