import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/common_checkbox_declaration.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart'; // ✅ added this
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/widget/audio_summary_list_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/widget/report_list_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/confirm_submission_dialog.dart';
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
      CaseDetailsEventRequested(saltID: widget.saltID),
    );
  }

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
              child: SingleChildScrollView(
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
                       
                        const Icon(Icons.circle, size: 6, color: AppColors.red),
                        SizedBox(width: 4),
                        Text(
                          "${caseDetails.caseInfo!.dueDate.toString()}",
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
                    SizedBox(height: 16),
                    CustomContainer(
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

                      customWidgets1:
                          docList.isNotEmpty
                              ? [
                                SizedBox(height: 10),
                                ReportListWidget(
                                  isDrUploaded: true,
                                  fileList: docList,
                                  itemCount: docList.length,
                                ),
                              ]
                              : [],
                    ),
                    SizedBox(height: 16.h),
                    CustomContainer(
                      greyHeading: "Audio Summary",

                      customWidgets1:
                          audioList.isNotEmpty
                              ? [
                                SizedBox(height: 10),
                                AudioSummaryListWidget(
                                  audioList: audioList,
                                  isDrUploaded: true,
                                ),
                              ]
                              : [],
                    ),
                    SizedBox(height: 16.h),
                    CustomContainer(
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
                    CustomContainer(
                      greyHeading: "Clinical and Compliance Declaration",

                      commonCheckbox: [
                        SizedBox(height: 10),
                        CommonCheckboxDeclaration(
                          declarationText:
                              "I have reviewed all submitted patient information, including images, lab reports, and clinical history, and confirm the completeness of my review.",
                        ),
                        SizedBox(height: 16.h),
                        CommonCheckboxDeclaration(
                          declarationText:
                              "I attest that this second opinion is based solely on the provided documentation and reflects my independent, professional clinical judgment.",
                        ),
                        SizedBox(height: 16.h),
                        CommonCheckboxDeclaration(
                          declarationText:
                              "I confirm that I hold the necessary active license and specialized expertise required to provide this second opinion.",
                        ),
                        SizedBox(height: 16.h),
                        CommonCheckboxDeclaration(
                          declarationText:
                              "I have adhered to all platform guidelines, confidentiality standards, and relevant professional codes of conduct in generating this report.",
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    CustomButton(
                      text: "Confirm & Submit Final Review",
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black.withAlpha(70),
                          builder: (context) => const ConfirmSubmissionDialog(),
                        );
                      },
                    ),
                    SizedBox(height: 53),
                  ],
                ),
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
