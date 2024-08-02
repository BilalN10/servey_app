import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/model/survey_que_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class SurveyController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  GeneralController generalController = Get.find<GeneralController>();
  int lenguageTab = 1;

  int rattingTabIndex = 0;

  RxInt emojiTabIndex = 2.obs;

  RxInt qustionIndex = 1.obs;

  int chartCategoryIndex = 1;

  int periodicGraphTabIndex = 0;

  List<String> dummyQustionList = [
    "How satisfied are you with your current work environment?",
    "How would you rate the support you receive from your team?",
    "How satisfied are you with your current work environment?",
    "How do you feel about the work-life balance in your company?",
    "How satisfied are you with your current work environment?",
    "How do you feel about the work-life balance in your company?",
  ];

  Rx<PageController> pageController = PageController().obs;
  //================================ Survey Que List ================================

  RxInt totalQuePages = 0.obs;

  bool get isLastPage {
    return pageController.value.page?.round() == totalQuePages.value - 1;
  }

  RxList<QuestionDatum> questionList = <QuestionDatum>[].obs;

  getQuestions({required String surveyId}) async {
    setRxRequestStatus(Status.loading);

    var response =
        await ApiClient.getData(ApiUrl.surveyQue(surveyId: surveyId));

    if (response.statusCode == 200) {
      questionList.value = List<QuestionDatum>.from(
          response.body["data"].map((x) => QuestionDatum.fromJson(x)));

      totalQuePages.value = questionList.length;
      setRxRequestStatus(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      toastMessage(message: AppStaticStrings.noSurveyFound);
      setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }
}
