// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/weight_controller.dart';
import 'dart:math';

import 'package:min_fitness/helper/calculation.dart';
import 'package:min_fitness/helper/convert_time.dart';
import 'package:min_fitness/mock_data/weight_with_date.dart';
import 'package:min_fitness/models/weight_model.dart';

class LineChartWeight extends StatefulWidget {
  const LineChartWeight({super.key});

  @override
  State<LineChartWeight> createState() => LineChartWeightState();
}

class LineChartWeightState extends State<LineChartWeight> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  final Color mainGridLineColor = Colors.white10;

  late double minX;
  late double maxX;
  late double std_x;

  late List<double> y_range = [];
  late double maxY;
  late double minY;
  late double quarter_Y;
  late int std_y = 0;
  List y_marks = [];
  int y_mark_counter = 0;
  late List<FlSpot> lineBarData;

  // final weightDate = WeightOnDate.weightDate;
  // final weightDate = Get.find<WeightController>().weight_with_date;
  late List<DateTime> dateList;
  late DateTime threeMonthsAgo;

  double dateTimeToDouble(DateTime date, DateTime referenceDate) {
    return date.difference(referenceDate).inDays.toDouble();
  }

  String formatDate(DateTime dateTime) {
    // Format the date as 'MM-dd' or any format you prefer
    return "${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    //calculate threeMonthsAgo from the latestDate for reference date in x axis

    // dateList = weightDate
    //     .map((Map<String, dynamic> e) => DateTime.parse(e['date']))
    //     .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeightController>(builder: (controller) {
      DateTime latestDate = controller.weight_with_date
          .map((WeightModel data) => data.date)
          .reduce((a, b) => a.isAfter(b) ? a : b);
      threeMonthsAgo =
          DateTime(latestDate.year, latestDate.month - 3, latestDate.day);

      final autoFilled_date = fillInDates(controller.weight_with_date);

      lineBarData = autoFilled_date.map((WeightModel e) {
        final datetime = e.date;
        final double_date = dateTimeToDouble(datetime, threeMonthsAgo);

        return FlSpot(double_date, e.weight.toDouble());
      }).toList();

      final xList = lineBarData.map((FlSpot e) => e.x).toList();
      std_x = calculateStandardDeviation(xList);
      // minX = find_min_in_list(xList) - std_x;
      minX = 0;
      maxX = find_max_in_list(xList) + std_x;

      final yList = lineBarData.map((FlSpot e) => e.y).toList();
      std_y = calculateStandardDeviation(yList).round();
      maxY = find_max_in_list(yList);
      minY = find_min_in_list(yList);

      find_quater_difference(a, b) {
        return ((a - b).abs() / 3).round().toDouble();
      }

      quarter_Y = find_quater_difference(minY, maxY);
      y_marks = [minY - 1, minY + quarter_Y, maxY - quarter_Y, maxY + 1];
      y_marks = y_marks.map((e) => e.round().toDouble()).toList();

      return Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.78,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                // top: 24,
                top: 36,
                bottom: 12,
              ),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: 34,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Wght',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: AppColors.onSurfaceTextColor,
    );
    Widget text;
    final date = convertDoubleToDate(value, threeMonthsAgo);
    final formatedText = formatDate(date);

    switch (value.toInt()) {
      case 30:
        text = Text(formatedText, style: style);
        break;
      case 60:
        text = Text(formatedText, style: style);
        break;
      case 90:
        text = Text(formatedText, style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: AppColors.onSurfaceTextColor,
    );
    String text;

    if (value == y_marks[y_mark_counter]) {
      if (y_mark_counter < y_marks.length - 1) {
        y_mark_counter++;
      }
      text = value.toInt().toString();
      return Text(text, style: style, textAlign: TextAlign.left);
    } else {
      return Container();
    }
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: minX,
      maxX: maxX,
      minY: y_marks.first,
      maxY: y_marks.last,
      lineBarsData: [
        LineChartBarData(
          spots: lineBarData,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
