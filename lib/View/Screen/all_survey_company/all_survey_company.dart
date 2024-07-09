import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/CustomSurveyCard/custom_survey_card.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';
import 'package:survey_markus/utils/ToastMsg/toast_message.dart';

class AllSurveyCompany extends StatelessWidget {
  const AllSurveyCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 1),
      backgroundColor: AppColors.backgroundColor,

      ///===================== All Survey Company Appbar ================
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle:true,
        title: const CustomText(
          text: AppStaticStrings.allSurveyCompany,
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.grayDarker,
        ),
      ),

      // Body with ListView builder
      body: Padding(

        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),

       child:  Column(
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

            SizedBox(height: 28.h,),

           ///<============================ This is the survey company list =======================>

           Expanded(
             child: ListView.builder(itemBuilder:(context, index){
                  return  GestureDetector(
                  onTap: (){
                  Get.toNamed(AppRoute.allProjectScreen);
                  },
                  child: CustomSurveyCard(image:"https://media.istockphoto.com/id/178447404/photo/modern-business-buildings.jpg?s=612x612&w=0&k=20&c=MOG9lvRz7WjsVyW3IiQ0srEzpaBPDcc7qxYsBCvAUJs=",
                     buttonText: "Join Company",
                     companyName: "bdCalling IT ltd",
                     onTap:(){
                     toastMessage(message:"Click index  ${index}") ;
                     print("==========----=-=-=-=-=-");
                     },
                 ),
               );
             },),
           )

         ],
       ),

      ),
    );
  }
}