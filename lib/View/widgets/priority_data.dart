import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';

class PriorityData extends StatelessWidget {
  PriorityData({super.key, required this.index});
  final int index;
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Priority: ${controller.tasks[index].priority}',
                style: GoogleFonts.inter(
                  height: 1.5,
                  color: Color(0xffff0000),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Status: ',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Open',
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
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Deadline: ',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: DateFormat(
                    'dd/MM/yyyy',
                  ).format(controller.tasks[index].deadline),
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
    );
  }
}
