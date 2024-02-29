import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_fitness/constants/colors.dart';

class ColoredText extends StatelessWidget {
  const ColoredText(
      {super.key,
      required this.text,
      this.fontSize = 16,
      this.color = AppColors.onSurfaceTextColor,
      this.fontWeight = FontWeight.normal
      });
  final Color color;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
