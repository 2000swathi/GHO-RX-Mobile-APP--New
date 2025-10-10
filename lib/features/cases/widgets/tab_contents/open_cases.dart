import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class OpenCasesTab extends StatelessWidget {
  const OpenCasesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: const [
        CaseCard(
          caseId: 'GHO-2024-9481',
          allottedTime: '5 hrs',
          dueDate: 'Oct 9, 2024',
          description:
              '34-year-old female presenting with acute chest pain, radiating to left arm. Requesting urgent cardiologist opinion.',
        ),
        SizedBox(height: 16),
        CaseCard(
          caseId: 'GHO-2024-9532',
          allottedTime: '8 hrs',
          dueDate: 'Oct 12, 2024',
          description:
              '45-year-old male with history of diabetes presenting with sudden vision loss in the right eye. Requesting urgent ophthalmologist opinion.',
        ),
      ],
    );
  }
}

class CaseCard extends StatelessWidget {
  final String caseId;
  final String allottedTime;
  final String dueDate;
  final String description;

  const CaseCard({
    super.key,
    required this.caseId,
    required this.allottedTime,
    required this.dueDate,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.hint2color),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Case Identifier', style: AppFonts.subtext),
                        const SizedBox(height: 4),
                        Text(
                          caseId,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Allotted Time:",
                            style: AppFonts.subtext,
                            children: [
                              TextSpan(
                                text: ' $allottedTime',
                                style: AppFonts.subtext.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            text: "Due Date:",
                            style: AppFonts.subtext,
                            children: [
                              TextSpan(
                                text: ' $dueDate',
                                style: AppFonts.subtext.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: AppColors.primarycolor.withAlpha(15),
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Text(description, style: AppFonts.textappbar),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
