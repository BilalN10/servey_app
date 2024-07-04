// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class FaqDesign extends StatelessWidget{
//   FaqDesign({super.key,});
//
//  // final List<Map<String, String>> faqList;
//
//   //final HomeController homeController = Get.find<HomeController>();
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return SingleChildScrollView(
//         child: Column(
//           children: List.generate(
//               homeController.faqModel.value.data!.length,
//               (index) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 15.h),
//               child: Column(
//                 children: [
//                   ///==================== Question Design =====================
//                   GestureDetector(
//                     onTap: () {
//                       if (homeController.selectedFqw.value == index) {
//                         homeController.selectedFqw.value = 100000;
//                       } else {
//                         homeController.selectedFqw.value = index;
//                       }
//
//                       homeController.selectedFqw.refresh();
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10.w),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: AppColors.dark200)),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: CustomText(
//                             textAlign: TextAlign.left,
//                             maxLines: 10,
//                             text:homeController.faqModel.value.data![index].question??"",
//                             //faqList[index]["que"]!,
//                             fontWeight: FontWeight.w500,
//                           )),
//                           IconButton(
//                               onPressed: () {
//                                 if (homeController.selectedFqw.value == index) {
//                                   homeController.selectedFqw.value = 100000;
//                                 } else {
//                                   homeController.selectedFqw.value = index;
//                                 }
//
//                                 homeController.selectedFqw.refresh();
//                               },
//                               icon: homeController.selectedFqw.value == index
//                                   ? const Icon(Icons.keyboard_arrow_down_rounded)
//                                   : const Icon(
//                                       Icons.keyboard_arrow_right_rounded))
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   ///==================== Ans Design =====================
//
//                   index == homeController.selectedFqw.value
//                       ? CustomExpandedSection(
//                           expand: index == homeController.selectedFqw.value
//                               ? true
//                               : false,
//                           child: Container(
//                             margin: const EdgeInsets.only(top: 8),
//                             padding: EdgeInsets.all(8.r),
//                             alignment: Alignment.center,
//                             height: 100.h,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: AppColors.additional.withOpacity(.4),
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             child: CustomText(
//                               textAlign: TextAlign.left,
//                               text: homeController.faqModel.value.data![index].answer??"",
//                               //faqList[index]["ans"]!,
//                               maxLines: 6,
//                             ),
//                           ))
//                       : const SizedBox()
//                 ],
//               ),
//             );
//           }),
//         ),
//       );
//     });
//   }
// }
