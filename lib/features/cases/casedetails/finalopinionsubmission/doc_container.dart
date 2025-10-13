import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class DocContainer extends StatelessWidget {
  final Widget iconDoc;
  final String fileName;

  const DocContainer({
    super.key,
    required this.fileName,
    required this.iconDoc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.primarycolor.withAlpha(30),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.h),

          iconDoc,
          SizedBox(width: 6.5.w),
          Text(
            fileName,
            style: AppFonts.textprimary.copyWith(fontWeight: FontWeight.w600),
          ),
          // SizedBox(height: 20),
        ],
      ),
    );
  }
}
