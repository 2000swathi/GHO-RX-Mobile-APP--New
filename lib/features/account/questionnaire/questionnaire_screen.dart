import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/questions_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class QuestionnaireScreen extends StatelessWidget {
  QuestionnaireScreen({super.key});

  final List<Map<String, dynamic>> questions = [
    {
      "id": "disciplinary",
      "text": "Have you ever had any disciplinary actions taken against you?",
    },
    {
      "id": "convicted",
      "text": "Have you ever been convicted of a felony or misdemeanor?",
    },
    {
      "id": "malpractice",
      "text": "Have you ever been involved in any malpractice claims?",
    },
  ];

  final Map<String, bool> answers = {
    "disciplinary": false,
    "convicted": false,
    "malpractice": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(title: "Questionnaire"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22, bottom: 30),
        child: CustomButton(text: "Submit Questionnaire", onPressed: () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primarycolor.withAlpha(13),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primarycolor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: AppColors.primarycolor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Please answer all questions honestly and completely",
                      style: AppFonts.textprogressbar.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...questions.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final q = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return QuestionCard(
                              questionText: q["text"],
                              questionId: q["id"],
                              index: index,
                              value: answers[q["id"]]!,
                              onChanged: (val) {
                                setState(() {
                                  answers[q["id"]] = val;
                                });
                              },
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
