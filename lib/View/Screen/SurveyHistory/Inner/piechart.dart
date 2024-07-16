// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// class PieChart extends StatelessWidget {
//
//   Map<String,double> dataMap={
//     "Flutter":4,
//     "Dart":3,
//     "Android":2,
//     "IOS":1,
//   };
//
//    PieChart({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: SfCircularChart(
//           legend:Legend(),
//           series: <CircularSeries>[
//             DoughnutSeries<SalesData, String>(
//               // Bind data source
//               dataSource: <SalesData>[
//                 SalesData('Jan', 35),
//                 SalesData('Feb', 28),
//                 SalesData('Mar', 34),
//                 SalesData('Apr', 32),
//                 SalesData('May', 40)
//               ],
//               xValueMapper: (SalesData sales, _) => sales.year,
//               yValueMapper: (SalesData sales, _) => sales.sales,
//               dataLabelSettings: const DataLabelSettings(isVisible: true),
//             )
//           ],
//         ),
//       );
//   }
// }
// class SalesData {
//   SalesData(this.year, this.sales);
//   final String year;
//   final double sales;
// }
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:pie_chart/pie_chart.dart';
//
// // // ignore: must_be_immutable
// // class PieChartSample extends StatelessWidget {
// //   Map<String, double> dataMap = {
// //     "Flutter": 4,
// //     "Firebase": 3,
// //     "Dart": 4,
// //     "Figma": 2,
// //     "YouTube": 1.5,
// //   };
// //   List<Color> colorsList = [
// //     Colors.blue,
// //     Colors.orange,
// //     Colors.deepPurpleAccent,
// //     Colors.greenAccent,
// //     Colors.redAccent,
// //   ];
// //   PieChartSample({super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // backgroundColor: Colors.blue[200],
// //       appBar: AppBar(
// //         backgroundColor: Colors.blue,
// //         title: const Text("Pie Chart"),
// //         centerTitle: true,
// //       ),
// //       body: Center(
// //         child: PieChart(
// //           colorList: colorsList,
// //           dataMap: dataMap,
// //           // chartType: ChartType.ring,
// //           chartLegendSpacing: 10,
// //           chartRadius: MediaQuery.of(context).size.width / 1.2,
// //           legendOptions: const LegendOptions(
// //               // legendPosition: LegendPosition.bottom,
// //               ),
// //           chartValuesOptions: const ChartValuesOptions(
// //             showChartValuesInPercentage: true,
// //             // showChartValuesOutside: true,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:survey_markus/View/widgets/custom_image/custom_image.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';

class PieChartScreen extends StatelessWidget {
   PieChartScreen({super.key,required this.index});

   int index=0;

   List<String> emojiList=[AppImages.rattingOneEmoji,AppImages.rattingTwoEmoji,AppImages.rattingThreeEmoji];

  //   Map<String,double> dataMap={
  //   "Very satisfied":40,
  //   "Good":30,
  //   "Bad":20,
  //   "Angry":10,
  // };
  //
    List<Map<String,double>> dataMap=[
     // {
     //    "Very satisfied":40,
     //    "Satisfied":40,
     //    "Good":30,
     //    "Bad":20,
     //    "Angry":10,
     // },
     //  {
     //    "Very satisfied":10,
     //    "Satisfied":10,
     //    "Good":20,
     //    "Bad":30,
     //    "Angry":40,
     //  },
     //  {
     //    "Very satisfied":40,
     //    "Satisfied":40,
     //    "Good":30,
     //    "Bad":20,
     //    "Angry":10,
     //  },
     //  {
     //    "Very satisfied":10,
     //    "Satisfied":10,
     //    "Good":20,
     //    "Bad":30,
     //    "Angry":40,
     //  },

      {
        "⭐ 5 Star ":40,
        "⭐ 4 Star ":30,
        "⭐ 3 Star ":20,
        "⭐ 2 Star ":10,
        "⭐ 1 Star ":10,
      },
      {
        "⭐ 5 Star ":10,
        "⭐ 4 Star ":20,
        "⭐ 3 Star ":30,
        "⭐ 2 Star ":40,
        "⭐ 1 Star ":40,
      },
      {
        "⭐ 5 Star":40,
        "⭐ 4 Star":30,
        "⭐ 3 Star":20,
        "⭐ 2 Star":10,
        "⭐ 1 Star":10,
      },
      {
        "⭐ 5 Star ":10,
        "⭐ 4 Star ":20,
        "⭐ 3 Star":30,
        "⭐ 2 Star ":40,
        "⭐ 1 Star ":40,
      },

    ];
   List<Color>colorsList =[
    AppColors.yellowNormal,
    AppColors.blueNormal,
    AppColors.yellowLightActive,
    AppColors.greenNormal,
    AppColors.yellowDarker,

  ];
  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap:dataMap[index],
       animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
       chartRadius: MediaQuery.of(context).size.width / 3.2,
       colorList:colorsList,
       initialAngleInDegree: 0,
       chartType: ChartType.disc,
       ringStrokeWidth: 32,
       centerText: "%",
      legendOptions:  const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape:BoxShape.circle,
        legendTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        ),
      ),

      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),

      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
