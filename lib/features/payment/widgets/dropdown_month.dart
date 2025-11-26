import 'package:flutter/material.dart';

class MonthlyDropdown extends StatefulWidget {
  const MonthlyDropdown({super.key});

  @override
  State<MonthlyDropdown> createState() => _MonthlyDropdownState();
}

class _MonthlyDropdownState extends State<MonthlyDropdown> {
  final List<String> months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 121,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select Month',
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true, // 👈 makes field smaller
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8, // 👈 reduces height
            ),
          ),
          iconSize: 20, // 👈 smaller dropdown arrow
          value: selectedMonth,
          items:
              months.map((month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month, style: const TextStyle(fontSize: 13)),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              selectedMonth = value;
            });
          },
          validator: (value) => value == null ? 'Please select a month' : null,
        ),
      ),
    );
  }
}
