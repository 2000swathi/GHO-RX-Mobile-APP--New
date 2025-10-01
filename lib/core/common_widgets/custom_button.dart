import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
  });

  @override
  Widget build(BuildContext context) {
    return isOutlined
        ? OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primarycolor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: padding,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.primarycolor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primarycolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: padding,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
