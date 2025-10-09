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
          ),
          SizedBox(height: 16),
          CaseCard(
            caseId: 'GHO-2024-9532',
            name: 'Chronic Pain Diagnostic',
            payout: "80",
            dueDate: 'Oct 12, 2024',
            description:
                'The specialist report is complete and awaiting your final approval and submission.',
            status: "FINAL REVIEW",
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
  final String? status;


  const CaseCard({
    super.key,
    required this.caseId,
    required this.name,
    required this.payout,
    required this.dueDate,
    required this.description,
    this.status,
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
                        if(status != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.successcolor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            status!,
                            style: AppFonts.subtext.copyWith(
                              color: AppColors.successcolor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                        "$caseId : $name",
                          style: AppFonts.semiratechart,
                          textAlign: TextAlign.left,
                        
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: AppFonts.textprimary.copyWith(
                    height: 1.5,
                  )
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Anticipated Payout",
                        style: AppFonts.subtext.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          ),                   
                        ),
                        Text("\$$payout",
                        style: AppFonts.semiratechart.copyWith(
                          color: AppColors.successcolor,
                        ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Due Date",
                        style: AppFonts.subtext.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          ),
                        ),
                        Text(dueDate,
                        style: AppFonts.textred.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                      ],
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