import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final String name;
  final String hintText;
  final List<T> items;
  final T? value;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.name,
    required this.hintText,
    required this.items,
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.offgreycolor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppFonts.textSecondary),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          validator: validator,
          onChanged: onChanged,
          hint: Text(hintText, style: AppFonts.hinttext),
          decoration: InputDecoration(
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
          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.toString(), style: AppFonts.textprimary),
                );
              }).toList(),
        ),
      ],
    );
  }
}
