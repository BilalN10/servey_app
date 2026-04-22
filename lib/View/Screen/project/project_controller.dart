import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/project_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/company_project_model.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class ProjectController extends GetxController {
  final rxLoading = Status.loading.obs;
  void rxLoadingMethod(Status value) => rxLoading.value = value;

  ///===================== Get All Projects =======================
  RxList<ProjectDatum> allProjectsList = <ProjectDatum>[].obs;

  ///===================== Get Company Projects =======================
  RxList<Project> companyProjectsList = <Project>[].obs;
  Rx<CompanyProjectResponse?> companyProjectsResponse =
      Rx<CompanyProjectResponse?>(null);

  getAllProjects() async {
    allProjectsList.clear();
    rxLoadingMethod(Status.loading);

    var response = await ApiClient.getData(ApiUrl.getAllProjects);

    print("response: ${response.body}");

    if (response.statusCode == 200) {
      // The API returns a paginated response with data nested under data.data
      if (response.body["data"] != null &&
          response.body["data"]["data"] != null) {
        allProjectsList.value = List<ProjectDatum>.from(
            response.body["data"]["data"].map((x) => ProjectDatum.fromJson(x)));
      }

      rxLoadingMethod(Status.completed);
      refresh();
    } else if (response.statusCode == 404) {
      rxLoadingMethod(Status.completed);
      toastMessage(message: response.body["message"] ?? "No projects found");
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        rxLoadingMethod(Status.internetError);
      } else {
        rxLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///===================== Get Company Projects by Company ID =======================
  getCompanyProjects({required String companyId}) async {
    companyProjectsList.clear();
    companyProjectsResponse.value = null;
    rxLoadingMethod(Status.loading);

    var response = await ApiClient.getData(
        ApiUrl.getCompanyProjects(companyId: companyId));

    print("Company Projects Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        // Parse the response using the CompanyProjectResponse model
        companyProjectsResponse.value =
            CompanyProjectResponse.fromJson(response.body);

        // Extract projects list from the response
        if (companyProjectsResponse.value?.data.data != null) {
          companyProjectsList.value = companyProjectsResponse.value!.data.data;
        }

        rxLoadingMethod(Status.completed);
        refresh();
      } catch (e) {
        print("Error parsing company projects response: $e");
        rxLoadingMethod(Status.error);
        toastMessage(message: "Error parsing response");
      }
    } else if (response.statusCode == 404) {
      rxLoadingMethod(Status.completed);
      toastMessage(
          message:
              response.body["message"] ?? "No projects found for this company");
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        rxLoadingMethod(Status.internetError);
      } else {
        rxLoadingMethod(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Optionally load projects when controller initializes
    // getAllProjects();
  }
}
