import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:survey_markus/View/Screen/edit/edit_issue.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/widgets/priority_data.dart';

class TaskListView extends StatelessWidget {
  TaskListView({super.key, required this.h, required this.w});

  final double h;
  final double w;
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => EditIssuePage());
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
                            child: Text(
                              controller.tasks[index].description,
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              controller.changeFav(index);
                            },
                            child: SvgPicture.asset(
                              controller.tasks[index].isFav
                                  ? 'assets/icons/fav.svg'
                                  : 'assets/icons/fav-outline.svg',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                        child: Column(
                          children: [
                            PriorityData(index: index),
                            SizedBox(height: h * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'HRL',
                                  style: GoogleFonts.inter(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Conveyor Technology',
                                  style: GoogleFonts.inter(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.04),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Recorder: ',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Paul Müller',
                              style: GoogleFonts.inter(
                                color: Colors.black.withOpacity(.53),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.01),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Recording date: ',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: DateFormat('dd/MM/yyyy').format(
                                controller.tasks[index].recordingDate,
                              ),
                              style: GoogleFonts.inter(
                                color: Colors.black.withOpacity(.53),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
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
