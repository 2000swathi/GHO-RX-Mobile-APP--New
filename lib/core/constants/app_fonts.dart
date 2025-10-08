import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static const String primaryFont = "Roboto";

  static const TextStyle heading = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle subheading = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static const TextStyle subheading16 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle hinttext = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.offgreycolor,
  );
  static const TextStyle hinttext2 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.hint1color,
  );

  static const TextStyle labelItalic = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtext = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle textblue = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primarycolor,
  );
  static const TextStyle textprimary = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static const TextStyle textprimarygreen = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.green,
  );
  static const TextStyle textprimarygreen12 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.green,
  );
  static const TextStyle textSecondary = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle textwhite = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const TextStyle textappbar = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle textprogressbar = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primarycolor,
  );

  static const TextStyle semiratechart = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle textred = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.red,
  );
  //Roboto Condensed
  static TextStyle header_4 = GoogleFonts.asapCondensed(
    color: AppColors.textPrimary,
    fontSize: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );
  static TextStyle header_5 = GoogleFonts.asapCondensed(
    color: AppColors.textPrimary,
    fontSize: 20,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
  );
  // ignore: non_constant_identifier_names
  static TextStyle header_red = GoogleFonts.asapCondensed(
    color: AppColors.warningred,
    fontSize: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  // roboto flex
  static TextStyle buttontxt = GoogleFonts.robotoFlex(
    color: AppColors.white,
    fontSize: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle buttontxt16 = GoogleFonts.robotoFlex(
    color: AppColors.textSecondary,
    fontSize: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle numBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textSecondary,
  );
}
