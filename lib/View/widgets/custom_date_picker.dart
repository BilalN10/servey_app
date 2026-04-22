import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';

class CustomDatePicker extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final DateTime? value;
  final Function(DateTime?)? onChanged;
  final bool shouldTranslate;

  const CustomDatePicker({
    super.key,
    required this.width,
    required this.hintText,
    required this.value,
    this.onChanged,
    this.height = 50,
    this.shouldTranslate = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onChanged != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 5),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xff747474).withOpacity(.54),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            value != null
                ? Text(
                    DateFormat('dd/MM/yyyy').format(value!),
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : CustomText(
                    text: hintText,
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    shouldTranslate: shouldTranslate,
                  ),
            const Spacer(),
            GestureDetector(
              onTap: onChanged != null
                  ? () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: value ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xffebb105),
                                onPrimary: Colors.white,
                                surface: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        onChanged!(picked);
                      }
                    }
                  : null,
              child: SvgPicture.asset('assets/icons/calendar.svg'),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
