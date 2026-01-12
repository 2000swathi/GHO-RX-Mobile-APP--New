import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

class Summerypage extends StatelessWidget {
  final CaseInfo? medicalSummary;

  const Summerypage({super.key, required this.medicalSummary});

  @override
  Widget build(BuildContext context) {
    if (medicalSummary == null ||
        medicalSummary!.medicalSummary.trim().isEmpty) {
      return const SizedBox();
    }
    final isExpanded = ValueNotifier<bool>(false);
    final text = medicalSummary?.medicalSummary.trim() ?? "";

    return Container(
      width: double.infinity,
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
          Text(
            "Summary",
            style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final textSpan = TextSpan(
                text: text,
                style: AppFonts.textprimary,
              );
              final textPainter = TextPainter(
                text: textSpan,
                maxLines: 5,
                textDirection: TextDirection.ltr,
              );
              textPainter.layout(maxWidth: constraints.maxWidth);

              final exceedsFiveLines = textPainter.didExceedMaxLines;

              return ValueListenableBuilder<bool>(
                valueListenable: isExpanded,
                builder: (context, isExpandedValue, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: AppFonts.textprimary,
                        maxLines: isExpandedValue ? null : 5,
                        overflow:
                            isExpandedValue
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      if (exceedsFiveLines)
                        GestureDetector(
                          onTap: () => isExpanded.value = !isExpanded.value,
                          child: Text(
                            isExpandedValue ? "Read less" : "Read more...",
                            style: AppFonts.labelItalic.copyWith(
                              color: AppColors.secondarycolor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
