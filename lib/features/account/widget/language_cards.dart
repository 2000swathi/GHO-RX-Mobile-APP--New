import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class LanguageChipsUi extends StatelessWidget {
  final List<String> languages;

  const LanguageChipsUi({
    super.key,
    required this.languages,
    });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: languages.map((lang) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cards1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          lang,
          style: AppFonts.textprimary,
        )
      );
      }
    ).toList(),
    );
  }
}