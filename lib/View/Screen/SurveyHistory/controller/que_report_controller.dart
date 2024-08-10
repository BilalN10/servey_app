import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/SurveyHistory/model/que_report_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:translator/translator.dart';

class QuestionReportController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxInt chartCategoryIndex = 1.obs;
  RxInt periodicGraphTabIndex = 0.obs;
  GeneralController generalController = Get.find<GeneralController>();

  ///========================== Question Survey Chart =========================
  RxList<QuestionSurveyModel> questionSurvey = <QuestionSurveyModel>[].obs;

  getQuestionSurvey(
      {required String queID,
      required String surveyID,
      required String query}) async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(
        ApiUrl.queSurvey(queID: queID, surveyID: surveyID, query: query));

    if (response.statusCode == 200) {
      questionSurvey.value = List<QuestionSurveyModel>.from(
          response.body["data"].map((x) => QuestionSurveyModel.fromJson(x)));
      translateValue();
      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///========================== Update Question Survey Chart =========================
  updateChart({
    required int index,
    required String queID,
    required String surveyID,
  }) {
    periodicGraphTabIndex.value = index;

    switch (index) {
      case 0:
        return getQuestionSurvey(
            queID: queID, surveyID: surveyID, query: "today");

      case 1:
        return getQuestionSurvey(
            queID: queID, surveyID: surveyID, query: "weekly");

      case 2:
        return getQuestionSurvey(
            queID: queID, surveyID: surveyID, query: "monthly");
    }
  }

  ///========================== Translated Question ===========================
  RxString translatedNative = "".obs;
  translateValue() {
    final translator = GoogleTranslator();
    translator
        .translate(questionSurvey[0].question?.questionEn ?? "",
            to: generalController.transLangu.value)
        .then((value) {
      translatedNative.value = value.text;
      refresh();
    });
  }
}
