import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:survey_markus/View/Screen/HomeScreen/controller/home_controller.dart';
import 'package:survey_markus/View/Screen/HomeScreen/inner_widgets/side_drawer.dart';
import 'package:survey_markus/View/widgets/custom_company_card/custom_company_card.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SideDrawer(),
      bottomNavigationBar: const NavBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                ///<====================== This is the app Bar ================>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomImage(
                      imageSrc: AppImages.appLogo,
                      imageType: ImageType.png,
                      sizeWidth: 139.w,
                    ),
                    IconButton(
                        onPressed: () {
                          // scaffoldKey.currentState!.openDrawer();
                        },
                        icon: const CustomImage(imageSrc: AppIcons.drawreIcon)),
                  ],
                ),

                SizedBox(
                  height: 14.h,
                ),

                ///<=================== This is the top iamge section =============>

                const CustomImage(
                  imageSrc: AppImages.homeImage,
                  imageType: ImageType.png,
                ),

                CustomText(
                  text: AppStaticStrings.wellComeMarkus,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  maxLines: 2,
                  top: 24.h,
                  bottom: 24.h,
                ),

                ///<================== this is the  survey card ==================>

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 140.w, vertical: 40.h),
                    decoration: BoxDecoration(
                      color: AppColors.yellowNormal,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const CustomText(
                      text: AppStaticStrings.survey,
                      color: AppColors.whiteNormal,
                    ),
                  ),
                ),

                LanguagePickerDropdown(
                    initialValue: Languages.korean,
                    onValuePicked: (Language language) {
                      print(language.isoCode);
                    }),

                const CustomText(
                  text: "Joined Company",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  top: 24,
                ),

                SizedBox(
                  height: 29.h,
                ),

                Obx(() {
                  switch (homeController.joinedCompanyLoading.value) {
                    case Status.loading:
                      return const CustomLoader();
                    case Status.internetError:
                      return NoInternetScreen(
                        onTap: () {
                          // controller.getFaq();
                        },
                      );
                    case Status.error:
                      return GeneralErrorScreen(
                        onTap: () {
                          // controller.getFaq();
                        },
                      );

                    case Status.completed:
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: List.generate(
                            homeController.jointedCompanyList.length,
                            (index) {
                              var data =
                                  homeController.jointedCompanyList[index];
                              return CustomCompanyCard(
                                onTap: () {
                                  Get.toNamed(AppRoute.allProjectScreen,
                                      arguments: [
                                        "${ApiUrl.baseUrl}/${data.user?.image ?? ""}",
                                        data.user?.name ?? "",
                                        data.companyId.toString()
                                      ]);
                                },
                                companyName: data.user?.name ?? "",
                                image:
                                    "${ApiUrl.baseUrl}/${data.user?.image ?? ""}",
                              );
                            },
                          ),
                        ),
                      );
                  }
                }),

                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
