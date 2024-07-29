import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/all_survey_company/model/companylist_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class CompanyListController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  GeneralController generalController = Get.find<GeneralController>();

  ///========================= Get Company List ==========================
  RxList<CompanyDatum> companyList = <CompanyDatum>[].obs;
  getCompanyList() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(ApiUrl.getCompanies);

    if (response.statusCode == 200) {
      companyList.value = List<CompanyDatum>.from(
          response.body["data"].map((x) => CompanyDatum.fromJson(x)));

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

  ///============================ Send Join request =========================
  sendJoinReq({required String companyID, required int index}) async {
    generalController.showPopUpLoader();

    Rx<CompanyDatum> storeData = CompanyDatum().obs;

    var response = await ApiClient.postData(
        ApiUrl.joinCompany, {"company_id": companyID},
        contentType: false);

    if (response.statusCode == 200) {
      storeData.value = CompanyDatum(
          id: companyList[index].id,
          image: companyList[index].image,
          name: companyList[index].name,
          phoneNumber: companyList[index].phoneNumber,
          status: AppStaticStrings.pending,
          address: companyList[index].address,
          companyId: companyList[index].companyId,
          email: companyList[index].email);
      companyList.removeAt(index);

      companyList.insert(index, storeData.value);

      companyList.refresh();
      navigator!.pop();
      toastMessage(message: response.body["message"], color: Colors.green);
    } else {
      navigator!.pop();
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    getCompanyList();
    super.onInit();
  }
}
