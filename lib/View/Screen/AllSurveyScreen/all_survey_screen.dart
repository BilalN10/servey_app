import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/CustomfeedbackCard/feedback_card.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class AllSurveyScreen extends StatelessWidget {
  const AllSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            ///<======================= This is company logo ===============================>

            CustomNetworkImage(
              imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC2SGUn4hUElhp9PuU1US_9R6Fp9l7QJNsMw&s",
              height: 40.h,
              width: 58.w,
              boxShape: BoxShape.circle,
            ),

            SizedBox(
              width: 10.w,
            ),

            ///<======================== This is the company name ===============================>

            const CustomText(
              text: "bdCalling IT ltd",
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.yellowNormal,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          ///<==================== This is the all project text ========================>

          Center(
              child: CustomText(
                text: AppStaticStrings.allSurvey,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                top: 16.h,
              )),

          Column(
            children: [
              ///<========================== This is the search field ======================>

              SizedBox(
                height: 16.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: CustomTextField(
                  onSubmit: (value) {
                    //    articleController.getArticleByCategory(value, false);
                  },
                  hintText: AppStaticStrings.searchhere,
                  isPrefixIcon: true,
                  hintStyle: const TextStyle(color: AppColors.yellowNormal),
                  prefixIconColor: AppColors.yellowNormal,
                  focusBorderColor: AppColors.yellowNormalHover,
                ),
              ),

              ///<========================== This is the image section ========================>
              SizedBox(
                height: 16.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: const CustomImage(
                  imageSrc: AppImages.allSurveyImage,
                  imageType: ImageType.png,
                ),
              )
            ],
          ),

          ///<=========================== This is the all feed back ====================>

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return FeedbackCard(title: "Customer Feedback",
                    onTap:(){Get.toNamed(AppRoute.mainSurvey);},);
                },
                itemCount: 100, // Total number of items in the grid
              ),
            ),
          ),
        ],
      ),
    );
  }
}
