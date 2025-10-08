import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  bool iswhite;
  Color? color;
  bool? isiIon;
  Widget? widget;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.iswhite = false,
    this.color = AppColors.primarycolor,
    this.isiIon = false,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          color: iswhite == true ? AppColors.white : color,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isiIon == true
                  ? (widget ?? SizedBox.shrink())
                  : SizedBox.shrink(),
              isiIon == true ? SizedBox(width: 7) : SizedBox.shrink(),
              Text(
                text,
                style:
                    iswhite == true
                        ? AppFonts.textblue
                        : AppFonts.textwhite.copyWith(
                          color:
                              isiIon == true
                                  ? AppColors.primarycolor
                                  : AppColors.white,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
