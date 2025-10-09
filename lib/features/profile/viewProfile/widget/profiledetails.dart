import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class ProfileDtlContainer extends StatelessWidget {
  final String heading;
  final String subheading;
  final Widget info;
  final bool isExpanded;
  final VoidCallback onTap;
  final bool isadd;

  const ProfileDtlContainer({
    super.key,
    required this.heading,
    required this.subheading,
    required this.info,
    required this.isExpanded,
    required this.onTap,
    this.isadd = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading,
                        style: AppFonts.buttontxt.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        subheading,
                        style: AppFonts.subtext.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                isExpanded
                    ? SvgPicture.asset("assets/svg/arrow_up_svg.svg")
                    : SvgPicture.asset("assets/svg/arrow_under_svg.svg"),
              ],
            ),
            if (isExpanded)
              Column(
                children: [
                  Divider(color: AppColors.hint2color),
                  info,
                  isadd == true
                      ? Text("Add", style: AppFonts.textprogressbar)
                      : SizedBox.shrink(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
