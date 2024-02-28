import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/widgets/shadow_card.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: ShadowedCard(
              width: Get.width * 0.8,
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 15.0,
                percent: 0.8,
                center: new Text("80%"),
                progressColor: Color.fromARGB(255, 84, 147, 255),
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
          )
        ],
      ),
    );
  }
}
