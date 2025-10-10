import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/doc_container.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class CustomContainer extends StatelessWidget {
  final String greyHeading;
  final String? subHeading;
  final Widget icon;
  final String? datas;
  final String? hintText;
  final Widget? customWidgets;
  final List<Widget>? customWidgets1;
  const CustomContainer({
    super.key,
    required this.greyHeading,
    this.subHeading,
    required this.icon,
    this.hintText,
    this.datas,
    this.customWidgets,
    this.customWidgets1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(height: 20.h),
                Text(
                  greyHeading,
                  style: AppFonts.hinttext2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10),
                Container(child: customWidgets),
                Spacer(),

                icon,
              ],
            ),

            Column(children: customWidgets1 ?? []),

            // SizedBox(height: 8.h),
            Text(
              subHeading ?? '',
              style: AppFonts.textprimary.copyWith(fontWeight: FontWeight.w500),
            ),

            Text(datas ?? '', style: AppFonts.textprimary),

            Text(
              hintText ?? '',
              style: AppFonts.textappbar.copyWith(
                color: AppColors.textPrimary.withAlpha(50),
              ),
            ),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
