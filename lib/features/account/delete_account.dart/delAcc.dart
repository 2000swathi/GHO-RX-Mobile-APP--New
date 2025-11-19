import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_dialog.dart';

class Delacc extends StatelessWidget {
  const Delacc({super.key});

  @override
  Widget build(BuildContext context) {
    return customDialog(
      svgPath: "assets/svg/account/del.svg",
      heading: "Delete Account",
      warningText:
          "Are you sure you want to delete your account? \nThis action cannot be undone.",
      colors: AppColors.red.withAlpha(15),
      imgColor: AppColors.red,
      btnTxt1: "cancel",
      btnbg1: AppColors.cards1,
      btnTextClr: AppColors.textPrimary,
      btnTxt2: "Delete Account",
      btnbg2: AppColors.red,
    );
  }
}
