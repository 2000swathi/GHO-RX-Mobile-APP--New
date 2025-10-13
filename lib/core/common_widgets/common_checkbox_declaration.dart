import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CommonCheckboxDeclaration extends StatefulWidget {
  final String declarationText;
  final bool initialValue;
  final ValueChanged<bool?>? onChanged;

  const CommonCheckboxDeclaration({
    super.key,
    required this.declarationText,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<CommonCheckboxDeclaration> createState() =>
      _CommonCheckboxDeclarationState();
}

class _CommonCheckboxDeclarationState extends State<CommonCheckboxDeclaration> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isChecked = !isChecked);
        widget.onChanged?.call(isChecked);
      },

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() => isChecked = value ?? false);
              widget.onChanged?.call(value);
            },
            activeColor: AppColors.primarycolor,
            side: BorderSide(color: AppColors.textSecondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Text(
              widget.declarationText,
              style: AppFonts.buttontxt.copyWith(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
