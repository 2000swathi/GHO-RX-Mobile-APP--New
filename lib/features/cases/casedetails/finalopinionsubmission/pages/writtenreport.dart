import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Writtenreport extends StatelessWidget {
  const Writtenreport({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        maxLines: null, 
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText:
              'Start typing your structured report here (e.g., Summary of Findings, Recommendations, Next Steps...)',
          hintStyle: AppFonts.hinttext2,
          border: InputBorder.none,
        ),
      ),
    );
  }
}