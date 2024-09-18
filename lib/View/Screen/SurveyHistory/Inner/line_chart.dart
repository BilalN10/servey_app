// import 'package:flutter/material.dart';
// import 'package:survey_markus/View/Screen/SurveyHistory/model/que_report_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class LineChartScreen extends StatelessWidget {
//   const LineChartScreen(
//       {super.key, required this.questionModel, required this.isEmoji});

//   final QuestionSurveyModel questionModel;
//   final bool isEmoji;

//   @override
//   Widget build(BuildContext context) {
//     List<SalesData>? emojiDataSource = [
//       SalesData('😡', questionModel.optionPercentages!.one!.toDouble()),
//       SalesData('😳', questionModel.optionPercentages!.two!.toDouble()),
//       SalesData('😊', questionModel.optionPercentages!.three!.toDouble()),
//       SalesData('😀', questionModel.optionPercentages!.four!.toDouble()),
//       SalesData('😍', questionModel.optionPercentages!.five!.toDouble()),
//     ];

//     List<SalesData>? starDataSource = [
//       SalesData('1 ⭐️', questionModel.optionPercentages!.one!.toDouble()),
//       SalesData('2 ⭐️', questionModel.optionPercentages!.two!.toDouble()),
//       SalesData('3 ⭐️', questionModel.optionPercentages!.three!.toDouble()),
//       SalesData('4 ⭐️', questionModel.optionPercentages!.four!.toDouble()),
//       SalesData('5 ⭐️', questionModel.optionPercentages!.five!.toDouble()),
//     ];

//     return SfCartesianChart(

//         // Initialize category axis
//         primaryXAxis: const CategoryAxis(),
//         enableSideBySideSeriesPlacement: true,
//         series: <LineSeries<SalesData, String>>[
//           LineSeries<SalesData, String>(
//               // Bind data source
//               dataSource: isEmoji ? emojiDataSource : starDataSource,
//               xValueMapper: (SalesData sales, _) => sales.year,
//               yValueMapper: (SalesData sales, _) => sales.sales)
//         ]);
//   }
// }

// class SalesData {
//   SalesData(this.year, this.sales);
//   final String year;
//   final double sales;
// }
