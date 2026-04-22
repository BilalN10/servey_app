import 'package:get/get.dart';
import 'package:survey_markus/global/controller/generel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.color = AppColors.blueDark,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.height,
    this.shouldTranslate = false,
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final TextDecoration? decoration;
  final double? height;
  final bool shouldTranslate;

  @override
  Widget build(BuildContext context) {
    Widget textWidget(String displayValue) {
      return Text(
        displayValue,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.poppins(
          fontSize: fontSize.w,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
          height: height,
        ),
      );
    }

    return Padding(
      padding:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: shouldTranslate
          ? Obx(() {
              GeneralController generalController =
                  Get.find<GeneralController>();
              // Access the observable value to satisfy Obx requirement
              final _ = generalController.transLangu.value;
              return FutureBuilder<String>(
                future: generalController.translateString(text),
                initialData: text,
                builder: (context, snapshot) {
                  return textWidget(snapshot.data ?? text);
                },
              );
            })
          : textWidget(text),
    );
  }
}
