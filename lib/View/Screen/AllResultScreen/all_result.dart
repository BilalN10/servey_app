import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Controller/surve_controller.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class AllResultScreen extends StatelessWidget {
  AllResultScreen({super.key});
  final SurveyController surveyController = Get.find<SurveyController>();
  final GeneralController generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: AppStaticStrings.allResult,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Obx(() {
          switch (surveyController.resultLoading.value) {
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
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///<======================== This is the company name section ==================>

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     const CustomText(
                        //       textAlign: TextAlign.start,
                        //       text: "${AppStaticStrings.companyName}:  ",
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 14,
                        //     ),
                        //     Expanded(
                        //         child: CustomText(
                        //             text: surveyController.projectName.value,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 12,
                        //             color: AppColors.yellowNormal,
                        //             maxLines: 2,
                        //             textAlign: TextAlign.start)),
                        //   ],
                        // ),

                        // SizedBox(
                        //   height: 16.h,
                        // ),

                        ///<======================== This is the project name section ==================>

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: AppStaticStrings.projectName,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            Expanded(
                                child: CustomText(
                                    text:
                                        "  ${surveyController.projectName.value}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.yellowNormal,
                                    maxLines: 2,
                                    textAlign: TextAlign.start)),
                          ],
                        ),

                        SizedBox(
                          height: 16.h,
                        ),

                        ///<======================== This is the survey  name section ==================>

                        Row(
                          children: [
                            const CustomText(
                              text: AppStaticStrings.surveyName,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            Expanded(
                                child: CustomText(
                                    text:
                                        "  ${surveyController.surveyName.value}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColors.yellowNormal,
                                    textAlign: TextAlign.start)),
                          ],
                        ),

                        SizedBox(
                          height: 16.h,
                        ),

                        ///<======================== This is the total Question section ==================>

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "${AppStaticStrings.totalQuestion}:",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            Expanded(
                                child: CustomText(
                              text: "  ${surveyController.totalQue}",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.yellowNormal,
                              textAlign: TextAlign.start,
                            )),
                          ],
                        ),

                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 24.h,
                    ),

                    ///<========================== This is the all question section ================>
                    Expanded(
                      child: ListView.builder(
                        itemCount: surveyController.resultList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = surveyController.resultList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.surveyHistoryScreen);
                            },
                            child: Column(
                              children: [
                                ///<========================== This is the question section ====================================>
                                ListTile(
                                  leading: CustomText(
                                    text: "${AppStaticStrings.qN}${index + 1}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  title: CustomText(
                                    text: data.question?.questionEn ?? "",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                ),

                                ///<=========================== This is the ans section =======================================>

                                ListTile(
                                  leading: const CustomText(
                                    text: AppStaticStrings.ans,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  title: Row(
                                    children: [
                                      ///<============================= This is the Star and Emoji section ======================>
                                      surveyController.emojiOrStar.value ==
                                              AppStaticStrings.emoji
                                          ? CustomImage(
                                              size: 30.r,
                                              imageType: ImageType.png,
                                              imageSrc:
                                                  generalController.findEmoji(
                                                      index: int.parse(
                                                          data.answer ?? "0")))
                                          : Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: AppColors.yellowNormal,
                                                ),
                                                CustomText(
                                                  text: "${data.answer} Star",
                                                  left: 5.w,
                                                ),
                                              ],
                                            ),

                                      ///<============================= This is the emoji section ======================>

                                      // const CustomImage(imageSrc:AppImages.rattingFiveEmoji,imageType: ImageType.png,size: 16,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    ///<========================= This is the export button =======================>

                    CustomButton(
                      onTap: () {},
                      title: AppStaticStrings.export,
                      fillColor: AppColors.yellowNormal,
                    ),
                  ],
                ),
              );
          }
        }));
  }
}
