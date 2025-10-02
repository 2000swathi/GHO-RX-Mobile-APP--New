import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const CustomPhoneField({
    Key? key,
    required this.controller,
    this.label = "Primary Mobile Number",
  }) : super(key: key);

  @override
  _CustomPhoneFieldState createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  String selectedCountryCode = '91';
  final List<String> countryCodes = ['91', '1', '44', '61']; // Add more codes as needed

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.offgreycolor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              DropdownButton<String>(
                value: selectedCountryCode,
                underline: const SizedBox(),
                items: countryCodes.map((code) {
                  return DropdownMenuItem(
                    value: code,
                    child: Text("+$code"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCountryCode = value!;
                  });
                },
              ),
              const SizedBox(width: 5),
              Container(width: 1, height: 20, color: AppColors.offgreycolor),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "XXXXX XXXXX",
                    hintStyle: AppFonts.hinttext,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
