// import 'package:chart_sparkline/chart_sparkline.dart';
// import 'package:flutter/material.dart';
//
// class LineChart extends StatelessWidget{
//    LineChart({super.key,required this.indeex});
//   int indeex;
//   List<List<double>>  data=  [
//
//     [ 0.0, 10.0, 1.5, 20.0, 10.0, 5.0, -0.5, -1.0, -0.5, 0.0, 0.0],
//     [ 0.0, 15.0, 10.5, 5.0, 20.0, 15.0, 10.5, 2.0, -0.5, 1.0, 0.0],
//     [ 0.0, 10.0, 1.5, 20.0, 10.0, 5.0, -0.5, -1.0, -0.5, 0.0, 0.0],
//     [ 0.0, 15.0, 10.5, 5.0, 20.0, 15.0, 10.5, 2.0, -0.5, 1.0, 0.0]
//   ];
//
//   @override
//   Widget build(BuildContext context){
//     return  Sparkline(
//       data:data[indeex],
//       pointsMode: PointsMode.all,
//       pointSize: 8.0,
//       pointColor: Colors.amber,
//     );;
//   }
// }


















// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:survey_markus/utils/AppColors/app_colors.dart';
//
// class LiineChart extends StatelessWidget {
//   const LiineChart({required this.isShowingMainData});
//
//   final bool isShowingMainData;
//
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       isShowingMainData ? sampleData1 : sampleData2,
//       duration: const Duration(milliseconds: 250),
//     );
//   }
//
//   LineChartData get sampleData1 => LineChartData(
//     lineTouchData: lineTouchData1,
//     gridData: gridData,
//     titlesData: titlesData1,
//     borderData: borderData,
//     lineBarsData: lineBarsData1,
//     minX: 0,
//     maxX: 14,
//     maxY: 4,
//     minY: 0,
//   );
//
//   LineChartData get sampleData2 => LineChartData(
//     lineTouchData: lineTouchData2,
//     gridData: gridData,
//     titlesData: titlesData2,
//     borderData: borderData,
//     lineBarsData: lineBarsData2,
//     minX: 0,
//     maxX: 14,
//     maxY: 6,
//     minY: 0,
//   );
//
//   LineTouchData get lineTouchData1 => LineTouchData(
//     handleBuiltInTouches: true,
//     touchTooltipData: LineTouchTooltipData(
//       getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
//     ),
//   );
//
//   FlTitlesData get titlesData1 => FlTitlesData(
//     bottomTitles: AxisTitles(
//       sideTitles: bottomTitles,
//     ),
//     rightTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     topTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: leftTitles(),
//     ),
//   );
//
//   List<LineChartBarData> get lineBarsData1 => [
//     lineChartBarData1_1,
//     lineChartBarData1_2,
//     lineChartBarData1_3,
//   ];
//
//   LineTouchData get lineTouchData2 => const LineTouchData(
//     enabled: false,
//   );
//
//   FlTitlesData get titlesData2 => FlTitlesData(
//     bottomTitles: AxisTitles(
//       sideTitles: bottomTitles,
//     ),
//     rightTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     topTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: leftTitles(),
//     ),
//   );
//
//   List<LineChartBarData> get lineBarsData2 => [
//     lineChartBarData2_1,
//     lineChartBarData2_2,
//     lineChartBarData2_3,
//   ];
//
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '1m';
//         break;
//       case 2:
//         text = '2m';
//         break;
//       case 3:
//         text = '3m';
//         break;
//       case 4:
//         text = '5m';
//         break;
//       case 5:
//         text = '6m';
//         break;
//       default:
//         return Container();
//     }
//
//     return Text(text, style: style, textAlign: TextAlign.center);
//   }
//
//   SideTitles leftTitles() => SideTitles(
//     getTitlesWidget: leftTitleWidgets,
//     showTitles: true,
//     interval: 1,
//     reservedSize: 40,
//   );
//
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 2:
//         text = const Text('SEPT', style: style);
//         break;
//       case 7:
//         text = const Text('OCT', style: style);
//         break;
//       case 12:
//         text = const Text('DEC', style: style);
//         break;
//       default:
//         text = const Text('');
//         break;
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 10,
//       child: text,
//     );
//   }
//
//   SideTitles get bottomTitles => SideTitles(
//     showTitles: true,
//     reservedSize: 32,
//     interval: 1,
//     getTitlesWidget: bottomTitleWidgets,
//   );
//
//   FlGridData get gridData => const FlGridData(show: false);
//
//   FlBorderData get borderData => FlBorderData(
//     show: true,
//     border: Border(
//       bottom:
//       BorderSide(color: AppColors.yellowNormal.withOpacity(0.2), width: 4),
//       left: const BorderSide(color: Colors.transparent),
//       right: const BorderSide(color: Colors.transparent),
//       top: const BorderSide(color: Colors.transparent),
//     ),
//   );
//
//   LineChartBarData get lineChartBarData1_1 => LineChartBarData(
//     isCurved: true,
//     color: AppColors.greenNormal,
//     barWidth: 8,
//     isStrokeCapRound: true,
//     dotData: const FlDotData(show: false),
//     belowBarData: BarAreaData(show: false),
//     spots: const [
//       FlSpot(1, 1),
//       FlSpot(3, 1.5),
//       FlSpot(5, 1.4),
//       FlSpot(7, 3.4),
//       FlSpot(10, 2),
//       FlSpot(12, 2.2),
//       FlSpot(13, 1.8),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData1_2 => LineChartBarData(
//     isCurved: true,
//     color: AppColors.blueNormal,
//     barWidth: 8,
//     isStrokeCapRound: true,
//     dotData: const FlDotData(show: false),
//     belowBarData: BarAreaData(
//       show: false,
//       color: AppColors.blueNormal.withOpacity(0),
//     ),
//     spots: const [
//       FlSpot(1, 1),
//       FlSpot(3, 2.8),
//       FlSpot(7, 1.2),
//       FlSpot(10, 2.8),
//       FlSpot(12, 2.6),
//       FlSpot(13, 3.9),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData1_3 => LineChartBarData(
//     isCurved: true,
//     color: AppColors.greenNormal,
//     barWidth: 8,
//     isStrokeCapRound: true,
//     dotData: const FlDotData(show: false),
//     belowBarData: BarAreaData(show: false),
//     spots: const [
//       FlSpot(1, 2.8),
//       FlSpot(3, 1.9),
//       FlSpot(6, 3),
//       FlSpot(10, 1.3),
//       FlSpot(13, 2.5),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData2_1 => LineChartBarData(
//     isCurved: true,
//     curveSmoothness: 0,
//     color: AppColors.greenNormal.withOpacity(0.5),
//     barWidth: 4,
//     isStrokeCapRound: true,
//     dotData: const FlDotData(show: false),
//     belowBarData: BarAreaData(show: false),
//     spots: const [
//       FlSpot(1, 1),
//       FlSpot(3, 4),
//       FlSpot(5, 1.8),
//       FlSpot(7, 5),
//       FlSpot(10, 2),
//       FlSpot(12, 2.2),
//       FlSpot(13, 1.8),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData2_2 => LineChartBarData(
//     isCurved: true,
//     color: AppColors.blueNormal.withOpacity(0.5),
//     barWidth: 4,
//     isStrokeCapRound: true,
//     dotData: const FlDotData(show: false),
//     belowBarData: BarAreaData(
//       show: true,
//       color: AppColors.blueNormal.withOpacity(0.2),
//     ),
//     spots: const [
//       FlSpot(1, 1),
//       FlSpot(3, 2.8),
//       FlSpot(7, 1.2),
//       FlSpot(10, 2.8),
//       FlSpot(12, 2.6),
//       FlSpot(13, 3.9),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData2_3 => LineChartBarData(
//     isCurved: true,
//     curveSmoothness: 0,
//     color: AppColors.greenNormal.withOpacity(0.5),
//     barWidth: 2,
//     isStrokeCapRound: true,
//     dotData: const FlDotData(show: true),
//     belowBarData: BarAreaData(show: false),
//     spots: const [
//       FlSpot(1, 3.8),
//       FlSpot(3, 1.9),
//       FlSpot(6, 5),
//       FlSpot(10, 3.3),
//       FlSpot(13, 4.5),
//     ],
//   );
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartScreen extends StatelessWidget {
  const LineChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(

      // Initialize category axis
        primaryXAxis: CategoryAxis(),
       enableSideBySideSeriesPlacement: true,
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            // Bind data source
              dataSource:  <SalesData>[
                // SalesData('😡', 0),
                // SalesData('😳', 60),
                // SalesData('😊', 10),
                // SalesData('😀',80),
                // SalesData('😍',30),

                SalesData('Jan',0),
                SalesData('Feb',60),
                SalesData('Mar',10),
                SalesData('Apr',80),
                SalesData('May',30),
                SalesData('June',30),
                SalesData('July',30),
                SalesData('Aug',34),
                SalesData('Sept',40),
                SalesData('Oct',20),
                SalesData('Nov',25),
                SalesData('Dec',15),


                // SalesData('May', 40)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales
          )
        ]
    );
  }
}


class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;

}