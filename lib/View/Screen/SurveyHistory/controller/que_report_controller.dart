import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:survey_markus/View/Screen/SurveyHistory/model/que_report_model.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class QuestionReportController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxInt chartCategoryIndex = 0.obs;
  RxInt periodicGraphTabIndex = 0.obs;

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
}
