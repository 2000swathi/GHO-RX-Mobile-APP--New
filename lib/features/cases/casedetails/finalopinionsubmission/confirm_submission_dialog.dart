import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class ConfirmSubmissionDialog extends StatelessWidget {
  const ConfirmSubmissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 19.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Padding(
                padding: const EdgeInsets.only(right: 22),
                child: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 23.h),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Confirm Submission", style: AppFonts.heading),
                Text(
                  "Are you sure you want to submit this review?",
                  style: AppFonts.textprimary,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  "The GHO team will format it and return it to you for final signature.",
                  style: AppFonts.buttontxt.copyWith(color: AppColors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 37.36.h),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel/Back to Edit",
                    onPressed: () {},
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
