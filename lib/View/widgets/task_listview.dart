import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:survey_markus/View/Screen/edit/edit_issue.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/widgets/priority_data.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';

class TaskListView extends StatelessWidget {
  // TaskListView({super.key, required this.h, required this.w});
  final String companyName;
  final String companyImage;
  final String projectName;
  final String projectId;
  TaskListView({
    super.key,
    required this.h,
    required this.w,
    required this.companyName,
    required this.companyImage,
    required this.projectName,
    required this.projectId,
  });
  final double h;
  final double w;
  final HomeController controller = Get.find<HomeController>();

  String _formatRecordedDate(String? recorded) {
    if (recorded == null || recorded.isEmpty) {
      return 'N/A';
    }

    try {
      final date = DateTime.parse(recorded);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.projectIssuesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => EditIssuePage(
                          projectName: projectName,
                          projectIssue: controller.projectIssuesList[index],
                          companyName: companyName,
                          companyImage: companyImage,
                        ))!
                    .then((value) {
                  print('refresh call projectId is $projectId');
                  controller.getProjectIssuesByProject(projectId: projectId);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: CustomText(
                              text: controller
                                  .projectIssuesList[index].description,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // Spacer(),
                          // GestureDetector(
                          //   onTap: () {
                          //     controller.changeFav(index);
                          //   },
                          //   child: SvgPicture.asset(
                          //     'assets/icons/fav.svg',
                          //     //: 'assets/icons/fav-outline.svg',
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: h * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                        child: Column(
                          children: [
                            PriorityData(
                                index: index,
                                projectIssue:
                                    controller.projectIssuesList[index]),
                            SizedBox(height: h * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text:
                                      '${controller.projectIssuesList[index].system}',
                                  height: 1.5,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomText(
                                  text:
                                      '${controller.projectIssuesList[index].subsystem}',
                                  height: 1.5,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.04),
                      Row(
                        children: [
                          CustomText(
                            text: 'Recorder: ',
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            text:
                                '${controller.projectIssuesList[index].responsibleEmployer}',
                            color: Colors.black.withOpacity(.53),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.01),
                      Row(
                        children: [
                          CustomText(
                            text: 'Recording date: ',
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            text: _formatRecordedDate(
                              controller.projectIssuesList[index].recorded,
                            ),
                            color: Colors.black.withOpacity(.53),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
