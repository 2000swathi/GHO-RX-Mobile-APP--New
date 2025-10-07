import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

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
            name: 'Chronic Pain Diagnostic',
            payout: "80",
            dueDate: 'Oct 9, 2024',
            description:
                'The specialist report is complete and awaiting your final approval and submission.',
            timeleft: "4 hours left",
          ),
          SizedBox(height: 16),
          CaseCard(
            caseId: 'GHO-2024-9532',
            name: 'Chronic Pain Diagnostic',
            payout: "80",
            dueDate: 'Oct 12, 2024',
            description:
                '45-year-old male with history of diabetes presenting with sudden vision loss in the right eye. Requesting urgent ophthalmologist opinion.',
            timeleft: "3 hours left",
          ),
        ],
      ),
    );
  }
}

class CaseCard extends StatelessWidget {
  final String caseId;
  final String name;
  final String payout;
  final String dueDate;
  final String description;
  final String timeleft;

  const CaseCard({
    super.key,
    required this.caseId,
    required this.name,
    required this.payout,
    required this.dueDate,
    required this.description,
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
                        Text(
                        "$caseId : $name",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Anticipated Payout",
                    style: AppFonts.subtext,
                    ),
                    Spacer(),
                    Icon(Icons.circle, color: AppColors.red, size: 8),
                    const SizedBox(width: 4),
                    Text("$timeleft",
                    style: AppFonts.labelItalic,
                    ),
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