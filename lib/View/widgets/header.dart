import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_markus/View/Screen/create/create_issue.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.w, required this.h});

  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
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
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Creative IT Institute',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
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
                    Get.to(() => CreateIssuePage());
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
