import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Controller/surve_controller.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Inner/custom_toggle_button.dart';
import 'package:survey_markus/View/Screen/all_survey_company/all_survey_company.dart';
import 'package:survey_markus/View/widgets/custom_button/custom_button.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/View/widgets/custom_text_field/custom_text_field.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppIcons/app_icons.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class MainSurveySCreen extends StatelessWidget {
   MainSurveySCreen({super.key});

   List<String> emojiList=[AppImages.rattingOneEmoji,AppImages.rattingTwoEmoji,AppImages.rattingThreeEmoji,AppImages.rattingFourEmoji,AppImages.rattingFiveEmoji,];
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

      body:  GetBuilder<SurveController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 24.w),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///<====================== This is the survey text =========================>

               Center(child: CustomText(text:AppStaticStrings.survey,fontSize: 24,fontWeight: FontWeight.w500,top: 24.h,bottom: 24.h,)),

                ///<========================= This is language button ====================>

                 Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsets.only(left:150.w ),
                      child: const CustomToggleButton(),
                    )),

                 ///<=========================== This is the survey question ================>

                SizedBox(
                  height:100.h,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    //itemCount:controller.qustionList.length,
                    controller: controller.pageController,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return  CustomText(text:controller.qustionList[controller.qustionIndex],fontSize: 16,fontWeight: FontWeight.w500,
                        maxLines: 10,
                        top: 24.h,
                        bottom: 24.h,
                      );
                        //_buildCarouselItem(context, selectedIndex, itemIndex);
                    },
                  ),
                ),







                ///<============================ This is the emoji section ==================>

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:List.generate(emojiList.length,(index){

                    return Padding(
                      padding:  EdgeInsets.only(right:15.w),
                      child: SizedBox(
                       child:IconButton(onPressed:(){
                         controller.rattingTabIndex=index;
                         controller.update();
                       }, icon: CustomImage(imageSrc:emojiList[index],imageType: ImageType.png,
                         size:
                         controller
                         .rattingTabIndex==index?50:
                         35,)),
                      ),
                    );
                  },),
                  ),
                ),

                SizedBox(height: 12.h,),


                ///<=========================== This is the ratting bar ====================>

                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:List.generate(5,(index){
                      return  Icon(Icons.star,color: controller.rattingTabIndex>=index? AppColors.yellowNormal:AppColors.grayNormal,size: 38,);
                    },),
                    ),
                  ),
                ),

                SizedBox(height: 60.h,),


                 CustomText(text:AppStaticStrings.totalQuestion,bottom: 12.h,fontWeight: FontWeight.w500,fontSize: 12,),

               ///<========================================= This is the progressbar ==================>

                LinearProgressBar(
                  maxSteps: controller.qustionList.length,
                  progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
                  currentStep:controller.qustionIndex,
                  progressColor:AppColors.yellowNormal,
                  backgroundColor: Colors.grey,
                  minHeight: 14,

                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.w),
                  child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  CustomText(text:"${controller.qustionList.length}")  ,

                  CustomText(text:"${controller.qustionList.length-controller.qustionIndex}")
                  ],
                  ),
                ),

               SizedBox(height: 24.h,),

              ///<=========================== This is the comment box ==================>

              Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(horizontal:20.w),
              decoration: BoxDecoration(
              border:Border.all(width: 1.w,color:AppColors.grayLight),
              borderRadius: BorderRadius.only(topRight:Radius.circular(16.r),bottomRight:Radius.circular(16.r),topLeft:Radius.circular(8.r),bottomLeft: Radius.circular(8.r) ),
              ),
              child:Row(
              children: [
              ///<========================== This is the comment icon =================>

              Container(
              height:40.h,
              width: 40.w,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.blueDarker
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomImage(
                imageSrc: AppImages.commentIcon,imageType: ImageType.png,
                size: 20,
                ),
              ),
              ),

              ///<================================ This is text field ==================>

                SizedBox(width: 16.w,),

                 Expanded(
                  child:TextFormField(

                    decoration: InputDecoration(
                    hintText: "Write your comment here",
                    hintStyle: TextStyle(color: AppColors.grayNormalHover),
                    border: InputBorder.none
                    ),
                  )
                ),


              ],
              ),
              ),


              SizedBox(height: 24.h,),

              ///<============================= This is the next button ==================>
              Padding(
                padding: EdgeInsets.symmetric(horizontal:97.w),
                child: CustomButton(onTap:(){
                  if(controller.qustionList.length-1!=controller.qustionIndex){
                    controller.qustionIndex++;
                    controller.update();
                  }


                },fillColor:AppColors.yellowNormal,title: AppStaticStrings.next,),
              ),

                SizedBox(height: 16.h,),

                // Padding(
                //   padding:EdgeInsets.symmetric(horizontal: 97.w,),
                //   child: Container(
                //   padding: EdgeInsets.symmetric(horizontal: 75.w,vertical: 14.h),
                //   decoration: BoxDecoration(
                //   border: Border.all(
                //   width: 1.w ,
                //   color:AppColors.yellowNormal,
                //   ),
                //   borderRadius: BorderRadius.circular(8.r),
                //
                //   ),
                //   child: const Center(child: CustomText(text:"Quit",color:AppColors.yellowNormal,fontSize: 16,fontWeight: FontWeight.w400,)),
                //   ),
                // ),
              ],
              ),
            ),
          );
        }
      ),
    );

  }
}
