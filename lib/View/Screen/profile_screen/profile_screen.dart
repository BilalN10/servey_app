import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/profile_screen/controller/profilecontroller.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        bottomNavigationBar: const NavBar(currentIndex: 3),

        ///===============================Profile Appbar=====================
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          actions: [
            ///==============================Edit profile Icon=================
            InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.editProfileScreen,
                      arguments: profileController.userData.value);
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
        body: Obx(() {
          switch (profileController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  profileController.getProfile();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  profileController.getProfile();
                },
              );

            case Status.completed:
              var data = profileController.userData.value;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 23, vertical: 25),
                child: Column(
                  children: [
                    ///=====================Profile Image==============
                    Center(
                      child: CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl: "${ApiUrl.baseUrl}/${data.image ?? ""}",
                          height: 102.h,
                          width: 102.w),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),

                    ///==================================Company Name===================
                    _customProfile(
                      title: AppStaticStrings.name,
                      name: data.name ?? "",
                    ),

                    ///==================================Company Name===================
                    _customProfile(
                      title: AppStaticStrings.userId,
                      name: "${data.id}",
                    ),

                    ///==================================Email===================
                    _customProfile(
                      title: AppStaticStrings.email,
                      name: data.email ?? "",
                    ),
                  ],
                ),
              );
          }
        }));
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
