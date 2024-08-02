import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Controller/surve_controller.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Inner/custom_toggle_button.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class MainSurveySCreen extends StatefulWidget {
  const MainSurveySCreen({super.key});

  @override
  State<MainSurveySCreen> createState() => _MainSurveySCreenState();
}

class _MainSurveySCreenState extends State<MainSurveySCreen> {
  final SurveyController surveyController = Get.find<SurveyController>();

  final List<String> emojiList = [
    AppImages.rattingOneEmoji,
    AppImages.rattingTwoEmoji,
    AppImages.rattingThreeEmoji,
    AppImages.rattingFourEmoji,
    AppImages.rattingFiveEmoji,
  ];

  final String companyImg = Get.arguments[0];

  final String companyName = Get.arguments[1];

  final String surveyId = Get.arguments[2];

  final bool isEmoji = Get.arguments[3];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      surveyController.getQuestions(surveyId: surveyId);
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
        body: Obx(() {
          switch (surveyController.rxRequestStatus.value) {
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///<========================= This is the survey text =========================>

                      Center(
                          child: CustomText(
                        text: AppStaticStrings.survey,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        top: 24.h,
                        bottom: 24.h,
                      )),

                      ///<========================= This is language button ====================>

                      Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: EdgeInsets.only(left: 150.w),
                            child: const CustomToggleButton(),
                          )),

                      ///<=========================== This is the survey question =======================>

                      SizedBox(
                        height: 100.h,
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: surveyController.questionList.length,
                          controller: surveyController.pageController.value,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return CustomText(
                              text: surveyController
                                      .questionList[itemIndex].questionEn ??
                                  "",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              maxLines: 10,
                              top: 24.h,
                              bottom: 24.h,
                            );
                            //_buildCarouselItem(context, selectedIndex, itemIndex);
                          },
                        ),
                      ),

                      ///<============================ This is the emoji section ==================>

                      isEmoji == true
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  emojiList.length,
                                  (index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 15.w),
                                      child: SizedBox(
                                        child: IconButton(
                                            onPressed: () {
                                              surveyController
                                                  .emojiTabIndex.value = index;
                                              surveyController.emojiTabIndex
                                                  .refresh();
                                            },
                                            icon: CustomImage(
                                              imageSrc: emojiList[index],
                                              imageType: ImageType.png,
                                              size: surveyController
                                                          .emojiTabIndex
                                                          .value ==
                                                      index
                                                  ? 50
                                                  : 35,
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          :

                          ///<=========================== This is the ratting bar ==========================>

                          Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    5,
                                    (index) {
                                      return IconButton(
                                          onPressed: () {
                                            surveyController.rattingTabIndex =
                                                index;
                                            surveyController.update();
                                          },
                                          icon: Icon(
                                            Icons.star,
                                            color: surveyController
                                                        .rattingTabIndex >=
                                                    index
                                                ? AppColors.yellowNormal
                                                : AppColors.grayNormal,
                                            size: surveyController
                                                        .rattingTabIndex ==
                                                    index
                                                ? 55
                                                : 45,
                                          ));
                                      //IconButton(child: Icon(Icons.star,color: controller.rattingTabIndex>=index? AppColors.yellowNormal:AppColors.grayNormal,size: 38,));
                                    },
                                  ),
                                ),
                              ),
                            ),

                      SizedBox(
                        height: 60.h,
                      ),

                      CustomText(
                        text:
                            "${AppStaticStrings.totalQuestion}${surveyController.questionList.length}",
                        bottom: 12.h,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),

                      ///<========================================= This is the progressbar ==================>

                      LinearProgressBar(
                        maxSteps: surveyController.questionList.length,
                        progressType: LinearProgressBar
                            .progressTypeLinear, // Use Linear progress
                        currentStep: surveyController.qustionIndex.value,
                        progressColor: AppColors.yellowNormal,
                        backgroundColor: Colors.grey,
                        minHeight: 12,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "${surveyController.qustionIndex.value}"),
                            CustomText(
                                text: "${surveyController.questionList.length}")
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 24.h,
                      ),

                      ///<=========================== This is the comment box =========================>

                      if (surveyController
                              .questionList[
                                  surveyController.qustionIndex.value - 1]
                              .comment !=
                          0)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.w, color: AppColors.grayLight),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16.r),
                                bottomRight: Radius.circular(16.r),
                                topLeft: Radius.circular(8.r),
                                bottomLeft: Radius.circular(8.r)),
                          ),
                          child: Row(
                            children: [
                              ///<========================== This is the comment icon =====================>

                              Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.blueDarker),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CustomImage(
                                    imageSrc: AppImages.commentIcon,
                                    imageType: ImageType.png,
                                    size: 20,
                                  ),
                                ),
                              ),

                              ///<================================ This is text field ======================>

                              SizedBox(
                                width: 16.w,
                              ),

                              Expanded(
                                  child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: "Write your comment here",
                                    hintStyle: TextStyle(
                                        color: AppColors.grayNormalHover),
                                    border: InputBorder.none),
                              )),
                            ],
                          ),
                        ),

                      SizedBox(
                        height: 24.h,
                      ),

                      ///<============================= This is the next button ==================>

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 97.w),
                        child: CustomButton(
                          onTap: () {
                            if (surveyController.isLastPage) {
                              Get.offNamed(AppRoute.allResultScreeen);
                            } else {
                              surveyController.qustionIndex.value += 1;
                              surveyController.pageController.value.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeIn,
                              );
                              surveyController.emojiTabIndex.value = 2;
                              surveyController.qustionIndex.refresh();
                            }
                          },
                          fillColor: AppColors.yellowNormal,
                          title: AppStaticStrings.next,
                        ),
                      ),

                      SizedBox(
                        height: 16.h,
                      ),

                      ///<============================= Quit button ========================>

                      GestureDetector(
                        onTap: () {
                          navigator!.pop();
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 97.w),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.w,
                                color: AppColors.yellowNormal,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: const CustomText(
                                text: AppStaticStrings.quit,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.yellowNormal)),
                      ),
                    ],
                  ),
                ),
              );
          }
        }));
  }
}
