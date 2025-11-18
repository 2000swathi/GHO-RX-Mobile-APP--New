import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class commonInfoContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String svgPath;
  final Widget? arrowicon;
  final Widget? actionBtn;
  const commonInfoContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.svgPath,
    this.arrowicon,
    this.actionBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.black.withAlpha(12)),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          bottom: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(svgPath),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppFonts.subheading16, maxLines: 1),
                  SizedBox(height: 8),
                  Text(
                    subTitle,
                    maxLines: 2,
                    style: AppFonts.subtext.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(),
            Icon(Icons.chevron_right),
            // ToggleButtons(children: toggle, isSelected: isSelected)
          ],
        ),
      ),
    );
  }
}
