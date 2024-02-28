import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomScaleTransition extends CustomTransition {
  @override
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(scale: animation, child: child);
  }
}
