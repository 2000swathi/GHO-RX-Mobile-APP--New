import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double fitSize(double width,
      {double maxWidth = 0, double minWidth = 0}) {
    if (maxWidth == 0) maxWidth = width;
    if (width > maxWidth) return maxWidth;
    if (width < minWidth) return minWidth;
    return width;
  }
}

extension SizeExtension on num {
  double get w =>
      SizeConfig.fitSize(toDouble() * (SizeConfig.screenWidth / 393));
  double get h =>
      SizeConfig.fitSize(toDouble() * (SizeConfig.screenHeight / 852));
}
