import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.width,
    required this.hintText,
    required this.value,
    this.onChanged,
    this.height = 50,
  });

  final double width;
  final double height;
  final String hintText;
  final DateTime? value;
  final Function(DateTime?)? onChanged;

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
            color:
                isEnabled
                    ? Color(0xffebb105)
                    : Color(0xff747474).withOpacity(.54),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value != null
                  ? DateFormat('dd/MM/yyyy').format(value!)
                  : hintText,
              style: GoogleFonts.inter(
                color: value != null ? Colors.black : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap:
                  onChanged != null
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
