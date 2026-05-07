import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/audiosummery.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/existing_condition_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/life_style_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/medical_history.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/widget/audio_summary_list_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/widget/report_list_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/summary.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/widget/common_qa.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/repository/model/closed_case_model.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class ClosedCaseDetails extends StatefulWidget {
  final ClosedCaseModel closedCaseModel;
  final String saltID;
  const ClosedCaseDetails({
    super.key,
    required this.closedCaseModel,
    required this.saltID,
  });

  @override
  State<ClosedCaseDetails> createState() => _ClosedCaseDetailsState();
}

class _ClosedCaseDetailsState extends State<ClosedCaseDetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CaseDetailsBloc>().add(
      CaseDetailsEventRequested(
        caseID: widget.saltID,
        caseReviewerID: widget.saltID,
      ),
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
          "Case ID : ${widget.closedCaseModel.id.toString()} ",
          style: AppFonts.subheading,
        ),
      ),

      body: BlocBuilder<CaseDetailsBloc, CaseDetailsState>(
        builder: (context, state) {
          if (state is CaseDetailsLoading) {
            return const Center(child: LoadingAnimation());
          }

          if (state is casedetailsFailure) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  state.error,
                  style: AppFonts.textprimary,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is casedetailsSuccess) {
            final caseDetails = state.caseDetailsModel;
            if (caseDetails.caseInfo == null) {
              return Center(
                child: Text(
                  "No Case Details Available",
                  style: AppFonts.textprimary,
                ),
              );
            }
            final rawConditions = caseDetails.caseInfo?.extCondition ?? '';

            final conditions =
                rawConditions
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
            final lifestyleData = {
              "Diet": caseDetails.caseInfo?.diet?.toString() ?? '',
              "Smoking Status": caseDetails.caseInfo?.smoke?.toString() ?? '',
              "Alcohol Use": caseDetails.caseInfo?.alcoholUse?.toString() ?? '',
              "Exercise Status":
                  caseDetails.caseInfo?.exercise?.toString() ?? '',
              "Weight": caseDetails.caseInfo?.weight?.toString() ?? '',
              "Height": caseDetails.caseInfo?.height?.toString() ?? '',
            };
            final audioItemsdr = caseDetails.reviewerDocuments ?? [];
            final audioItemsPat = caseDetails.clientDocuments ?? [];
            final audioListdr =
                audioItemsdr.where((item) => item.documentTypeId == 6).toList();
            final audioListPat =
                audioItemsPat
                    .where((item) => item.documentTypeId == 6)
                    .toList();
            final docList =
                audioItemsdr.where((item) => item.documentTypeId != 6).toList();
            final docListPat =
                audioItemsPat
                    .where((item) => item.documentTypeId != 6)
                    .toList();

            final reportDocument = caseDetails.reportDocuments ?? [];

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
                          caseDetails.caseInfo!.patient,
                          style: AppFonts.subheading,
                        ),
                        const Spacer(),
                        Container(
                          width: 68.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: AppColors.warningred.withAlpha(10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Closed",
                              style: AppFonts.subtext.copyWith(
                                fontSize: 10,
                                color: AppColors.warningred,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Ethnicity : ${caseDetails.caseInfo?.ethnicity}",
                      style: AppFonts.textSecondary.copyWith(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 6,
                          color: AppColors.textPrimary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Assigned Date : ${caseDetails.caseInfo?.dateAssigned}",
                          style: AppFonts.textSecondary.copyWith(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.circle, size: 6, color: AppColors.red),
                        const SizedBox(width: 3),
                        Text(
                          "Due Date : ${caseDetails.caseInfo?.dueDate}",
                          style: AppFonts.textSecondary.copyWith(
                            fontSize: 14,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),
                    Summerypage(medicalSummary: caseDetails.caseInfo),
                    SizedBox(height: 10),
                    ConditionListWidget(conditions: conditions),
                    SizedBox(height: 10),
                    LifestyleWidget(lifestyleData: lifestyleData),
                    const SizedBox(height: 10),
                    const MedicalHistoryWidget(),
                    SizedBox(height: 10),
                    Audiosummery(documents: caseDetails.clientDocuments),

                    caseDetails.medications.isEmpty
                        ? SizedBox()
                        : CustomContainer(
                          greyHeading: "Medication",
                          customWidgets1: [
                            SizedBox(height: 10),
                            Column(
                              children:
                                  caseDetails.medications.map((medications) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 6),
                                      child: Row(
                                        children: [
                                          Text(
                                            medications.name,
                                            style: AppFonts.buttontxt.copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${medications.startPeriod} ${medications.endPeriod}",
                                            style: AppFonts.labelItalic,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                    //docListPat.isEmpty ? SizedBox() : SizedBox(height: 16),
                    docListPat.isEmpty
                        ? SizedBox()
                        : CustomContainer(
                          greyHeading: "Patient Attached Documents",
                          customWidgets: Container(
                            width: 41.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColors.successcolor.withAlpha(10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${docListPat.length} Files",
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
                              fileList: docListPat,
                              itemCount: docListPat.length,
                              caseID: widget.closedCaseModel.caseID.toString(),
                              saltID: widget.saltID,
                            ),
                          ],
                        ),
                    //audioListPat.isEmpty ? SizedBox() : SizedBox(height: 16.h),
                    audioListPat.isEmpty
                        ? SizedBox()
                        : CustomContainer(
                          greyHeading: "Patient Audio Summary",

                          customWidgets1:
                              audioListPat.isNotEmpty
                                  ? [
                                    SizedBox(height: 10),
                                    AudioSummaryListWidget(
                                      audioList: audioListPat,
                                      caseID:
                                          widget.closedCaseModel.caseID
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
                    
                    CustomContainer(
                      greyHeading: "Doctor Report",
                      datas: caseDetails.caseInfo!.summaryOfRecords,
                    ),
                    docList.isEmpty ? SizedBox() : SizedBox(),
                    docList.isEmpty
                        ? SizedBox()
                        : CustomContainer(
                          greyHeading: "Doctor Attached Documents",
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
                              fileList: docList,
                              itemCount: docList.length,
                              caseID: widget.closedCaseModel.caseID.toString(),
                              saltID: widget.saltID,
                            ),
                          ],
                        ),
                    audioListdr.isEmpty ? SizedBox() : SizedBox(height: 16.h),
                    audioListdr.isEmpty
                        ? SizedBox()
                        : CustomContainer(
                          greyHeading: "Doctor Audio Summary",

                          customWidgets1:
                              audioListdr.isNotEmpty
                                  ? [
                                    SizedBox(height: 10),
                                    AudioSummaryListWidget(
                                      audioList: audioListdr,
                                      caseID:
                                          widget.closedCaseModel.caseID
                                              .toString(),
                                      saltID: widget.saltID,
                                    ),
                                  ]
                                  : [],
                        ),
                    docListPat.isEmpty
                        ? SizedBox()
                        : CustomContainer(
                          greyHeading: "Final Report Document",
                          customWidgets: Container(
                            width: 41.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColors.successcolor.withAlpha(10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${reportDocument.length} Files",
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
                              fileList: reportDocument,
                              itemCount: reportDocument.length,
                              caseID: widget.closedCaseModel.caseID.toString(),
                              saltID: widget.saltID,
                            ),
                          ],
                        ),

                    SizedBox(height: 36),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
