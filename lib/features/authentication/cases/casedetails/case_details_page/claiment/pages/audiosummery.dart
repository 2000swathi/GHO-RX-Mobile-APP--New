import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/case_details_page/claiment/widget/audio_summary_list_widget.dart';

import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

class Audiosummery extends StatefulWidget {
  final List<AudioSummaryModel>? audiosummery;

  const Audiosummery({super.key, required this.audiosummery});

  @override
  State<Audiosummery> createState() => _AudiosummeryState();
}

class _AudiosummeryState extends State<Audiosummery> {
  @override
  Widget build(BuildContext context) {
    final allItems = widget.audiosummery ?? [];
    final audioList = allItems.where((item) => item.docTypeID == 6).toList();
    if (audioList.isEmpty) {
      return SizedBox();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.hint2color.withAlpha(1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Audio Summary",
            style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          AudioSummaryListWidget(audioList: audioList),
        ],
      ),
    );
  }
}
