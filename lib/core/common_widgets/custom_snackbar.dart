import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

// only for authentication
class CustomSnackbar {
  static void show(BuildContext context, String content, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor:
            isSuccess ? AppColors.successcolor : AppColors.warningred,
      ),
    );
  }
}
