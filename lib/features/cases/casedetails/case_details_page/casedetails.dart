import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe place to read ModalRoute arguments only once
    opencases =
        ModalRoute.of(context)?.settings.arguments as OpenCaseModel;

    // Dispatch event only once per page build
    context.read<CaseDetailsBloc>().add(
      CaseDetailsEventRequested(saltID: opencases.saltKey.toString()),
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
          } else if (state is casedetailsSuccess) {
            final CaseInfo = state.caseDetailsModel.caseInfo!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          CaseInfo.patientName,
                          style: AppFonts.subheading16,
                        ),
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/person.svg",
                          colorFilter: ColorFilter.mode(
                            AppColors.textPrimary,
                            BlendMode.srcIn,
                          ),
                          width: 16,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          CaseInfo.gender,
                          style: AppFonts.subheading16.copyWith(fontSize: 14),
                        ),
                        const SizedBox(width: 15),
                        if (CaseInfo.dob!.isNotEmpty)
                          const Icon(Icons.cake, size: 19, color: AppColors.textPrimary),
                        const SizedBox(width: 7),
                        Text(
                          CaseInfo.dob.toString(),
                          style: AppFonts.subheading16.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "3 hours left",
                          style: AppFonts.textSecondary.copyWith(
                            fontSize: 14,
                            color: AppColors.red,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(Icons.circle, size: 6, color: AppColors.red),
                        const SizedBox(width: 3),
                        Text(
                          "Due Date: ${CaseInfo.dueDate}",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FinalOpinionConfirmation(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    CasesTabView(
                      caseDetailsModel: state.caseDetailsModel,
                      saltID: opencases.saltKey,
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            );
          } else if (state is casedetailsFailure) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Center(child: Text(state.error)),
            );
          }
          return Container();
        },
      ),
    );
  }
}
