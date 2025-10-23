import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String name;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    required this.name,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.offgreycolor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppFonts.textSecondary),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppFonts.hinttext,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
        ),
      ],
    );
  }
}
