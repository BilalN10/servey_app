import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/CustomfeedbackCard/feedback_card.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class AllProjectScreen extends StatelessWidget {
  const AllProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:AppBar(
          centerTitle: true,
          title: Row(
          children: [
          ///<======================= This is company logo ===============================>

            CustomNetworkImage(imageUrl:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC2SGUn4hUElhp9PuU1US_9R6Fp9l7QJNsMw&s", height:40.h , width:58.w,
            boxShape: BoxShape.circle,
          ),

             SizedBox(width: 10.w,),
         ///<======================== This is the company name ===============================>

            const CustomText(text:"bdCalling IT ltd",fontSize: 20,fontWeight: FontWeight.w400,
            color: AppColors.yellowNormal,
            ),
          ],
          ),
          ),
          body:  Column(
          children: [
           const Center(child: CustomText(text: AppStaticStrings.allProjects,fontWeight: FontWeight.w500,fontSize: 20,)),

          SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
          child: Column(
          children: [
            ///<========================== This is the search field ======================>
            CustomTextField(
              onSubmit: (value) {
                //    articleController.getArticleByCategory(value, false);
              },
              hintText: AppStaticStrings.searchhere,
              isPrefixIcon: true,
              hintStyle: const TextStyle(color: AppColors.yellowNormal),
              prefixIconColor:AppColors.yellowNormal,
              focusBorderColor: AppColors.yellowNormalHover,
            ),

            SizedBox(height: 16.h,),

             // FeedbackCard(title: "Employee Feedback",),

            GridView.builder(
              itemCount: 10,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
              itemBuilder: (BuildContext context, int index) {
                return  FeedbackCard(title: "Employee Feedback",);
              },
            )
          ],
          ),
          ),
          ],
          ),
    );
  }
}
