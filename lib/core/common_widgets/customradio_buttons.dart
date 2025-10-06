import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomRadioField<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T? selectedValue;
  final ValueChanged<T> onChanged;
  final String Function(T)? labelBuilder;

  const CustomRadioField({
    Key? key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.labelBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.textSecondary,
        ),
        const SizedBox(height: 8),
        Row(
          children: options.map((option) {
            final optionLabel = labelBuilder != null
                ? labelBuilder!(option)
                : option.toString();
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  value: option,
                  groupValue: selectedValue,
                  activeColor: AppColors.primarycolor,
                  onChanged: (val) => onChanged(option),
                ),
                Text(
                  optionLabel,
                  style: AppFonts.textSecondary,
                ),
                const SizedBox(width: 20),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
