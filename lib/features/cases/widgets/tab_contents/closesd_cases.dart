import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class ClosedCasesTab extends StatelessWidget {
  const ClosedCasesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.hint2color),
        borderRadius: BorderRadius.circular(10),
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
          if (status != null)
            Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successcolor.withAlpha(10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status!,
                style: AppFonts.subtext.copyWith(color: AppColors.successcolor),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$caseId : $name",
                style: AppFonts.semiratechart,
                textAlign: TextAlign.left,
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(description, style: AppFonts.subtext),
          SizedBox(height: 15),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Anticipated Payout",
                    style: AppFonts.subtext.copyWith(
                      color: AppColors.hint1color,
                    ),
                  ),
                  Text(
                    "\$$payout",
                    style: AppFonts.semiratechart.copyWith(
                      color: AppColors.successcolor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due Date",
                    style: AppFonts.subtext.copyWith(
                      color: AppColors.hint1color,
                    ),
                  ),
                  Text(
                    dueDate,
                    style: AppFonts.subtext.copyWith(
                      fontSize: 16,
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
