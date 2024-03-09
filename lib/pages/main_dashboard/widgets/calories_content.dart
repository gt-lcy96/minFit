import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/controllers/exercise_controller.dart';
import 'package:min_fitness/widgets/appIcon_text.dart';
import 'package:min_fitness/widgets/colored_text.dart';
import 'package:min_fitness/widgets/shadow_card.dart';
import 'package:min_fitness/widgets/shadow_card_no_height.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget caloriesContent() {
  return GetBuilder<ExerciseController>(builder: (controller) {
    final remainingCalories = controller.targetCalories + controller.calories_burned;
    return ShadowedCardNoHeight(
      width: (Get.width * 0.8).w,
      // height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          const ColoredText(
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
                  icon: const Icon(Icons.outlined_flag,
                      color: AppColors.onSurfaceTextColor),
                  text: Column(
                    children: [
                      const ColoredText(text: 'Target', fontSize: 12),
                      ColoredText(
                        text: '${controller.targetCalories.toStringAsFixed(0)}',
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
                    const Text("Remaining",
                        style: TextStyle(color: AppColors.onSurfaceTextColor)),
                    Text("${(remainingCalories).toStringAsFixed(0)}",
                        style: TextStyle(color: AppColors.onSurfaceTextColor)),
                  ],
                ),
                progressColor: AppColors.primaryLightColor,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              SizedBox(width: 10.w),
               AppIconText(
                icon:
                    const Icon(Icons.restaurant, color: AppColors.onSurfaceTextColor),
                text: Column(
                  children: [
                    const ColoredText(text: 'Eaten', fontSize: 12),
                    ColoredText(
                      text: '${controller.calories_burned.toStringAsFixed(0)}',
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
  });
}
