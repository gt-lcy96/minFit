// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_fitness/constants/colors.dart';
import 'dart:math';

class LineChartWeight extends StatefulWidget {
  const LineChartWeight({super.key});

  @override
  State<LineChartWeight> createState() => LineChartWeightState();
}

class LineChartWeightState extends State<LineChartWeight> {
  List<Color> gradientColors = [
    // AppColors.contentColorCyan,
    // AppColors.contentColorBlue,
    Colors.cyan,
    Colors.blue,
  ];

  final Color mainGridLineColor = Colors.white10;


  final double minX = 0;
  final double maxX = 10;

  // late final List<FlSpot> lineBarData = [
  //   FlSpot(1, 72),
  //   FlSpot(2, 74),
  //   FlSpot(3, 78),
  //   FlSpot(4, 76),
  //   FlSpot(5, 72),
  //   FlSpot(6, 74),
  // ];

  final date_x = {2: '15/01', 4: '15/02', 6: '15/03'};

  final List<double> weight_y = [
    64,
    74,
    74,
    73,
    74,
    75,
  ];

  late List<double> y_range = [];

  late double weight_max = 100;
  late double weight_min = 0;
  late int std = 0;
  List y_marks = [];
  int y_mark_counter = 0;
  late List<FlSpot> lineBarData;

  double calculateAverage(List<num> numbers) {
    if (numbers.isEmpty) {
      return 0; // Handle the case when the list is empty to avoid division by zero
    }

    var sum = numbers.reduce((a, b) => a + b);
    return sum / numbers.length;
  }

  double calculateStandardDeviation(List<double> data) {
    // Compute the mean (average) of the data set
    double mean = data.reduce((a, b) => a + b) / data.length;

    // Compute the squared differences from the mean
    var squaredDifferences = data.map((value) => pow(value - mean, 2));

    // Compute the average of the squared differences (variance)
    double variance =
        squaredDifferences.reduce((a, b) => a + b) / (data.length - 1);

    // Take the square root of the variance to get the standard deviation
    double standardDeviation = sqrt(variance);

    return standardDeviation;
  }

  double find_max_in_list(List<double> numbers) {
    return numbers.reduce(
        (double value, double element) => value > element ? value : element);
  }

  double find_min_in_list(List<double> numbers) {
    return numbers.reduce(
        (double value, double element) => value < element ? value : element);
  }

  double calculate_weight_ratio(weight, max_with_bias) {
    return weight / max_with_bias;
  }

  @override
  void initState() {
    // TODO: implement initState

  int lineBarCounter = 0;
  lineBarData = weight_y.map((y) {
    lineBarCounter ++;
    return FlSpot(lineBarCounter.toDouble(), y);
  }).toList();


    std = calculateStandardDeviation(weight_y).round();
    weight_max = find_max_in_list(weight_y);
    weight_min = find_min_in_list(weight_y);

    double current_y_in_y_mark = weight_min - std;
    while (current_y_in_y_mark <= weight_max + std) {
      y_marks.add(current_y_in_y_mark);
      current_y_in_y_mark += std;

    }
  }

  @override
  Widget build(BuildContext context) {
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
                // showAvg ? avgData() : mainData(),
                mainData(),
              ),
            ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
            },
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
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: AppColors.onSurfaceTextColor,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('15/01', style: style);
        break;
      case 5:
        text = const Text('01/02', style: style);
        break;
      case 8:
        text = const Text('15/02', style: style);
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
      fontSize: 15,
      color: AppColors.onSurfaceTextColor,
    );
    String text;

    if (value == y_marks[y_mark_counter]) {
      if (y_mark_counter < y_marks.length - 1) {
        y_mark_counter++;
      }
      text = value.toInt().toString();
      return Text(text, style: style, textAlign: TextAlign.left);
    }

    // if (value >= 70 && value <= 80 && ) {
    //     text = value.toInt().toString();
    //     return Text(text, style: style, textAlign: TextAlign.left);
    //   }
    else {
      return Container();
    }
    // return Text(text, style: style, textAlign: TextAlign.left);
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
