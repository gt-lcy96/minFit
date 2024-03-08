
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_fitness/constants/colors.dart';

Widget addWeightButton() {
  return InkWell(
    onTap: () {},
    child: Container(
      height: 45.h,
      width: 45.w,
      child: Icon(
        Icons.add,
        color: AppColors.onSurfaceTextColor,
      ),
    ),
  );
}
