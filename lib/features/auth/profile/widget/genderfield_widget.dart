import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class GenderRadioButton extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderRadioButton({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: AppFonts.textSecondary),
        const SizedBox(height: 8),
        Column(
          children:
              ["Male", "Female", "Other"].map((gender) {
                return RadioListTile<String>(
                  value: gender,
                  groupValue: selectedGender,
                  onChanged: onChanged,
                  title: Text(gender, style: AppFonts.textprimary),
                  activeColor: AppColors.primarycolor,
                  contentPadding: EdgeInsets.zero,
                );
              }).toList(),
        ),
      ],
    );
  }
}
