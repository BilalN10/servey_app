import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:survey_markus/View/Screen/SurveyHistory/Inner/line_chart.dart';
import 'package:survey_markus/View/Screen/SurveyHistory/Inner/piechart.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Controller/surve_controller.dart';
import 'package:survey_markus/View/Screen/SurveyMainScreen/Inner/custom_toggle_button.dart';
import 'package:survey_markus/View/widgets/custom_text/custom_text.dart';
import 'package:survey_markus/helper/network_img/network_img.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/StaticString/static_string.dart';

class SurveyHistory extends StatefulWidget {
  const SurveyHistory({super.key});

  @override
  State<SurveyHistory> createState() => _SurveyHistoryState();
}

class _SurveyHistoryState extends State<SurveyHistory> {
  List<String> periodicName = [
    AppStaticStrings.today,
    AppStaticStrings.thisWeek,
    AppStaticStrings.thisMonth,
    AppStaticStrings.lastMonth
  ];
  late bool isShowingMainData;

  bool click = false;

  String dropdownvalue = "Monthly";

  List<String> monthName = [
    "Jan",
    "Fab",
    "Mar",
    "Apr",
    "May",
    "June",
    'July',
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

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
      body: GetBuilder<ServeyController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///<====================== This is the survey text =========================>

                Center(
                    child: CustomText(
                  text: AppStaticStrings.survey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  top: 24.h,
                  bottom: 24.h,
                )),

                ///<========================= This is language button ====================>

                Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsets.only(left: 150.w),
                      child: const CustomToggleButton(),
                    )),

                ///<=========================== This is the survey question ================>

                // SizedBox(
                //   height:100.h,
                //   child: PageView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     //itemCount:controller.qustionList.length,
                //     controller: controller.pageController,
                //     itemBuilder: (BuildContext context, int itemIndex) {
                //       return  CustomText(text:controller.qustionList[controller.qustionIndex],fontSize: 16,fontWeight: FontWeight.w500,
                //         maxLines: 10,
                //         top: 24.h,
                //         bottom: 24.h,
                //       );
                //       //_buildCarouselItem(context, selectedIndex, itemIndex);
                //     },
                //   ),
                // ),

                CustomText(
                  text: controller.qustionList[controller.qustionIndex],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  maxLines: 10,
                  top: 24.h,
                  bottom: 24.h,
                ),

                ///<=============================== This is the graph switch button ========================>

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ///<=========================== This is the pai chart ===================================>

                    GestureDetector(
                      onTap: () {
                        controller.chartCategoryIndex = 1;
                        controller.update();
                      },
                      child: Container(
                        height: 33.h,
                        width: 74.w,
                        //margin: EdgeInsets.symmetric(horizontal:97.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.chartCategoryIndex == 1
                              ? AppColors.yellowNormal
                              : Colors.transparent,
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.yellowNormal,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: CustomText(
                            text: AppStaticStrings.paiChart,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: controller.chartCategoryIndex == 1
                                ? AppColors.whiteNormal
                                : AppColors.yellowNormal),
                      ),
                    ),

                    SizedBox(
                      width: 16.w,
                    ),

                    ///<=================================== This is the line chart ========================>

                    GestureDetector(
                      onTap: () {
                        controller.chartCategoryIndex = 2;
                        controller.update();
                      },
                      child: Container(
                          height: 33.h,
                          width: 74.w,
                          //margin: EdgeInsets.symmetric(horizontal:97.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.chartCategoryIndex == 2
                                ? AppColors.yellowNormal
                                : Colors.transparent,
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.yellowNormal,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomText(
                              text: AppStaticStrings.lineChart,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: controller.chartCategoryIndex == 2
                                  ? AppColors.whiteNormal
                                  : AppColors.yellowNormal)),
                    ),
                  ],
                ),

                SizedBox(
                  height: 24.h,
                ),

                ///<=============================== This is the tab bar =====================================>
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children:List.generate(4, (index) {
                //     return Padding(
                //       padding:  EdgeInsets.only(right: 29.w),
                //
                //       child: GestureDetector(
                //         onTap: (){
                //         controller.periodicGraphTabIndex=index;
                //         controller.update();
                //         print("This is table value${controller.periodicGraphTabIndex}");
                //         },
                //         child: Column(
                //         children: [
                //          CustomText(text:periodicName[index],fontSize: 14,fontWeight: FontWeight.w500,bottom: 12.h,),
                //         Container(
                //          height: 5.h,
                //          width: 46.w,
                //          color:controller.periodicGraphTabIndex==index?AppColors.yellowNormal:Colors.transparent,
                //         ),
                //         ],
                //         ),
                //       ),
                //     );
                //   },),
                //   ),
                // ),
                ///<==================================== This is divider =================================>
                Container(
                  height: 1.h,
                  color: AppColors.grayNormalHover,
                ),

                ///<================================ This is drop down section ======================>

                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              click = !click;
                            });
                          },
                          child: const CustomText(
                            text: "Monthly 🔽",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                      click == true
                          ? Container(
                              width: 150.w,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    monthName.length,
                                    (index) {
                                      return CustomText(
                                        text: monthName[index],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),

                SizedBox(
                  height: 16.h,
                ),

                controller.chartCategoryIndex == 1
                    ? PieChartScreen(index: controller.periodicGraphTabIndex)
                    //:LineChart(indeex:controller.periodicGraphTabIndex),

                    : const LineChartScreen(),

                SizedBox(
                  height: 5.h,
                ),

                // Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // children:List.generate(5,(index) {
                //   return CustomText(text: AppStaticStrings.submit);
                // },),
                // ),

                SizedBox(
                  height: 16.h,
                ),

                //  Center(child:Row(
                //    mainAxisAlignment: MainAxisAlignment.center,
                //    children: [
                //
                //      CustomImage(imageSrc:AppImages.rattingFiveEmoji,imageType: ImageType.png,sizeWidth: 30.w,),
                //
                //      CustomText(text: AppStaticStrings.verySatisfied,fontWeight: FontWeight.w500,fontSize: 14,left: 16.w,),
                //
                // //     CustomText(text: "80%",fontWeight: FontWeight.w500,fontSize: 14,left: 16.w,color: AppColors.yellowNormal,),
                //
                //    ],
                //  )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
