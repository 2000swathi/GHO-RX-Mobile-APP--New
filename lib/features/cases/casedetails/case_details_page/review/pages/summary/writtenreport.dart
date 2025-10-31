// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/summary/repository/bloc/summary_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/summary/repository/bloc/summary_event.dart';

class Writtenreport extends StatefulWidget {
  final VoidCallback? onNext;
  final String saltID;
  String summaryRecords;

  Writtenreport({
    super.key,
    this.onNext,
    required this.saltID,
    required this.summaryRecords,
  });

  @override
  State<Writtenreport> createState() => _WrittenreportState();
}

class _WrittenreportState extends State<Writtenreport> {
  final TextEditingController summaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.summaryRecords.isNotEmpty) {
      summaryController.text = widget.summaryRecords;
    }
    return BlocListener<SummaryBloc, SummaryState>(
      listener: (context, state) {
        if (state is SummarySuccess) {
          CustomScaffoldMessenger.showSuccessMessage(
            context,
            state.response["Data"][0][0]["msg"],
          );
        } else if (state is SummaryFailure) {
          CustomScaffoldMessenger.showErrorMessage(context, state.message);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.hint2color),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: summaryController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText:
                      'Start typing your structured report here (e.g., Summary of Findings, Recommendations, Next Steps...)',
                  hintStyle: AppFonts.hinttext2,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<SummaryBloc, SummaryState>(
                  builder: (context, state) {
                    final bool isLoading = state is SummaryLoading;
                    return SizedBox(
                      width: 100,
                      child: CustomButton(
                        text: "Save",
                        isLoading: isLoading,
                        onPressed: () {
                          context.read<SummaryBloc>().add(
                            summarycaseEvent(
                              saltID: widget.saltID,
                              summary: summaryController.text.trim(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: 100,
                  child: CustomButton(text: "Next", onPressed: widget.onNext!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
