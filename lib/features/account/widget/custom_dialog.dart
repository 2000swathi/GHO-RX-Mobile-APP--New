import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class customDialog extends StatelessWidget {
  final String svgPath;
  final String heading;
  final String warningText;
  final Color colors;
  final Color imgColor;
  final String btnTxt1;
  final String btnTxt2;
  final Color? btnTextClr;
  final Color? btnbg1;
  final Color? btnbg2;
  // final VoidCallback? btn1pressed;
  final VoidCallback? btn2pressed;

  const customDialog({
    super.key,
    required this.svgPath,
    required this.heading,
    required this.warningText,
    required this.colors,
    required this.imgColor,
    required this.btnTxt1,
    required this.btnTxt2,
    this.btnTextClr,
    this.btnbg1,
    this.btnbg2,
    // this.btn1pressed,
    this.btn2pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 17, right: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: SvgPicture.asset("assets/svg/close_svg_button.svg"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  SizedBox(height: 55),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: colors,
                    child: Center(
                      child: SvgPicture.asset(
                        svgPath,
                        fit: BoxFit.contain,
                        width: 50,
                        height: 50,
                        colorFilter: ColorFilter.mode(
                          imgColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 21),
                  Text(heading, style: AppFonts.heading),
                  SizedBox(height: 12),
                  Text(
                    warningText,
                    style: AppFonts.textprimary,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 22,
              right: 22,
              bottom: 36,
              top: 35,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: btnTxt1,
                    colortext: btnTextClr,
                    color: btnbg1,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: btnTxt2,
                    color: btnbg2,
                    onPressed: btn2pressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
