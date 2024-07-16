import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/core/app_routes/app_routes.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
       centerTitle: true,
       title:const CustomText(text:AppStaticStrings.allResult,fontSize: 24,fontWeight: FontWeight.w500,),
       ),

      body: Column(
       children: [
         Expanded(
           child: GridView.builder(
             shrinkWrap: true,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2, // Number of columns
               crossAxisSpacing: 5.w, // Spacing between columns
               mainAxisSpacing: 5.h, // Spacing between rows
               childAspectRatio: 0.8, // Adjusted aspect ratio
             ),
             itemCount:5,
             itemBuilder: (context, index) {
               return Padding(
                 padding:
                 EdgeInsets.all(15.w), // Adjusted for ScreenUtil
                 child: GestureDetector(
                   onTap: () {
                  Get.toNamed(AppRoute.allResultScreeen);
                   },
                   child: Container(
                   decoration:  BoxDecoration(
                   color: AppColors.yellowNormal,
                   borderRadius: BorderRadius.circular(8.r)
                   ),
                   padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
                   child: const Center(
                     child: CustomText(text:"Project 1",color: AppColors.whiteNormal,fontWeight: FontWeight.w400,fontSize: 12,),
                   ),
                   ),
                 ),
               );
             },
           ),
         ),
       ],
      ),
    );
  }
}
