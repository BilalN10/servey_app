import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/company_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/joined_company_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/project_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/survey_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class HomeControl extends GetxController with GetxServiceMixin {
  final joinedCompanyLoading = Status.loading.obs;
  void joinedCompanyLoadingMethod(Status value) =>
      joinedCompanyLoading.value = value;

  final getProjectLoading = Status.loading.obs;
  void getProjectLoadingMethod(Status value) => getProjectLoading.value = value;

  final getSurveyLoading = Status.loading.obs;
  void getSurveyLoadingMethod(Status value) => getSurveyLoading.value = value;

  final getAllCompaniesLoading = Status.loading.obs;
  void getAllCompaniesLoadingMethod(Status value) =>
      getAllCompaniesLoading.value = value;

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
      } else if (response.statusCode == 401) {
        // Handle 401 gracefully - don't redirect to login for joined company list
        print(
            'Joined company list API returned 401 - setting error status without redirecting');
        joinedCompanyLoadingMethod(Status.error);
        // Don't call ApiChecker.checkApi for 401 on joined company list
      } else {
        joinedCompanyLoadingMethod(Status.error);
        ApiChecker.checkApi(response);
      }
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
      } else if (response.statusCode == 401) {
        // Handle 401 gracefully - don't redirect to login for project list
        print(
            'Project list API returned 401 - setting error status without redirecting');
        getProjectLoadingMethod(Status.error);
        // Don't call ApiChecker.checkApi for 401 on project list
      } else {
        getProjectLoadingMethod(Status.error);
        ApiChecker.checkApi(response);
      }
    }
  }

  ///============================ Survey List ==========================

  RxList<SurveyDatum> surveyList = <SurveyDatum>[].obs;

  ///============================ All Companies List ==========================
  RxList<AllCompanyModel> allCompaniesList = <AllCompanyModel>[].obs;

  getAllCompanies() async {
    allCompaniesList.clear();
    getAllCompaniesLoadingMethod(Status.loading);

    var response = await ApiClient.getData(ApiUrl.allCompanies);

    if (response.statusCode == 200) {
      CompanyResponse companyResponse = CompanyResponse.fromJson(response.body);
      allCompaniesList.value = companyResponse.data.data;

      getAllCompaniesLoadingMethod(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      getAllCompaniesLoadingMethod(Status.completed);
      toastMessage(message: response.body["message"]);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        getAllCompaniesLoadingMethod(Status.internetError);
      } else if (response.statusCode == 401) {
        // Handle 401 gracefully - don't redirect to login for all companies list
        print(
            'All companies API returned 401 - setting error status without redirecting');
        getAllCompaniesLoadingMethod(Status.error);
        // Don't call ApiChecker.checkApi for 401 on all companies list
      } else {
        getAllCompaniesLoadingMethod(Status.error);
        ApiChecker.checkApi(response);
      }
    }
  }

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
      } else if (response.statusCode == 401) {
        // Handle 401 gracefully - don't redirect to login for survey list
        print(
            'Survey list API returned 401 - setting error status without redirecting');
        getSurveyLoadingMethod(Status.error);
        // Don't call ApiChecker.checkApi for 401 on survey list
      } else {
        getSurveyLoadingMethod(Status.error);
        ApiChecker.checkApi(response);
      }
    }
  }

  @override
  void onInit() {
    generalController.selectLanguage(show: false);
    joinedCompanyList();
    super.onInit();
  }
}
