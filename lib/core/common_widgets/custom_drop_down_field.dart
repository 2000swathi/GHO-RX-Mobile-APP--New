import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomDropdownFormField<T> extends StatefulWidget {
  final String name;
  final String hintText;
  final List<DropdownItem<T>> items;
  final T? value;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final Color borderColor;

  const CustomDropdownFormField({
    super.key,
    required this.name,
    required this.hintText,
    required this.items,
    this.value,
    this.validator,
    this.onChanged,
    this.borderColor = AppColors.offgreycolor,
  });

  @override
  State<CustomDropdownFormField<T>> createState() => _CustomDropdownFormFieldState<T>();
}

class _CustomDropdownFormFieldState<T> extends State<CustomDropdownFormField<T>> {
  @override
  Widget build(BuildContext context) {
    Color borderColor = widget.borderColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.name, style: AppFonts.textSecondary),
        const SizedBox(height: 8),
        DropdownButtonFormField2<T>(
          isExpanded: true,
          value: widget.items.any((e) => e.value == widget.value) ? widget.value : null,
          validator: widget.validator,
          onChanged: widget.onChanged,
          hint: Text(widget.hintText, style: AppFonts.hinttext),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
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
              borderSide: BorderSide(color: AppColors.primarycolor),
            ),
          ),

          dropdownStyleData: DropdownStyleData(
            isOverButton: true,
            useSafeArea: true,
            maxHeight: 400,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            elevation: 4,
            offset: const Offset(0, 0),
          ),
          items:
              widget.items.map((item) {
                return DropdownMenuItem<T>(
                  value: item.value,
                  child: Text(
                    item.label,
                    style: AppFonts.textprimary,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

/// Helper model for dropdown items
class DropdownItem<T> {
  final T value;
  final String label;

  DropdownItem({required this.value, required this.label});
}
