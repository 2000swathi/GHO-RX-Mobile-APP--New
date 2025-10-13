import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class ConfirmSubmissionDialog extends StatelessWidget {
  const ConfirmSubmissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Padding(
                padding: const EdgeInsets.only(right: 22),
                child: SvgPicture.asset("assets/svg/close_svg_button.svg"),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Confirm Submission", style: AppFonts.heading),
                SizedBox(height: 10),
                Text(
                  "Are you sure you want to submit this review?",
                  style: AppFonts.textprimary,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  "The GHO team will format it and return it to you for final signature.",
                  style: AppFonts.buttontxt.copyWith(color: AppColors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel / Edit",
                    onPressed: () {},
                    colortext: AppColors.primarycolor,
                    color: AppColors.primarycolor.withAlpha(15),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: CustomButton(text: "Yes, Submit", onPressed: () {}),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
