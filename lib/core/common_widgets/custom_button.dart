import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool iswhite;
  final Color? color;
  final Color? colortext;
  final bool? isiIon;
  final Widget? widget;
  final Color? borderColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
     this.onPressed,
    this.iswhite = false,
    this.color = AppColors.primarycolor,
    this.colortext = AppColors.white,
    this.isiIon = false,
    this.widget,
    this.borderColor = Colors.transparent,
    this.isLoading = false,
  });
                                                          
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor!),
          color: iswhite ? AppColors.white : color,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child:
              isLoading
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ) // 👈 show loading spinner
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isiIon == true) (widget ?? const SizedBox.shrink()),
                      if (isiIon == true) const SizedBox(width: 7),
                      Text(
                        text,
                        style:
                            iswhite
                                ? AppFonts.textblue
                                : AppFonts.textwhite.copyWith(color: colortext),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
