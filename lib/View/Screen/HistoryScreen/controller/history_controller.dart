import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/project_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/survey_model.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class HistoryController extends GetxController {
  final rxLoading = Status.loading.obs;
  void rxLoadingMethod(Status value) => rxLoading.value = value;

  final surveyLoading = Status.loading.obs;
  void surveyLoadingMethod(Status value) => surveyLoading.value = value;

  ///===================== Get Submitted Project =======================

  RxList<ProjectDatum> projectList = <ProjectDatum>[].obs;
  getSubmittedProject() async {
    rxLoadingMethod(Status.loading);

    var response = await ApiClient.getData(ApiUrl.submittedProject);

    if (response.statusCode == 200) {
      projectList.value = List<ProjectDatum>.from(
          response.body["data"].map((x) => ProjectDatum.fromJson(x)));

      rxLoadingMethod(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        rxLoadingMethod(Status.internetError);
      } else {
        rxLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///======================== Get Submitted Survey =========================

  RxList<SurveyDatum> surveyList = <SurveyDatum>[].obs;
  getSubmittedSurvey({required String projectID}) async {
    surveyLoadingMethod(Status.loading);

    var response =
        await ApiClient.getData(ApiUrl.submittedSurvey(projectID: projectID));

    if (response.statusCode == 200) {
      surveyList.value = List<SurveyDatum>.from(
          response.body["data"].map((x) => SurveyDatum.fromJson(x)));

      surveyLoadingMethod(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        surveyLoadingMethod(Status.internetError);
      } else {
        surveyLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    getSubmittedProject();
    super.onInit();
  }
}
