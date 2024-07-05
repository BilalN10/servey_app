import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class CustomCompanyCard extends StatelessWidget {

   CustomCompanyCard({super.key,required this.image,required this.companyName});
  String image;
  String companyName;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(10.r),
      padding: EdgeInsets.symmetric(horizontal:40.w,vertical: 40.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.r),
      color: AppColors.yellowNormal
      ),
      child: Column(
      children: [
       CustomImage(imageSrc:image,imageType: ImageType.png,size: 78.r,),

       CustomText(text:companyName,color: AppColors.whiteNormal,maxLines: 10,top: 8.h,),

      ],
      ),
    );
  }
}
