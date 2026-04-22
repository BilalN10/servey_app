import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_markus/View/Screen/create/create_issue.dart';
import 'package:survey_markus/View/Screen/home/home_controller.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      required this.w,
      required this.h,
      required this.projectId,
      required this.projectName,
      required this.companyName,
      required this.companyImage});

  final double w;
  final double h;
  final String projectId;
  final String projectName;
  final String companyName;
  final String companyImage;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Container(
      width: w,
      height: h * 0.24,
      decoration: BoxDecoration(
        color: Color(0xffEBB105),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(.28),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CustomText(
                  text: projectName,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(height: h * 0.02),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    // width: w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.28),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: homeController.searchController,
                      onChanged: (value) {
                        homeController.searchProjectIssues(value);
                      },
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 7),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('assets/icons/search.svg'),
                        ),
                        hintText: 'Search Here',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.white.withOpacity(.9),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => CreateIssuePage(
                          projectName: projectName,
                          projectId: projectId,
                          companyName: companyName,
                          companyImage: companyImage,
                        ));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    // width: w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.28),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/icons/add.svg'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }
}
