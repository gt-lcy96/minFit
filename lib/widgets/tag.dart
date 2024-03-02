import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget tag(String text, Color color) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: 180.w,
    ),
    child: Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, overflow: TextOverflow.clip),
    ),
  );
}