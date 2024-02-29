import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIconText extends StatelessWidget {
  final Icon icon;
  final Widget text;
  final double spaceBetween;
  const AppIconText({
    super.key,
    required this.icon,
    required this.text,
    this.spaceBetween = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: spaceBetween.w,
        ),
        text,
      ],
    );
  }
}
