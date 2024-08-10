import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/model/result_model.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/model/survey_que_model.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';
import 'package:translator/translator.dart';

class SurveyController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  final resultLoading = Status.loading.obs;
  void resultLoadingStatus(Status value) => resultLoading.value = value;
  GeneralController generalController = Get.find<GeneralController>();
  RxInt lenguageTab = 1.obs;

  RxInt rattingTabIndex = 2.obs;

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
      getQuestionEngLishAndNative();

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

  ///======================== Submit Ans =========================
  Rx<TextEditingController> commentController = TextEditingController().obs;
  submitAns({
    required String queId,
    required String ans,
    required String surveyId,
  }) async {
    //generalController.showPopUpLoader();

    var body = {
      "question_id": queId,
      "answer": ans,
      "comment": commentController.value.text,
    };

    var response =
        await ApiClient.postData(ApiUrl.submitAns, body, contentType: false);
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"], color: Colors.green);
      // navigator!.pop();
      if (isLastPage) {
        getResult(surveyId: surveyId);
      } else {
        qustionIndex.value += 1;
        pageController.value.nextPage(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
        emojiTabIndex.value = 2;
        rattingTabIndex.value = 2;
        qustionIndex.refresh();
      }
      refresh();
    } else if (response.statusCode == 409) {
      if (isLastPage) {
        getResult(surveyId: surveyId);
      } else {
        qustionIndex.value += 1;
        pageController.value.nextPage(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
        emojiTabIndex.value = 2;
        rattingTabIndex.value = 2;
        qustionIndex.refresh();
      }
      toastMessage(
          duration: 3,
          message:
              "You have already attented to this question. Now you can only view",
          color: Colors.red);
      refresh();
    } else {
      ApiChecker.checkApi(response);
      navigator!.pop();
    }
    // getResult(surveyId: surveyId);
  }

  ///========================== Result ==============================
  RxList<ResultDatum> resultList = <ResultDatum>[].obs;
  RxString projectName = "".obs;
  RxString surveyName = "".obs;
  RxString emojiOrStar = "".obs;

  RxInt totalQue = 0.obs;

  getResult({required String surveyId}) async {
    resultLoadingStatus(Status.loading);
    var response =
        await ApiClient.getData(ApiUrl.showResult(surveyId: surveyId));

    if (response.statusCode == 200) {
      resultList.value = List<ResultDatum>.from(
          response.body["answers"].map((x) => ResultDatum.fromJson(x)));
      projectName.value = response.body["project_name"];
      surveyName.value = response.body["survey_name"];
      totalQue.value = response.body["total_questions"];
      emojiOrStar.value = response.body["emoji_or_star"];

      Get.offNamed(AppRoute.allResultScreeen);

      resultLoadingStatus(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      toastMessage(message: AppStaticStrings.noSurveyFound);
      resultLoadingStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        resultLoadingStatus(Status.internetError);
      } else {
        resultLoadingStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

//=================================== Get Question List Eng and Native ==================================
  RxList<String> queEng = <String>[].obs;
  RxList<String> queNative = <String>[].obs;

  getQuestionEngLishAndNative() {
    queEng.value = [];
    queNative.value = [];
    refresh();
    final translator = GoogleTranslator();

    for (int i = 0; i < questionList.length; i++) {
      //========= Translate to Native ==========

      translator
          .translate(questionList[i].questionEn ?? "",
              to: generalController.transLangu.value)
          .then((value) {
        queNative.add(value.text);
        //========= Add to EngLish ==========
        queEng.add(questionList[i].questionEn ?? "");
        debugPrint("Que English $queEng");
        debugPrint("Que Native $queNative");
      });

      refresh();
    }
  }

//=================================== Get Question List Native ==================================
  // getQuestionNative() {
  //   queNative.refresh();

  //   for (int i = 0; i < questionList.length; i++) {}
  // }
}
