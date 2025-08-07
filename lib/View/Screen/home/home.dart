import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/widgets/header.dart';
import 'package:survey_markus/View/widgets/sort_and_filter_data.dart';
import 'package:survey_markus/View/widgets/task_listview.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Color(0xfffdf9e9),
      body: SizedBox.expand(
        child: Column(
          children: [
            Header(w: w, h: h),
            SizedBox(height: h * 0.02),
            SortAndFilterData(homeController: homeController),
            SizedBox(height: h * 0.02),
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (controller) => TaskListView(h: h, w: w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
