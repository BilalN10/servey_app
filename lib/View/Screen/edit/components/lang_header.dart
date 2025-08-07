import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LangHeader extends StatelessWidget {
  const LangHeader({
    super.key,
    required this.w,
    required this.h,
    required this.children,
  });

  final double w;
  final double h;
  final List<Widget> children;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project Uprising',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: w * .35,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.37),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(children: children),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.02),
          ],
        ),
      ),
    );
  }
}
