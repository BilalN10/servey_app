import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:survey_markus/utils/AppConst/app_const.dart';

class ServeyController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  GeneralController generalController = Get.find<GeneralController>();
  int lenguageTab = 1;

  int rattingTabIndex = 0;

  int emojiTabIndex = 0;

  int qustionIndex = 0;

  int chartCategoryIndex = 1;

  int periodicGraphTabIndex = 0;

  PageController pageController = PageController();

  List<String> qustionList = [
    "How satisfied are you with your current work environment?",
    "How would you rate the support you receive from your team?",
    "How satisfied are you with your current work environment?",
    "How do you feel about the work-life balance in your company?",
    "How satisfied are you with your current work environment?",
    "How do you feel about the work-life balance in your company?",
  ];

  //======================== Company List =========================


}
