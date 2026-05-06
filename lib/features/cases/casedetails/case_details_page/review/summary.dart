import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

class Summerypage extends StatelessWidget {
  final CaseInfo? medicalSummary;

  const Summerypage({super.key, required this.medicalSummary});

 @override
Widget build(BuildContext context) {
  if (medicalSummary == null) {
    return const SizedBox();
  }

    final summaryText = medicalSummary?.medicalSummary.trim() ?? "";
    final reason =
        '''
The patient is seeking a second opinion due to persistent symptoms that have not improved despite ongoing treatment. 
There is uncertainty regarding the current treatment plan and a need to confirm the diagnosis and explore alternative therapies. 
The patient also wishes to understand the long-term prognosis and possible complications associated with the condition.
''' *
        2;

    final diagnosis =
        '''
The patient is currently diagnosed with a chronic inflammatory condition affecting multiple systems. 
Symptoms include fatigue, pain, and intermittent fever. Previous investigations suggest an autoimmune origin, 
but further evaluation is required to confirm the diagnosis and rule out other underlying causes.
''' *
        2;

    final allergies =
        '''
The patient reports allergic reactions to certain medications including antibiotics and pain relievers. 
There is also a history of seasonal allergies triggered by pollen and dust. 
Food allergies include sensitivity to nuts and dairy products, which cause mild to moderate reactions.
''' *
        2;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
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
          if (summaryText.isNotEmpty) ...[
            _ExpandableSection(title: "Summary", text: summaryText),
            const SizedBox(height: 15),
          ],
          if (reason.isNotEmpty) ...[
            _ExpandableSection(title: "Reason for Seeking SOP", text: reason),
            const SizedBox(height: 15),
          ],
          if (diagnosis.isNotEmpty) ...[
            _ExpandableSection(title: "Current Diagnosis", text: diagnosis),
            const SizedBox(height: 15),
          ],
          if (allergies.isNotEmpty) ...[
            _ExpandableSection(title: "Allergies", text: allergies),
          ],
        ],
      ),
    );
  }
}

/// 🔥 Reusable Expandable Section
class _ExpandableSection extends StatefulWidget {
  final String title;
  final String text;

  const _ExpandableSection({required this.title, required this.text});

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: AppFonts.textprimary,
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 3,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);
        final exceeds = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Title
            Text(
              widget.title,
              style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            /// 🔹 Content
            Text(
              widget.text,
              style: AppFonts.textprimary,
              maxLines: isExpanded ? null : 3,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),

            /// 🔹 Read More / Less
            if (exceeds)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "Read less" : "Read more...",
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
  }
}
