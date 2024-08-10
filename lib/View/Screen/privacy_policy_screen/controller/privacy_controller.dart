import 'package:get/get.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class PrivacyController extends GetxController with GetxServiceMixin{
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  RxString policy = "".obs;
  getPrivacy() async {
    setRxRequestStatus(Status.loading);
    var response = await ApiClient.getData(ApiUrl.privacy);

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
    getPrivacy();
    super.onInit();
  }
}
