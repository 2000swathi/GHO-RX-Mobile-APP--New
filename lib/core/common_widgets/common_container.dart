import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class CommonContainer extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Color data2Color;
  final Color borderColor;
  final String data;
  final String data1;

  const CommonContainer({
    super.key,
    required this.color,
    required this.borderColor,
    required this.data2Color,
    required this.data,
    required this.data1,

    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            data,
            style: AppFonts.subtext.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto Flex',
            ),
          ),
          Text(data1, style: AppFonts.numBold),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
