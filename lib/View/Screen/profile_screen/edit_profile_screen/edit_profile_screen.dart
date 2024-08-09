import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/profile_screen/controller/profilecontroller.dart';
import 'package:survey_markus/View/Screen/profile_screen/model/profile_model.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final UserDatum data = Get.arguments;
  final ProfileController profileController = Get.find<ProfileController>();
  final GeneralController generalController = Get.find<GeneralController>();
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
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  generalController.selectImage();
                },
                child: Center(
                  child: generalController.imagePath.isEmpty
                      ? CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl: "${ApiUrl.baseUrl}/${data.image ?? ""}",
                          height: 102.h,
                          width: 102.w,
                        )
                      : Container(
                          height: 102.h,
                          width: 102.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      generalController.imagePath.value))),
                        ),
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
                      readOnly: false,
                      title: AppStaticStrings.name,
                      controller: profileController.nameController.value,
                    ),

                    ///======================company id============
                    customEditProfile(
                      title: AppStaticStrings.userId,
                      controller:
                          TextEditingController(text: data.companyId ?? ""),
                    ),

                    ///========================Email===============
                    customEditProfile(
                      title: AppStaticStrings.email,
                      controller: TextEditingController(text: data.email ?? ""),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),

                    ///=======================Update Button===========
                    CustomButton(
                      onTap: () {
                        profileController.updateProfile();
                      },
                      fillColor: AppColors.grayDarkActive,
                      title: AppStaticStrings.update,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  ///================================Custom EditProfile===================
  Widget customEditProfile(
      {required String title,
      required TextEditingController controller,
      bool isPassword = false,
      bool readOnly = true}) {
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
          readOnly: readOnly,
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
