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
  final String data2;
  final String data3;
  final Icon? icon;
  final Image? image;
  const CommonContainer({
    super.key,
    required this.color,
    required this.borderColor,
    required this.data2Color,
    required this.data,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.textColor,
    this.icon,
    this.image,
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
          RichText(
            text: TextSpan(
              children: [
                if (icon != null) ...[
                  WidgetSpan(
                    child: SizedBox(width: 16, height: 16, child: icon),
                  ),
                ],
                WidgetSpan(child: SizedBox(width: 2)),
                if (image != null) ...[
                  WidgetSpan(
                    child: SizedBox(width: 16, height: 16, child: image),
                  ),
                  WidgetSpan(child: SizedBox(width: 4)),
                ],
                TextSpan(
                  text: data2,
                  style: AppFonts.subtext.copyWith(
                    color: data2Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                WidgetSpan(child: SizedBox(width: 6)),
                TextSpan(text: data3, style: AppFonts.subtext),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
