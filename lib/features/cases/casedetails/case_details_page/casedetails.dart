import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/bloc/case_details_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/case_det_repository.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/widgets/cases_tab_view.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/final_opinion_confirmation.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/repository/model/open_case_model.dart';

class CaseDetailsPage extends StatefulWidget {
  const CaseDetailsPage({super.key});

  @override
  State<CaseDetailsPage> createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  final repository = CaseDetRepository();
  late OpenCaseModel opencases;
  bool isRefreshed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    opencases = ModalRoute.of(context)?.settings.arguments as OpenCaseModel;

    context.read<CaseDetailsBloc>().add(
      CaseDetailsEventRequested(
        caseID: opencases.caseID.toString(),
        caseReviewerID: opencases.caseReviewerID,
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
          padding: EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: SvgPicture.asset("assets/svg/Vector.svg"),
            ),
          ),
        ),
        title: Text(
          "Case ID : ${opencases.id.toString()} ",
          style: AppFonts.subheading,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE3F2FD),
              child: CircleAvatar(
                backgroundColor: AppColors.primarycolor.withAlpha(8),
                child: SvgPicture.asset("assets/svg/email_svg.svg"),
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

          if (state is casedetailsSuccess) {
            final caseInfo = state.caseDetailsModel.caseInfo;
            if (caseInfo == null) {
              return Center(child: Text("Case info not available"));
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(caseInfo.patient, style: AppFonts.subheading16),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightgreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'In Review',
                            style: AppFonts.textprimarygreen,
                          ),
                        ),
                      ],
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
                          "Assigned Date : ${caseInfo.dateAssigned}",
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
                          "Due Date : ${caseInfo.dueDate}",
                          style: AppFonts.textSecondary.copyWith(
                            fontSize: 14,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    CustomButton(
                      text: "Submit Review",
                      onPressed: () {
                        final summary =
                            state.caseDetailsModel.caseInfo?.summaryOfRecords
                                .trim() ??
                            '';
                        final hasUnanswered = state.caseDetailsModel.questions
                            .any((q) {
                              final answer = q.answer.toString().trim();
                              final support = q.support.toString().trim();
                              return answer.isEmpty || support.isEmpty;
                            });
                        if (summary.isEmpty && hasUnanswered) {
                          return CustomScaffoldMessenger.showErrorMessage(
                            context,
                            "Please fill the required* fields before submitting!",
                          );
                        } else if (hasUnanswered) {
                          return CustomScaffoldMessenger.showErrorMessage(
                            context,
                            "Please provide either an answer or support for each question before submitting!",
                          );
                        } else if (summary.isEmpty) {
                          return CustomScaffoldMessenger.showErrorMessage(
                            context,
                            "Please add your review before submitting!",
                          );
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => FinalOpinionConfirmation(
                                  caseDetailsModel: state.caseDetailsModel,
                                  caseReviewerID: opencases.caseReviewerID,
                                ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    CasesTabView(
                      caseDetailsModel: state.caseDetailsModel,
                      caseReviewerID: opencases.caseReviewerID,
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            );
          } else if (state is casedetailsFailure) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Text(state.error, textAlign: TextAlign.center),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
