import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';

class CustomDropdown extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final List<String> items;
  final String? value;
  final Function(String?)? onChanged;
  final bool shouldTranslate;

  const CustomDropdown({
    super.key,
    required this.width,
    required this.hintText,
    required this.items,
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
          border: isEnabled
              ? Border.all(color: Color(0xffebb105))
              : Border.all(color: Color(0xff747474).withOpacity(.54)),
        ),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              padding: EdgeInsets.zero,
              isExpanded: true,
              hint: CustomText(
                text: hintText,
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                shouldTranslate: shouldTranslate,
              ),
              icon: Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isEnabled ? Color(0xffebb105) : Color(0x8A747474),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/dropdown-icon.svg',
                    color: Colors.white,
                  ),
                ),
              ),
              value: value,
              onChanged: onChanged,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: CustomText(
                    text: item,
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    shouldTranslate: shouldTranslate,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
