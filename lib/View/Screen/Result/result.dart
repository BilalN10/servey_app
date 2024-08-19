import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HistoryScreen/controller/history_controller.dart';
import 'package:survey_markus/View/widgets/custom_loader/custom_loader.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/screen/GenerelError/general_error.dart';
import 'package:survey_markus/global/screen/no%20internet/no_internet.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final HistoryController historyController = Get.find<HistoryController>();

  String projectID = Get.arguments;
  @override
  void initState() {
    historyController.getSubmittedSurvey(projectID: projectID);
    super.initState();
  }

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
          switch (historyController.surveyLoading.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  historyController.getSubmittedSurvey(projectID: projectID);
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  historyController.getSubmittedSurvey(projectID: projectID);
                },
              );

            case Status.completed:
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 5.w, // Spacing between columns
                        mainAxisSpacing: 5.h, // Spacing between rows
                        childAspectRatio: 0.8, // Adjusted aspect ratio
                      ),
                      itemCount: historyController.surveyList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.all(15.w), // Adjusted for ScreenUtil
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoute.allResultScreeen,
                                  arguments:
                                      historyController.surveyList[index].id ??
                                          0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.yellowNormal,
                                  borderRadius: BorderRadius.circular(8.r)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 30.h),
                              child: Center(
                                child: CustomText(
                                  text: historyController
                                          .surveyList[index].surveyName ??
                                      "",
                                  color: AppColors.whiteNormal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
          }
        }));
  }
}
