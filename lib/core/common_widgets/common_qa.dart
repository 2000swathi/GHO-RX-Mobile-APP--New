import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class CommonQa extends StatelessWidget {
  final String qamsg1;
  final String ans;

  final Widget bullet;

  const CommonQa({
    super.key,
    required this.qamsg1,
    required this.bullet,
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
                    SvgPicture.asset("assets/svg/blueBullet.svg"),
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
