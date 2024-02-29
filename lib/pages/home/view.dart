import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/widgets/appIcon_text.dart';
import 'package:min_fitness/widgets/colored_text.dart';
import 'package:min_fitness/widgets/shadow_card.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
            // margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: addExcerciseContent(),
          )
        ],
      ),
    );
  }
}

Widget caloriesContent() {
  return ShadowedCard(
    width: Get.width * 0.8,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        ColoredText(
          text: 'Calories',
          fontSize: 20,
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconText(
                icon: Icon(Icons.outlined_flag,
                    color: AppColors.onSurfaceTextColor),
                text: Column(
                  children: [
                    ColoredText(text: 'Target', fontSize: 12),
                    ColoredText(
                      text: '1510',
                      fontSize: 12,
                    ),
                  ],
                )),
            SizedBox(width: 10.w),
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 15.0,
              percent: 0.8,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Remaining",
                      style: TextStyle(color: AppColors.onSurfaceTextColor)),
                  Text("1156",
                      style: TextStyle(color: AppColors.onSurfaceTextColor)),
                ],
              ),
              progressColor: AppColors.primaryLightColor,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            SizedBox(width: 10.w),
            AppIconText(
              icon: Icon(Icons.restaurant, color: AppColors.onSurfaceTextColor),
              text: Column(
                children: [
                  ColoredText(text: 'Eaten', fontSize: 12),
                  ColoredText(
                    text: '${1510 - 1156}',
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget addExcerciseContent() {
  return ShadowedCard(
    width: 200,
    height: 150,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ColoredText(text: 'Exercise'),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
                onTap: () {},
                child: Icon(Icons.add, color: AppColors.onSurfaceTextColor)),
          ],
        ),
        AppIconText(
            icon: Icon(Icons.schedule, color: Colors.redAccent),
            text: ColoredText(text: '00: 00 hr'),
            spaceBetween: 10),
        SizedBox(height: 5.h,),
        AppIconText(
            icon: Icon(Icons.local_fire_department, color: Colors.redAccent),
            text: ColoredText(text: '0 cal'),
            spaceBetween: 10),
      ],
    ),
  );
}
