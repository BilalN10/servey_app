import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/joined_company_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/project_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/survey_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class HomeController extends GetxController with GetxServiceMixin {
  final joinedCompanyLoading = Status.loading.obs;
  void joinedCompanyLoadingMethod(Status value) =>
      joinedCompanyLoading.value = value;

  final getProjectLoading = Status.loading.obs;
  void getProjectLoadingMethod(Status value) => getProjectLoading.value = value;

  final getSurveyLoading = Status.loading.obs;
  void getSurveyLoadingMethod(Status value) => getSurveyLoading.value = value;

  GeneralController generalController = Get.find<GeneralController>();

  ///============================ Joined Company List =========================

  RxList<JoinedCompanyDatum> jointedCompanyList = <JoinedCompanyDatum>[].obs;
  joinedCompanyList() async {
    joinedCompanyLoadingMethod(Status.loading);

    var response = await ApiClient.getData(ApiUrl.joinedCompanyList);

    if (response.statusCode == 200) {
      jointedCompanyList.value = List<JoinedCompanyDatum>.from(
          response.body["data"].map((x) => JoinedCompanyDatum.fromJson(x)));

      joinedCompanyLoadingMethod(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        joinedCompanyLoadingMethod(Status.internetError);
      } else {
        joinedCompanyLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///============================ Project List ==========================
  RxList<ProjectDatum> projectList = <ProjectDatum>[].obs;
  getProject({required String companyId}) async {
    projectList.clear();
    getProjectLoadingMethod(Status.loading);

    var response =
        await ApiClient.getData(ApiUrl.getProject(companyId: companyId));

    if (response.statusCode == 200) {
      projectList.value = List<ProjectDatum>.from(response.body["data"]
              ["projects"]["data"]
          .map((x) => ProjectDatum.fromJson(x)));

      getProjectLoadingMethod(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      getProjectLoadingMethod(Status.completed);
      toastMessage(message: response.body["message"]);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        getProjectLoadingMethod(Status.internetError);
      } else {
        getProjectLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///============================ Survey List ==========================

  RxList<SurveyDatum> surveyList = <SurveyDatum>[].obs;
  getSurvey({required String projectId}) async {
    surveyList.clear();
    getSurveyLoadingMethod(Status.loading);

    var response =
        await ApiClient.getData(ApiUrl.getSurvey(projectId: projectId));

    if (response.statusCode == 200) {
      surveyList.value = List<SurveyDatum>.from(
          response.body["data"].map((x) => SurveyDatum.fromJson(x)));

      getSurveyLoadingMethod(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      getSurveyLoadingMethod(Status.completed);
      toastMessage(message: response.body["message"]);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        getSurveyLoadingMethod(Status.internetError);
      } else {
        getSurveyLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    generalController.selectLanguage(show: false);
    joinedCompanyList();
    super.onInit();
  }
}
