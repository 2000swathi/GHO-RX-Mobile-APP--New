import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class AnswerTab extends StatelessWidget {
  final void Function(String answer)? onNext;
  final String? answer;
  final TextEditingController answerController;

  AnswerTab({
    super.key,
    this.onNext,
    this.answer,
  }) : answerController = TextEditingController(text: answer ?? '');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(
                minHeight: 400,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF3F5F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: answerController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    text: "Next",
                    onPressed: () {
                      if (onNext != null) {
                        onNext!(answerController.text.trim());
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
