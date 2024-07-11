import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveController extends GetxController{

  int lenguageTab=1;

   int rattingTabIndex=0;
   int qustionIndex=0;
  PageController pageController = PageController();

   List<String> qustionList=[
     "How satisfied are you with your current work environment?",
     "How would you rate the support you receive from your team?",
     "How satisfied are you with your current work environment?",
     "How do you feel about the work-life balance in your company?",
     "How satisfied are you with your current work environment?",
     "How do you feel about the work-life balance in your company?",

   ];


}