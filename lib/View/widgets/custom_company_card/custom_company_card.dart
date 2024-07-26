import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';

class CustomCompanyCard extends StatelessWidget {
  const CustomCompanyCard(
      {super.key, required this.image, required this.companyName});
  final String image;
  final String companyName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.r),
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColors.yellowNormal),
      child: Column(
        children: [
          // CustomImage(imageSrc:image,imageType: ImageType.png,size: 78.r,),

          CustomNetworkImage(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC2SGUn4hUElhp9PuU1US_9R6Fp9l7QJNsMw&s",
            height: 78.h,
            width: 78.w,
            borderRadius: BorderRadius.circular(8.r),
          ),

          CustomText(
            text: companyName,
            color: AppColors.whiteNormal,
            maxLines: 10,
            top: 8.h,
          ),
        ],
      ),
    );
  }
}
