import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class CommonQa extends StatelessWidget {
  final String qamsg1;
  final String ans;

  final Icon icon1;

  const CommonQa({
    super.key,
    required this.qamsg1,
    required this.icon1,
    required this.ans,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(width: 10),
        Column(
          children: [
            Column(
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
                Text(ans),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
