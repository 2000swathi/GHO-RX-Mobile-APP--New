import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomDOBField extends StatefulWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final String? Function(String?)? validator;

  const CustomDOBField({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.selectedDate,
    this.validator,
  });

  @override
  State<CustomDOBField> createState() => _CustomDOBFieldState();
}

class _CustomDOBFieldState extends State<CustomDOBField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text:
          widget.selectedDate != null
              ? DateFormat('dd / MM / yyyy').format(widget.selectedDate!)
              : '',
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _controller.text = DateFormat('dd / MM / yyyy').format(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.offgreycolor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppFonts.textSecondary),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.hint1color,
                    size: 20,
                  ),
                ),
                VerticalDivider(
                  width: 20,
                  thickness: 1.5,
                  color: AppColors.offgreycolor,
                  indent: 14,
                  endIndent: 14,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    readOnly: true,
                    style: AppFonts.textSecondary,
                    decoration: InputDecoration(
                      hintText: "DD / MM / YYYY",
                      hintStyle: AppFonts.hinttext,
                      border: InputBorder.none,
                    ),
                    validator: widget.validator,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
