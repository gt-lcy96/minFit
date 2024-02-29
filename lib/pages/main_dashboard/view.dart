import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/pages/main_dashboard/widgets/addExercise_content.dart';
import 'package:min_fitness/pages/main_dashboard/widgets/calories_content.dart';
import 'package:min_fitness/pages/main_dashboard/widgets/line_chart.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: caloriesContent(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: addExcerciseContent(),
            ),
            SizedBox(
              height: 20.h
            ),
            ShadowedCard(
              width: Get.width * 0.8,
              height: 180,
              paddingAll: 0,
              child: LineChartSample2(),
            ),
          ],
        ),
      ),
    );
  }
}