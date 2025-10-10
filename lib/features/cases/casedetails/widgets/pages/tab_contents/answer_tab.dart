import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class AnswerTab extends StatelessWidget {
  const AnswerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText:
                      "Type your answer here (e.g., explanation, advice, next steps)…",
                  hintStyle: AppFonts.textprimary.copyWith(
                    color: AppColors.textPrimary.withAlpha(70),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
