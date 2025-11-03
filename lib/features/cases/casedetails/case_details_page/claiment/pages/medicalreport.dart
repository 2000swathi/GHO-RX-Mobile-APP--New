import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/widget/report_list_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

class Medicalreport extends StatelessWidget {
  final List<AudioSummaryModel>? medicalsummery;

  const Medicalreport({super.key, required this.medicalsummery});

  @override
  Widget build(BuildContext context) {
    final isExpanded = ValueNotifier<bool>(false);

    // Filter only non-audio items (documents)
    final allItems = medicalsummery ?? [];
    final reports = allItems.where((item) => item.docTypeID != 6).toList();

    if (reports.isEmpty) {
      return SizedBox();
    }

    return Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.hint2color.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          // Header
          Row(
            children: [
              Text(
                "Medical Documents",
                style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 7),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightgreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${reports.length} Files',
                  style: AppFonts.textprimarygreen12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // List of reports with expand/collapse
          if (reports.length <= 3)
            ReportListWidget(fileList: reports, itemCount: reports.length)
          else
            ValueListenableBuilder<bool>(
              valueListenable: isExpanded,
              builder: (context, isExpandedValue, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportListWidget(
                      fileList: reports,
                      itemCount: isExpandedValue ? reports.length : 3,
                    ),
                    GestureDetector(
                      onTap: () => isExpanded.value = !isExpanded.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          isExpandedValue ? "Read less" : "Read more...",
                          style: AppFonts.hinttext2.copyWith(
                            color: AppColors.primarycolor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
