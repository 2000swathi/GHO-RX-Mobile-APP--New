import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/attestation/widget/checkbox_declaration.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart'; 
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/widget/audio_summary_list_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/widget/report_list_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/attestation/bloc/attest_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/attestation/bloc/attest_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/confirm_submission_dialog.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/repository/bloc/final_submission_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/repository/bloc/final_submission_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/widget/common_qa.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class FinalOpinionConfirmation extends StatefulWidget {
  final CaseDetailsModel caseDetailsModel;
  final String saltID;
  const FinalOpinionConfirmation({
    super.key,
    required this.caseDetailsModel,
    required this.saltID,
  });

  @override
  State<FinalOpinionConfirmation> createState() =>
      _FinalOpinionConfirmationState();
}

class _FinalOpinionConfirmationState extends State<FinalOpinionConfirmation> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CaseDetailsBloc>().add(
      CaseDetailsEventRequested(saltID: widget.saltID, silent: true),
    );
    context.read<AttestBloc>().add(
      AttestListEvent(saltID: widget.saltID, silent: true),
    );
  }

  List<bool> _attestationChecks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SvgPicture.asset("assets/svg/Vector.svg"),
            ),
          ),
        ),
        title: Text(
          "Case ID : ${widget.caseDetailsModel.caseInfo!.id.toString()} ",
          style: AppFonts.subheading,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFE3F2FD),
              child: SvgPicture.asset(
                'assets/svg/email_svg.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),

      body: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        builder: (context, state) {
          if (state is CaseDetailsLoading) {
            return const Center(child: LoadingAnimation());
          }

          if (state is casedetailsFailure) {
            return Center(
              child: Text(
                "Failed to load case details.\n${state.error}",
                style: AppFonts.textSecondary.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is casedetailsSuccess) {
            final caseDetails = state.caseDetailsModel;
            final audioItems = caseDetails.draudiosummery ?? [];
            final audioList =
                audioItems.where((item) => item.docTypeID == 6).toList();
            final docList =
                audioItems.where((item) => item.docTypeID != 6).toList();

            return Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: BlocConsumer<FinalSubmissionBloc, FinalSubmissionState>(
                listener: (context, finalState) async {
                  if (finalState is FinalSubmissionSuccess) {
                    CustomScaffoldMessenger.showSuccessMessage(
                      context,
                      finalState.message,
                    );
                    await Future.delayed(const Duration(seconds: 1));

                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/mainpage', (route) => false);
                  }

                  if (finalState is FinalSubmissionFailed) {
                    CustomScaffoldMessenger.showErrorMessage(
                      context,
                      finalState.error,
                    );
                  }
                },
                builder: (context, finalState) {
                  if (finalState is FinalSubmissionLoading) {
                    return const Center(child: LoadingAnimation());
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                              caseDetails.caseInfo!.patientName,
                              style: AppFonts.subheading,
                            ),
                            const Spacer(),
                            Container(
                              width: 68.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                color: AppColors.successcolor.withAlpha(10),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "In Review",
                                  style: AppFonts.subtext.copyWith(
                                    fontSize: 10,
                                    color: AppColors.successcolor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            const Icon(Icons.person),
                            Text(
                              caseDetails.caseInfo!.gender,
                              style: AppFonts.subtext,
                            ),
                            SizedBox(width: 14.w),
                            const Icon(Icons.cake, size: 18),
                            SizedBox(width: 5),
                            Text(
                              caseDetails.caseInfo!.dob.toString(),
                              style: AppFonts.subtext,
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 6,
                              color: AppColors.red,
                            ),
                            SizedBox(width: 4),
                            Text(
                              caseDetails.caseInfo!.dueDate.toString(),
                              style: AppFonts.textSecondary.copyWith(
                                fontSize: 16,
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        CustomContainer(
                          greyHeading: "Written Report",

                          datas: caseDetails.caseInfo!.summaryOfRecords,
                        ),
                        docList.isEmpty ? SizedBox() : SizedBox(height: 16),
                        docList.isEmpty
                            ? SizedBox()
                            : CustomContainer(
                              greyHeading: "Attached Documents",
                              customWidgets: Container(
                                width: 41.w,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  color: AppColors.successcolor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "${docList.length} Files",
                                    style: AppFonts.subtext.copyWith(
                                      fontSize: 10,
                                      color: AppColors.successcolor,
                                    ),
                                  ),
                                ),
                              ),

                              customWidgets1: [
                                SizedBox(height: 10),
                                ReportListWidget(
                                  isDrUploaded: true,
                                  fileList: docList,
                                  itemCount: docList.length,
                                  caseID:
                                      widget.caseDetailsModel.caseInfo!.caseID
                                          .toString(),
                                  saltID: widget.saltID,
                                ),
                              ],
                            ),
                        audioList.isEmpty ? SizedBox() : SizedBox(height: 16.h),
                        audioList.isEmpty
                            ? SizedBox()
                            : CustomContainer(
                              greyHeading: "Audio Summary",

                              customWidgets1:
                                  audioList.isNotEmpty
                                      ? [
                                        SizedBox(height: 10),
                                        AudioSummaryListWidget(
                                          audioList: audioList,
                                          isDrUploaded: true,
                                          caseID:
                                              widget
                                                  .caseDetailsModel
                                                  .caseInfo!
                                                  .caseID
                                                  .toString(),
                                          saltID: widget.saltID,
                                        ),
                                      ]
                                      : [],
                            ),
                        caseDetails.questions!.isEmpty
                            ? SizedBox()
                            : SizedBox(height: 16.h),
                        caseDetails.questions!.isEmpty
                            ? SizedBox()
                            : CustomContainer(
                              greyHeading: "Q&A",

                              customWidgets1: [
                                SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: caseDetails.questions!.length,
                                  itemBuilder: (context, index) {
                                    var qaList = caseDetails.questions![index];
                                    return CommonQa(
                                      question: qaList.question,
                                      ans: qaList.answer.toString(),
                                      support: qaList.support.toString(),
                                    );
                                  },
                                ),
                              ],
                            ),
                        SizedBox(height: 16.h),
                        BlocBuilder<AttestBloc, AttestState>(
                          builder: (context, attestState) {
                            if (attestState is AttestLoading) {
                              return const Center(child: LoadingAnimation());
                            }

                            if (attestState is AttestFailedState) {
                              return Center(
                                child: Text(
                                  "Failed to load attestation list.\n${attestState.error}",
                                  style: AppFonts.textSecondary.copyWith(
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            if (attestState is AttestSuccessState) {
                              final response = attestState.response;
                              final data = response["Data"];
                              if (data == null ||
                                  data.isEmpty ||
                                  data[0].isEmpty) {
                                return CustomContainer(
                                  greyHeading:
                                      "Clinical and Compliance Declaration",
                                  customWidgets1: [
                                    Center(
                                      child: Text(
                                        "No attestation items found",
                                        style: AppFonts.textSecondary,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              final List<dynamic> attestList = data[0];
                              if (_attestationChecks.length !=
                                  attestList.length) {
                                _attestationChecks = List.generate(
                                  attestList.length,
                                  (_) => false,
                                );
                              }

                              return CustomContainer(
                                greyHeading:
                                    "Clinical and Compliance Declaration",
                                customWidgets1: [
                                  SizedBox(height: 10),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: attestList.length,
                                    itemBuilder: (context, index) {
                                      final item = attestList[index];
                                      final title =
                                          item["AttestationTitle"] ??
                                          'Untitled';
                                      final description =
                                          item["Description"] ??
                                          'No description available';

                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: CommonCheckboxDeclaration(
                                          title: title,
                                          declarationText: description,
                                          initialValue:
                                              _attestationChecks[index],
                                          onChanged: (val) {
                                            setState(() {
                                              _attestationChecks[index] =
                                                  val ?? false;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),

                        SizedBox(height: 36),
                        CustomButton(
                          text: "Confirm & Submit Final Review",
                          onPressed: () {
                            final allChecked =
                                _attestationChecks.isNotEmpty &&
                                _attestationChecks.every((c) => c);

                            if (!allChecked) {
                              return CustomScaffoldMessenger.showErrorMessage(
                                context,
                                "Please check all attestation declarations before submitting.",
                              );
                            }

                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierColor: Colors.black.withAlpha(70),
                              builder:
                                  (context) => ConfirmSubmissionDialog(
                                    onConfirm: () {
                                      context.read<FinalSubmissionBloc>().add(
                                        SubmitCaseEvent(saltID: widget.saltID),
                                      );
                                    },
                                  ),
                            );
                          },
                        ),
                        SizedBox(height: 53),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          // ✅ fallback for other states
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
