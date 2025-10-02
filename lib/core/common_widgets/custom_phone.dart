import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String selectedCountryCode;
  final List<String> countryCodes;
  final ValueChanged<String?> onChanged;
  final ValueChanged<String>? onPhoneChanged;

  const CustomPhoneField({
    super.key,
    required this.controller,
    required this.label,
    required this.selectedCountryCode,
    required this.countryCodes,
    required this.onChanged,
    this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.textSecondary),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.offgreycolor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              DropdownButton<String>(
                value: selectedCountryCode,
                underline: const SizedBox(),
                items: countryCodes.map((code) {
                  return DropdownMenuItem(
                    value: code,
                    child: Text("+$code"),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
              const SizedBox(width: 5),
              Container(width: 1, height: 20, color: AppColors.offgreycolor),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  onChanged: onPhoneChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "XXXXX XXXXX",
                    hintStyle: AppFonts.hinttext,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
