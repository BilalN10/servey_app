import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/controller/home_controller.dart';
import 'package:survey_markus/View/widgets/CustomfeedbackCard/feedback_card.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class AllSurveyScreen extends StatefulWidget {
  const AllSurveyScreen({super.key});

  @override
  State<AllSurveyScreen> createState() => _AllSurveyScreenState();
}

class _AllSurveyScreenState extends State<AllSurveyScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final String companyImg = Get.arguments[0];
  final String companyName = Get.arguments[1];
  final String projectId = Get.arguments[2];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getSurvey(projectId: projectId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            ///<======================= This is company logo ===============================>

            CustomNetworkImage(
              imageUrl: companyImg,
              height: 40.h,
              width: 58.w,
              boxShape: BoxShape.circle,
            ),

            SizedBox(
              width: 10.w,
            ),

            ///<======================== This is the company name ===============================>

            CustomText(
              text: companyName,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.yellowNormal,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///<==================== This is the all project text ========================>

            Center(
                child: CustomText(
              text: AppStaticStrings.allSurvey,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              top: 16.h,
            )),

            Column(
              children: [
                ///<========================== This is the search field ======================>

                SizedBox(
                  height: 16.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomTextField(
                    onSubmit: (value) {
                      //    articleController.getArticleByCategory(value, false);
                    },
                    hintText: AppStaticStrings.searchhere,
                    isPrefixIcon: true,
                    hintStyle: const TextStyle(color: AppColors.yellowNormal),
                    prefixIconColor: AppColors.yellowNormal,
                    focusBorderColor: AppColors.yellowNormalHover,
                  ),
                ),

                ///<========================== This is the image section ========================>
                SizedBox(
                  height: 16.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: const CustomImage(
                    imageSrc: AppImages.allSurveyImage,
                    imageType: ImageType.png,
                  ),
                )
              ],
            ),

            ///<=========================== This is the all feed back ====================>

            Obx(() {
              switch (homeController.getProjectLoading.value) {
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
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                    child: Column(
                      children: List.generate(homeController.surveyList.length,
                          (rowIndex) {
                        var data = homeController.surveyList[rowIndex];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: FeedbackCard(
                              title: data.surveyName ?? "",
                              onTap: () {
                                Get.toNamed(AppRoute.mainSurvey,
                                    arguments: [companyImg, companyName , data.id]);
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  );
              }
            })
          ],
        ),
      ),
    );
  }
}
