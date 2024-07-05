import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_markus/View/widgets/custom_company_card/custom_company_card.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/navBar/nav_bar.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      bottomNavigationBar:const NavBar(currentIndex:0),
      body: Column(
      children: [
      SizedBox(height: 64.h,),
      ///<====================== This is the app Bar ================>
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

      CustomImage(imageSrc:AppImages.appLogo,imageType: ImageType.png,sizeWidth: 139.w,),

      IconButton(onPressed:(){}, icon:const CustomImage(imageSrc:AppIcons.drawreIcon)),
      ],
      ),

      SizedBox(height: 14.h,),

             ///<=================== This is the top iamge section =============>
        ///
        ///
             const CustomImage(imageSrc:AppImages.surveyImage,imageType: ImageType.png,),

             SizedBox(height: 24.h,),
             ///<================== this is the  survey card ==================>
      GestureDetector(
        onTap: (){},
        child: Container(
        padding:EdgeInsets.symmetric(horizontal: 140.w,vertical: 40.h),

        decoration: BoxDecoration(
          color: AppColors.yellowNormal,
         borderRadius: BorderRadius.circular(4),
        ),

        child: const CustomText(text: AppStaticStrings.survey,color: AppColors.whiteNormal,),
        ),
      ),

       SizedBox(height: 29.h,),

       Expanded(
         child: ListView.builder(
             physics: const BouncingScrollPhysics(),
             itemCount: 10,
             itemBuilder:(context,index){
              return CustomCompanyCard(companyName: "BdCalling",image:AppImages.splashLogo,);


             }),
       ),


      SizedBox(height: 16.h,),


      ],
      ),
    );
  }
}
