import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_fitness/constants/colors.dart';

class ShadowedCard extends StatelessWidget {
  const ShadowedCard({
    super.key,
    required this.child,
    this.height = 200,
    this.width = 200,
    this.radius = 20,
    this.paddingAll = 15,
    this.backgroundColor = AppColors.primaryDarkColorDark,
  });

  final Widget child;
  final double height;
  final double width;
  final double radius;
  final double paddingAll;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(paddingAll),
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: child);
  }
}
