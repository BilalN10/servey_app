import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/project/project_page.dart';
import 'package:survey_markus/View/widgets/DeletePopup/delete.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/helper/shared_prefe/shared_prefe.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});
  final TextEditingController controller = TextEditingController();
  final GeneralController generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                ///==================== Profile =================
                customRow(
                  onTap: () {
                    Get.toNamed(AppRoute.profileScreen);
                  },
                  title: AppStaticStrings.profile,
                  icon: AppIcons.profile,
                ),
                const Divider(),

                ///======================= Got Qr Code ===============================
                // SizedBox(
                //   height: 15.h,
                // ),

                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed(AppRoute.scanQrCodeScreen);
                //   },
                //   child: Row(
                //     children: [
                //       const CustomImage(
                //         imageSrc: AppImages.code,
                //         imageType: ImageType.png,
                //         // imageType: ImageType.svg,
                //       ),
                //       CustomText(
                //         color: AppColors.grayDarkHover,
                //         left: 16.w,
                //         text: AppStaticStrings.gotQRCode,
                //         fontSize: 14.w,
                //         fontWeight: FontWeight.w400,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 15.h,
                // ),
                // const Divider(),

                ///============================Your Survey====================
                customRow(
                  onTap: () {
                    Get.toNamed(AppRoute.historyScreen);
                    // Get.to(() => ProjectPage());
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

                ///============================ Update Language ===========================

                Obx(() => customRow(
                      onTap: () {
                        navigator?.pop();
                        generalController.selectLanguage(show: true);
                      },
                      title: (generalController.transLangu.value.isEmpty ||
                              generalController.transLangu.value == "null")
                          ? AppStaticStrings.updateTranslator
                          : "${AppStaticStrings.updateTranslator} (${generalController.transLangu.value})",
                      icon: AppIcons.language,
                    )),
                const Divider(),

                ///============================ Delete Account ===========================

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
                                // controller: controller,
                                // onTap: () {
                                //   // if(controller.passControllers.text.isEmpty==true){
                                //   //   toastMessage(message:"Password field is required") ;
                                //   // }else{
                                //   //   controller.deleteAccount();
                                //   //   controller.update();
                                //   // }

                                // },
                                ),
                          );
                        },
                      );
                    }),
                const Divider(),

                ///============================ Log Out ===========================

                customRow(
                  onTap: () {
                    SharePrefsHelper.remove(SharedPreferenceValue.token);
                    SharePrefsHelper.setBool(
                        SharedPreferenceValue.isRemember, false);

                    Get.offNamed(AppRoute.signInScreen);
                  },
                  title: AppStaticStrings.logOut,
                  icon: AppIcons.logoutIcon,
                ),

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
