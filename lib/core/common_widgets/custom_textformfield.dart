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
  final VoidCallback? onTap;
  final bool readOnly;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;

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
    this.onTap,
    this.readOnly = false,
    this.textCapitalization,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.offgreycolor;

    final capitalization =
        textCapitalization ??
        (keyboardType == TextInputType.emailAddress ||
                keyboardType == TextInputType.phone ||
                keyboardType == TextInputType.number
            ? TextCapitalization.none
            : TextCapitalization.words);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppFonts.textSecondary),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction ?? TextInputAction.done,
          onChanged: (value) {
            String finalValue = value;
            if (keyboardType == TextInputType.emailAddress) {
              final lower = value.toLowerCase();
              if (value != lower) {
                controller?.value = controller!.value.copyWith(
                  text: lower,
                  selection: TextSelection.collapsed(offset: lower.length),
                );
              }
              finalValue = lower;
            }
            onChanged?.call(finalValue);
          },
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

          textCapitalization: capitalization,
        ),
      ],
    );
  }
}
