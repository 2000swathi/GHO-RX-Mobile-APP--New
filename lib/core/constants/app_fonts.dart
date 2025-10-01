import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class AppFonts {
  static const String primaryFont = "Roboto";

  static const TextStyle heading = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textcolor,
  );

  static const TextStyle subheading = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textcolor,
  );

  static const TextStyle hinttext = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.hinttextcolor,
  );

  static const TextStyle label = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.textcolor,
  );

  static const TextStyle subtext = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textcolor,
  );

  static const TextStyle textblue = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primarycolor,
  );

  static const TextStyle textwhite = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.commonwhite,
  );
  
}