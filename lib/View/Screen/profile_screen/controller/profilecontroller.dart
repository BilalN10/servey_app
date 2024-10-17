import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/profile_screen/model/profile_model.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/service/api_check.dart';
import 'package:survey_markus/service/api_client.dart';
import 'package:survey_markus/service/api_url.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class ProfileController extends GetxController with GetxServiceMixin {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  GeneralController generalController = Get.find<GeneralController>();

  ///======================= Get Profile =========================
  Rx<TextEditingController> nameController = TextEditingController().obs;

  Rx<UserDatum> userData = UserDatum().obs;
  getProfile() async {
    setRxRequestStatus(Status.loading);

    var response = await ApiClient.getData(ApiUrl.getProfile);

    if (response.statusCode == 200) {
      userData.value = UserDatum.fromJson(response.body["user"]);
      nameController.value =
          TextEditingController(text: userData.value.name ?? "");
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

  ///======================= Update Profile =========================
  updateProfile() async {
    if (nameController.value.text.isEmpty) {
      return toastMessage(message: "Please also update the name");
    }
    generalController.showPopUpLoader();

    var body = {"name": nameController.value.text, "_method": "PUT"};
    var response = generalController.imagePath.value.isEmpty
        ? await ApiClient.postData(ApiUrl.updateProfile, body,
            contentType: false)
        : await ApiClient.postMultipartData(ApiUrl.updateProfile, body,
            multipartBody: [
                MultipartBody("image", generalController.imageFile.value)
              ]);

    if (response.statusCode == 200) {
      getProfile();
      navigator!.pop();
      navigator!.pop();
    } else {
      navigator!.pop();
      ApiChecker.checkApi(response);
    }
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
