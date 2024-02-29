import 'package:flutter/material.dart';

class AppColors {
  static const onSurfaceTextColor = Colors.white;
  static const primaryLightColor = Color.fromARGB(255, 106, 240, 224);

  static const Color primaryDarkColorDark = Color.fromARGB(255, 46, 52, 98);
  static const Color primaryColorDark = Color.fromARGB(255, 153, 179, 225);

  static const Color primaryLightColorLight = Color.fromARGB(255, 58, 203, 176);
  static const Color primaryColorLight = Color.fromARGB(255, 248, 81, 165);

  static const mainGradientLight = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [primaryLightColorLight, primaryColorLight]);

  static const mainGradientDark = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [primaryDarkColorDark, primaryColorDark]);

  static LinearGradient mainGradient() => mainGradientDark;
}
