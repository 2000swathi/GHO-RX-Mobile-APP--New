import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class SettingRow extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String svgPath;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? pushBtn;
  ///////////////
  final List<bool>? isSelected;
  final List<Widget>? toggleChildren;
  final Function(int)? onTogglePressed;
  final ValueNotifier<List<bool>>? valueNotifier;

  const SettingRow({
    super.key,
    required this.title,
    this.subTitle,
    required this.svgPath,
    this.trailing,
    this.onTap,
    this.pushBtn,
    ///////////////
    this.isSelected,
    this.toggleChildren,
    this.onTogglePressed,
    this.valueNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(svgPath, height: 22, width: 22),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.subheading16.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subTitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subTitle!,
                      style: AppFonts.subtext.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected != null &&
                toggleChildren != null &&
                onTogglePressed != null)
              ValueListenableBuilder<List<bool>>(
                valueListenable: valueNotifier!,
                builder: (context, value, _) {
                  return ToggleButtons(
                    borderRadius: BorderRadius.circular(30),
                    isSelected: value,
                    onPressed: onTogglePressed,
                    selectedColor: Colors.white,
                    fillColor: AppColors.primarycolor,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 30,
                    ),
                    children: toggleChildren!,
                  );
                },
              )
            else
              pushBtn ??
                  trailing ??
                  const Icon(Icons.chevron_right, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
