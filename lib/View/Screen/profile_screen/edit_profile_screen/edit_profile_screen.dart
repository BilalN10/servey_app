import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      ///===========================Edit Profile Appbar===============
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,

        centerTitle: true,
        title: CustomText(
          text: AppStaticStrings.editProfile,
          color: AppColors.grayDarker,
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: CustomNetworkImage(
                boxShape: BoxShape.circle,
                imageUrl: AppConstants.onlineImage,
                height: 102.h,
                width: 102.w,
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  ///=====================Company Name==================
                  customEditProfile(
                    title: AppStaticStrings.companyName,
                    controller: TextEditingController(),
                  ),

                  ///======================company id============
                  customEditProfile(
                    title: AppStaticStrings.companyID,
                    controller: TextEditingController(),
                  ),

                  ///========================Email===============
                  customEditProfile(
                    title: AppStaticStrings.email,
                    controller: TextEditingController(),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ///=======================Update Button===========
                  CustomButton(
                    onTap: () {
                      Get.back();
                    },
                    fillColor: AppColors.grayDarkActive,
                    title: 'Update',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///================================Custom EditProfile===================
  Widget customEditProfile({
    required String title,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          color: AppColors.grayDarker,
          text: title,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp, // Use sp for text size
          bottom: 8.h, // Use h for vertical spacing
        ),
        CustomTextField(
          isPassword: isPassword,
          textEditingController: controller,
          inputTextStyle: const TextStyle(color: AppColors.grayDarkActive),
          fillColor: AppColors.blueLightHover,
          fieldBorderColor: AppColors.blueLightHover,
          keyboardType: isPassword ? TextInputType.phone : TextInputType.name,
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
