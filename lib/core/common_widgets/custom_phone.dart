import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? countryCode; 
  final String? Function(String?)? validator;


  const CustomPhoneField({
    super.key,
    required this.controller,
    this.label = "",
    this.countryCode,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          validator: validator,
          decoration: InputDecoration(
            prefixText: countryCode != null && countryCode!.isNotEmpty
                ? "+$countryCode "
                : null,
            prefixStyle: AppFonts.textprimary.copyWith(color:AppColors.black),
            hintText: "XXXXX XXXXX",
            hintStyle: AppFonts.hinttext,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.offgreycolor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.offgreycolor),
            ),
          ),
        ),
      ],
    );
  }
}
