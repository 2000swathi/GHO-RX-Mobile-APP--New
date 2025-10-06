import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  bool iswhite;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.iswhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          color: iswhite == true ? AppColors.white : AppColors.primarycolor,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: Text(
            text,
            style: iswhite == true ? AppFonts.textblue : AppFonts.textwhite,
          ),
        ),
      ),
    );
  }
}
