import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/widgets/header.dart';
import 'package:survey_markus/View/widgets/sort_and_filter_data.dart';
import 'package:survey_markus/View/widgets/task_listview.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.companyName,
    required this.companyImage,
  });

  final String projectId;

  final String projectName;
  final companyName;
  final companyImage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getProjectIssuesByProject(projectId: widget.projectId);
    homeController.getProjectIssuesWithConfigurations(
        projectId: widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    final double w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Color(0xfffdf9e9),
      body: SizedBox.expand(
        child: Column(
          children: [
            Header(
              companyName: widget.companyName,
              companyImage: widget.companyImage,
              w: w,
              h: h,
              projectId: widget.projectId,
              projectName: widget.projectName,
            ),
            SizedBox(height: h * 0.02),
            SortAndFilterData(
              homeController: homeController,
              projectId: widget.projectId,
            ),
            SizedBox(height: h * 0.02),
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (controller) => TaskListView(
                    projectId: widget.projectId,
                    projectName: widget.projectName,
                    h: h,
                    w: w,
                    companyName: widget.companyName,
                    companyImage: widget.companyImage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
