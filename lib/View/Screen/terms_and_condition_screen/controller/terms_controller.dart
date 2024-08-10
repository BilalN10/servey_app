import 'package:get/get.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class TermsController extends GetxController with GetxServiceMixin {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  RxString policy = "".obs;
  getTermsAndCondition() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiUrl.terms);

    if (response.statusCode == 200) {
      policy.value = response.body["data"]["description"];
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
    getTermsAndCondition();
    super.onInit();
  }
}
