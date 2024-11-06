import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/notification_screen/model/notification_model.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class MyNotificationController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///======================= Get Notification =========================
  RxList<NotificationDatum> notificationList = <NotificationDatum>[].obs;

  RxInt unreadCount = 0.obs;
  getNotifications() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(ApiUrl.notification);

    if (response.statusCode == 200) {
      notificationList.value = List<NotificationDatum>.from(response
          .body["notifications"]
          .map((x) => NotificationDatum.fromJson(x)));

      unreadCount.value = response.body["unread_count"];

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

  ///=========================== Read Notifications ============================
  RxBool loading = false.obs;
  readNotifications() async {
    loading.value = true;

    var response = await ApiClient.getData(
      ApiUrl.readNotification,
    );

    if (response.statusCode == 200) {
      getNotifications();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }
}
