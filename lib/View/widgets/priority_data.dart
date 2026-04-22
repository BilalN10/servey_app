import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/Screen/home/model/project_issue_model.dart';

class PriorityData extends StatelessWidget {
  PriorityData({super.key, required this.index, required this.projectIssue});
  final ProjectIssueModel projectIssue;
  final int index;
  final HomeController controller = Get.find<HomeController>();

  String _formatDeadline(String? deadLine) {
    if (deadLine == null || deadLine.isEmpty) {
      return 'N/A';
    }

    try {
      final date = DateTime.parse(deadLine);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String _getPriorityDisplayValue(String? priority) {
    if (priority == null || priority.isEmpty) {
      return 'N/A';
    }

    switch (priority.trim()) {
      case '1':
        return 'Low';
      case '2':
        return 'Medium';
      case '3':
        return 'High';
      default:
        return priority; // Return original value if not 1, 2, or 3
    }
  }

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
                'Priority: ${projectIssue.priority}',
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
                      text: projectIssue.status ?? 'Open',
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
                  text: _formatDeadline(projectIssue.deadLine),
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
