import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class CommonQa extends StatelessWidget {
  final String qamsg1;
  final String qamsg2;
  final String qamsg3;
  final Icon icon1;
  final Icon icon2;
  const CommonQa({
    super.key,
    required this.qamsg1,
    required this.icon1,
    required this.icon2,
    required this.qamsg2,
    required this.qamsg3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon1,
            SizedBox(width: 10.25.w),
            Flexible(
              child: Text(
                qamsg1,
                style: AppFonts.buttontxt.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 20),
            icon2,
            Text(
              qamsg2,
              style: AppFonts.textprimary.copyWith(
                color: AppColors.profilepink,
              ),
            ),
            SizedBox(width: 18.w),
            Text(
              qamsg3,
              style: AppFonts.textprimary.copyWith(
                color: AppColors.profilepink,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
