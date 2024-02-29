import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_fitness/constants/colors.dart';
import 'package:min_fitness/widgets/appIcon_text.dart';
import 'package:min_fitness/widgets/colored_text.dart';
import 'package:min_fitness/widgets/shadow_card.dart';

Widget addExcerciseContent() {
  return ShadowedCard(
    width: 200,
    height: 150,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ColoredText(text: 'Exercise'),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
                onTap: () {},
                child: const Icon(Icons.add, color: AppColors.onSurfaceTextColor)),
          ],
        ),
        const AppIconText(
            icon: Icon(Icons.schedule, color: Colors.redAccent),
            text: ColoredText(text: '00: 00 hr'),
            spaceBetween: 10),
        SizedBox(height: 5.h,),
        const AppIconText(
            icon: Icon(Icons.local_fire_department, color: Colors.redAccent),
            text: ColoredText(text: '0 cal'),
            spaceBetween: 10),
      ],
    ),
  );
}
