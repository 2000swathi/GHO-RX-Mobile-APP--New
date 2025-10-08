import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class NewCasesTab extends StatelessWidget {
  const NewCasesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
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
      ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
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
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Accept Case",
                    onPressed: () {
                      Navigator.pushNamed(context, "/casedetails");
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomButton(
                    text: "Deny",
                    iswhite: true,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
