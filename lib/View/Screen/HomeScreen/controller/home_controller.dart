import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/joined_company_model.dart';
import 'package:survey_markus/View/Screen/HomeScreen/model/project_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class HomeController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  GeneralController generalController = Get.find<GeneralController>();

  ///============================ Joined Company List =========================

  RxList<JoinedCompanyDatum> jointedCompanyList = <JoinedCompanyDatum>[].obs;
  joinedCompanyList() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(ApiUrl.joinedCompanyList);

    if (response.statusCode == 200) {
      jointedCompanyList.value = List<JoinedCompanyDatum>.from(
          response.body["data"].map((x) => JoinedCompanyDatum.fromJson(x)));

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

  ///============================ Project List =========================
  RxList<ProjectDatum> projectList = <ProjectDatum>[].obs;
  getProject({required String companyId}) async {
    setRxRequestStatus(Status.loading);

    var response =
        await ApiClient.getData(ApiUrl.getProject(companyId: companyId));

    if (response.statusCode == 200) {
      jointedCompanyList.value = List<JoinedCompanyDatum>.from(response
          .body["data"][0]["projects"]
          .map((x) => JoinedCompanyDatum.fromJson(x)));

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

  @override
  void onInit() {
    joinedCompanyList();
    super.onInit();
  }
}
