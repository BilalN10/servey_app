import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class ConditionCard extends StatelessWidget {
  const ConditionCard(
      {super.key, required this.img, required this.title, required this.onTap});
  final String img;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.yellowDarkActive)),
        child: Row(
          children: [
            ///=====================- Img =====================
            Container(
                margin: const EdgeInsets.symmetric(horizontal:10,vertical: 10),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                fit: BoxFit.cover,
                image:NetworkImage(img))
                ),


            ),

            ///=====================- Text =====================
            Expanded(
                child: CustomText(
              textAlign: TextAlign.left,
              text: title,
              maxLines: 3,
            ))
          ],
        ),
      ),
    );
  }
}
