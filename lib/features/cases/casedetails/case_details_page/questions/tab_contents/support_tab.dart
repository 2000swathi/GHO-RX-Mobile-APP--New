import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/repository/bloc/q_and_a_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/repository/bloc/q_and_a_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_event.dart';

class SupportTab extends StatefulWidget {
  final String? previousAnswer;
  final String? supportText;
  final String saltID;
  final String questID;

  const SupportTab({
    super.key,
    this.previousAnswer,
    this.supportText,
    required this.saltID,
    required this.questID,
  });

  @override
  State<SupportTab> createState() => _SupportTabState();
}

class _SupportTabState extends State<SupportTab> {
  late TextEditingController supportController;

  @override
  void initState() {
    super.initState();
    supportController = TextEditingController(text: widget.supportText ?? '');
  }

  @override
  void dispose() {
    supportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QAndABloc, QAndAState>(
      listener: (context, state) {
        if (state is QAndASuccess) {
          CustomScaffoldMessenger.showSuccessMessage(
            context,
            state.response["Data"][0][0]["msg"],
          );
          context.read<CaseDetailsBloc>().add(
            CaseDetailsEventRequested(caseID: widget.saltID, silent: true,
            caseReviewerID: widget.saltID,),
          );

          FocusScope.of(context).unfocus();
          Navigator.of(context, rootNavigator: true).pop();
        } else if (state is QAndAFailure) {
          CustomScaffoldMessenger.showErrorMessage(context, state.message);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 350),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F5F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: supportController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText:
                          "Add supporting details or clarification (e.g., extra notes, guidance)…",
                      hintStyle: AppFonts.textprimary.copyWith(
                        color: AppColors.textPrimary.withAlpha(70),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              BlocBuilder<QAndABloc, QAndAState>(
                builder: (context, qandaState) {
                  final bool isqandALoading = qandaState is QAndALoading;

                  return CustomButton(
                    text: "Submit",
                    isLoading: isqandALoading,
                    onPressed: () {
                      context.read<QAndABloc>().add(
                        saveQandAEvent(
                          answer: widget.previousAnswer ?? '',
                          questID: widget.questID,
                          saltID: widget.saltID,
                          support: supportController.text.trim(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
