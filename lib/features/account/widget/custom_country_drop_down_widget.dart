import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomCountryDropdown<T> extends StatelessWidget {
  final String name;
  final String hintText;
  final T? value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const CustomCountryDropdown({
    super.key,
    required this.name,
    required this.hintText,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.value,
    this.validator,
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
          isExpanded: true,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppFonts.hinttext,
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

          icon: const Icon(Icons.keyboard_arrow_down),

          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(labelBuilder(item)),
                );
              }).toList(),

          onChanged: onChanged,
        ),
      ],
    );
  }
}
