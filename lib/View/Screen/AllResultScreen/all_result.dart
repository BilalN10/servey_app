import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class AllResultScreen extends StatelessWidget {
  const AllResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: AppStaticStrings.allResult,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///<======================== This is the company name section ==================>

            Column(
             children: [

               const Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   CustomText(
                     textAlign: TextAlign.start,
                     text:"${AppStaticStrings.companyName}:  ",
                     fontWeight: FontWeight.w500,
                     fontSize: 14,
                   ),
                   Expanded(
                       child: CustomText(
                           text: "BdCalling IT Ltd",
                           fontWeight: FontWeight.w500,
                           fontSize: 12,
                           color: AppColors.yellowNormal,
                           textAlign: TextAlign.start)),
                 ],
               ),

               SizedBox(
                 height: 16.h,
               ),

               ///<======================== This is the project name section ==================>

               const Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   CustomText(
                     text: AppStaticStrings.projectName,
                     fontWeight: FontWeight.w500,
                     fontSize: 14,
                   ),
                   Expanded(
                       child: CustomText(
                           text: "  Employee Feedback",
                           fontWeight: FontWeight.w500,
                           fontSize: 12,
                           color: AppColors.yellowNormal,
                           maxLines: 2,
                           textAlign: TextAlign.start)),
                 ],
               ),

               SizedBox(
                 height: 16.h,
               ),

               ///<======================== This is the survey  name section ==================>

               const Row(
                 children: [
                   CustomText(
                     text: AppStaticStrings.surveyName,
                     fontWeight: FontWeight.w500,
                     fontSize: 14,
                   ),
                   Expanded(
                       child: CustomText(
                           text: "  Survey No 01",
                           fontWeight: FontWeight.w500,
                           fontSize: 12,
                           color: AppColors.yellowNormal,
                           textAlign: TextAlign.start)),
                 ],
               ),

               SizedBox(
                 height: 16.h,
               ),

               ///<======================== This is the total Question section ==================>

               const Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   CustomText(
                     text: "${AppStaticStrings.totalQuestion}:",
                     fontWeight: FontWeight.w500,
                     fontSize: 14,
                   ),
                   Expanded(
                       child: CustomText(
                         text: "  6",
                         fontWeight: FontWeight.w500,
                         fontSize: 12,
                         color: AppColors.yellowNormal,
                         textAlign: TextAlign.start,
                       )),
                 ],
               ),

               SizedBox(
                 height: 16.h,
               ),
             ],
             ),


            SizedBox(height: 24.h,),
            ///<========================== This is the all question section ================>
            Expanded(
              child: ListView.builder(
                itemCount:100,
                physics: const BouncingScrollPhysics(),
                itemBuilder:(context, index) {
                  return   GestureDetector(
                    onTap: (){
                    Get.toNamed(AppRoute.surveyHistoryScreen);
                    },
                    child: Column(
                      children: [

                        ///<========================== This is the question section ====================================>
                        ListTile(
                        leading:CustomText(text: "${AppStaticStrings.QN}${index+1}",fontSize: 14,fontWeight: FontWeight.w400,),
                        title:const CustomText(text: "How satisfied are you with your current work environment?",maxLines: 2,textAlign: TextAlign.start,),
                        ) ,

                        SizedBox(height: 20.h,),

                         ///<=========================== This is the ans section =======================================>

                         ListTile(
                        leading:const CustomText(text:AppStaticStrings.ans,fontSize: 14,fontWeight: FontWeight.w400,),
                        title: Row(
                        children: [
                        const CustomImage(imageSrc:AppImages.rattingFiveEmoji,imageType: ImageType.png,size: 16,),

                        CustomText(text:"Very satisfied",left: 16.w,)

                        ],
                        ),
                        ),
                      ],
                    ),
                  );
                },),
            ),

            ///<========================= This is the export button =======================>

            CustomButton(onTap:(){},title: AppStaticStrings.export,fillColor: AppColors.yellowNormal,),

          ],
        ),
      ),
    );
  }
}
