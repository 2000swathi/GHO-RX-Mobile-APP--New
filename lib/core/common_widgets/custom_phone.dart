import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomDropdownField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPhoneField;
  final String dropdownPosition; 
  final String? Function(String?)? validator;
  final List<String>? items; 
  final List<Map<String, dynamic>>? countryItems; 
  final bool isCountryDropdown; 

  const CustomDropdownField({
    super.key,
    required this.controller,
    this.label = "",
    this.isPhoneField = false,
    this.dropdownPosition = "left",
    this.items,
    this.validator,
    this.countryItems,
    this.isCountryDropdown = false,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String selectedCountryCode = '91';
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.isCountryDropdown && widget.countryItems != null && widget.countryItems!.isNotEmpty) {
      selectedCountryCode = widget.countryItems![0]['CountryCode'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftDropdown = DropdownButton<String>(
      value: selectedCountryCode,
      underline: const SizedBox(),
      items: widget.isCountryDropdown && widget.countryItems != null
          ? widget.countryItems!.map((c) {
              return DropdownMenuItem(
                value: c['CountryCode'].toString(),
                child: Text("+${c['CountryCode']}", style: AppFonts.textSecondary),
              );
            }).toList()
          : <String>['91', '1', '44', '61'].map((code) {
              return DropdownMenuItem(
                value: code,
                child: Text("+$code", style: AppFonts.textSecondary),
              );
            }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCountryCode = value!;
        });
      },
    );

    final rightDropdown = (widget.items != null || widget.isCountryDropdown)
        ? DropdownButton<String>(
            value: selectedItem,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            items: widget.isCountryDropdown && widget.countryItems != null
                ? widget.countryItems!.map((c) {
                    return DropdownMenuItem(
                      value: c['CountryID'].toString(),
                      child: Text(c['CountryName'], style: AppFonts.textSecondary),
                    );
                  }).toList()
                : widget.items!.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item, style: AppFonts.textSecondary),
                    );
                  }).toList(),
            onChanged: (value) {
              setState(() {
                selectedItem = value;
              });
            },
          )
        : const Icon(Icons.arrow_drop_down);

    final divider = Container(
      width: 1,
      height: 20,
      color: AppColors.offgreycolor,
    );

    final textField = Expanded(
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.isPhoneField ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.dropdownPosition == "right"
              ? "Enter ${widget.label.toLowerCase()}"
              : widget.isPhoneField
                  ? "XXXXX XXXXX"
                  : "Enter ${widget.label.toLowerCase()}",
          hintStyle: AppFonts.hinttext,
        ),
      ),
    );

    final rowChildren = widget.dropdownPosition == "left"
        ? [
            leftDropdown,
            const SizedBox(width: 10),
            divider,
            const SizedBox(width: 10),
            textField,
          ]
        : [
            textField,
            const SizedBox(width: 10),
            divider,
            const SizedBox(width: 10),
            rightDropdown,
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text(
            widget.label,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.offgreycolor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: rowChildren,
          ),
        ),
      ],
    );
  }
}
