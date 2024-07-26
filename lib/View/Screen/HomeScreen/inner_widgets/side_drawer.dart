import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/DeletePopup/delete.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Container(
            padding: const EdgeInsets.only(top: 35, right: 20, bottom: 5),
            width: MediaQuery.of(context).size.width / 1.3,
            color: AppColors.yellowNormal,
            height: 80.h,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            color: AppColors.backgroundColor,
            width: MediaQuery.of(context).size.width / 1.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=========================Profile=================
                customRow(
                  onTap: () {
                    Get.toNamed(AppRoute.profileScreen);
                  },
                  title: AppStaticStrings.profile,
                  icon: AppIcons.profile,
                ),
                const Divider(),
                SizedBox(
                  height: 15.h,
                ),

                ///=======================Got Qr Code===============================

                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.scanQrCodeScreen);
                  },
                  child: Row(
                    children: [
                      const CustomImage(
                        imageSrc: AppImages.code,
                        imageType: ImageType.png,
                        // imageType: ImageType.svg,
                      ),
                      CustomText(
                        color: AppColors.grayDarkHover,
                        left: 16.w,
                        text: AppStaticStrings.gotQRCode,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const Divider(),

                ///============================Your Survey====================
                customRow(
                  onTap: () {
                    Get.toNamed(AppRoute.historyScreen);
                  },
                  title: AppStaticStrings.yourSurvey,
                  icon: AppIcons.yourSurvey,
                ),
                const Divider(),

                ///============================Privacy Police====================
                customRow(
                  onTap: () {
                    Get.toNamed(AppRoute.privacyPolicyScreen);
                  },
                  title: AppStaticStrings.privacyPolicy,
                  icon: AppIcons.privacyPolicy,
                ),
                const Divider(),

                ///============================Terms And Condition====================
                customRow(
                  onTap: () {
                    Get.toNamed(AppRoute.termsAndConditionScreen);
                  },
                  title: AppStaticStrings.termsAndCondition,
                  icon: AppIcons.termsCondition,
                ),
                const Divider(),

                customRow(
                  onTap: () {
                    Get.offNamed(AppRoute.signInScreen);
                  },
                  title: "Log out",
                  icon: AppIcons.logoutIcon,
                ),

                const Divider(),

                customRow(
                    title: "Delete Account",
                    icon: AppIcons.deleteIcon,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            backgroundColor: Colors.white,
                            title: DeletePopup(
                              controller: controller,
                              onTap: () {
                                // if(controller.passControllers.text.isEmpty==true){
                                //   toastMessage(message:"Password field is required") ;
                                // }else{
                                //   controller.deleteAccount();
                                //   controller.update();
                                // }
                              },
                            ),
                          );
                        },
                      );
                    }),

                const Divider(),
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
                  size: 24,
                  imageSrc: icon,
                  // imageType: ImageType.svg,
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
