import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class AnswerTab extends StatelessWidget {
  const AnswerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F8),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
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
