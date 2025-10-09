import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class InProgressTab extends StatelessWidget {
  const InProgressTab({super.key});

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
                '60-year-old male with slurred speech and weakness in right arm for 2 hours. Requesting urgent neurologist opinion.',
            lastedited: "5 min ago",
            timeleft: "4 hours left",
          ),
          SizedBox(height: 16),
          CaseCard(
            caseId: 'GHO-2024-9532',
            allottedTime: '8 hrs',
            dueDate: 'Oct 12, 2024',
            description:
                '45-year-old male with history of diabetes presenting with sudden vision loss in the right eye. Requesting urgent ophthalmologist opinion.',
            lastedited: "3 min ago",
            timeleft: "3 hours left",
          ),
          SizedBox(height: 16),
          CaseCard(
            caseId: 'GHO-2024-9565',
            allottedTime: '8 hrs',
            dueDate: 'Oct 12, 2024',
            description:
                '52-year-old female with severe knee pain and restricted movement. History of osteoarthritis. Requesting orthopedic surgeon opinion.',
            lastedited: "3 min ago",
            timeleft: "3 hours left",
          ),
          SizedBox(height: 16),
          CaseCard(
            caseId: 'GHO-2024-9542',
            allottedTime: '8 hrs',
            dueDate: 'Oct 12, 2024',
            description:
                '7-year-old child presenting with high fever, rash, and joint pain. Requesting pediatric infectious disease specialist opinion.',
            lastedited: "3 min ago",
            timeleft: "4 hours left",
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
  final String lastedited;
  final String timeleft;

  const CaseCard({
    super.key,
    required this.caseId,
    required this.allottedTime,
    required this.dueDate,
    required this.description,
    required this.lastedited,
    required this.timeleft,
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
                        Text(caseId, style: AppFonts.subheading),
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
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Last Edited: $lastedited",
                      style: AppFonts.labelItalic,
                    ),
                    Spacer(),
                    Icon(Icons.circle, color: AppColors.red, size: 8),
                    const SizedBox(width: 4),
                    Text("$timeleft", style: AppFonts.labelItalic),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
