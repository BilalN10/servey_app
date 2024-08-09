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
import 'package:survey_markus/View/Screen/SurveyHistory/model/que_report_model.dart';
import 'package:survey_markus/utils/AppColors/app_colors.dart';
import 'package:survey_markus/utils/AppImg/app_img.dart';

class PieChartScreen extends StatelessWidget {
  PieChartScreen(
      {super.key,
    
      required this.questionModel,
      required this.isEmoji});


  final QuestionSurveyModel questionModel;
  final bool isEmoji;

  final List<String> emojiList = [
    AppImages.rattingOneEmoji,
    AppImages.rattingTwoEmoji,
    AppImages.rattingThreeEmoji
  ];

  final List<Color> colorsList = [
    const Color.fromARGB(255, 38, 135, 14),
    const Color.fromARGB(255, 156, 241, 139),
    const Color.fromARGB(255, 225, 244, 17),
    const Color.fromARGB(255, 193, 98, 100),
    AppColors.redColor,
  ];
  @override
  Widget build(BuildContext context) {
    final Map<String, double> emojiMap = {
      "😍 5 Star ": questionModel.optionPercentages!.five!.toDouble(),
      "😀 4 Star ": questionModel.optionPercentages!.four!.toDouble(),
      "😊 3 Star ": questionModel.optionPercentages!.three!.toDouble(),
      "😳 2 Star ": questionModel.optionPercentages!.two!.toDouble(),
      "😡 1 Star ": questionModel.optionPercentages!.one!.toDouble(),
    };

    final Map<String, double> starMap = {
      "⭐ 5 Star ": questionModel.optionPercentages!.five!.toDouble(),
      "⭐ 4 Star ": questionModel.optionPercentages!.four!.toDouble(),
      "⭐ 3 Star": questionModel.optionPercentages!.three!.toDouble(),
      "⭐ 2 Star ": questionModel.optionPercentages!.two!.toDouble(),
      "⭐ 1 Star ": questionModel.optionPercentages!.one!.toDouble(),
    };
    return PieChart(
      dataMap: isEmoji ? emojiMap : starMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorsList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      centerText: "%",
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
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
