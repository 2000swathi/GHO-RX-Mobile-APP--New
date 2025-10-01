import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6), // 👈 Add ripple clipping
      child: Container(
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primarycolor,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: Text(
            text,
            style: AppFonts.textwhite,
          ),
        ),
      ),
    );
  }
}
