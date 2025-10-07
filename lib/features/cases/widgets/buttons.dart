import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class ActionButtonCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isFilled;

  const ActionButtonCard({
    super.key,
    required this.text,
    this.onTap,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isFilled ? AppColors.primarycolor : Colors.transparent,
            border: Border.all(color: AppColors.primarycolor),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: isFilled
                ? AppFonts.buttontxt 
                : AppFonts.buttontxt, 
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
