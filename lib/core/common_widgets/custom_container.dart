import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomContainer extends StatelessWidget {
  final String greyHeading;

  final String? datas;
  final Widget? customWidgets;
  final List<Widget>? customWidgets1;
  final List<Widget>? commonCheckbox;
  final String? declarationText;

  const CustomContainer({
    super.key,
    required this.greyHeading,

    this.datas,
    this.customWidgets,
    this.customWidgets1,
    this.commonCheckbox,
    this.declarationText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greyHeading,
              style: AppFonts.hinttext2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (customWidgets1 != null) ...customWidgets1!,
            if (datas != null && datas!.isNotEmpty)
              Text(datas!, style: AppFonts.buttontxt.copyWith(color: AppColors.textPrimary)),
            if (commonCheckbox != null) ...commonCheckbox!,
          ],
        ),
      ),
    );
  }
}
