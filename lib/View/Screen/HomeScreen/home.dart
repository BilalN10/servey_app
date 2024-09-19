import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/inner_widgets/side_drawer.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          scaffoldKey.currentState!.openDrawer();
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
                  text: AppStaticStrings.tools,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  maxLines: 2,
                  top: 24.h,
                  bottom: 24.h,
                ),

                ///<================== this is the  survey card ==================>

                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.joinCompany);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    decoration: BoxDecoration(
                      color: AppColors.yellowNormal,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CustomText(
                      fontSize: 16.r,
                      text: AppStaticStrings.survey,
                      color: AppColors.whiteNormal,
                    ),
                  ),
                ),

                // const CustomText(
                //   text: "Joined Company",
                //   fontSize: 20,
                //   fontWeight: FontWeight.w600,
                //   top: 24,
                // ),

                // SizedBox(
                //   height: 29.h,
                // ),

                // SizedBox(
                //   height: 16.h,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
