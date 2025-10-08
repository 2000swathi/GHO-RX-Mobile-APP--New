import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class ReusableBtn extends StatelessWidget {
  final String btnName;
  final void Function() onTap;
  final Color bgColor;
  final Color textColor;

  const ReusableBtn({
    super.key,
    required this.btnName,
    required this.onTap,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 180,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            btnName,
            style: AppFonts.hinttext.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
