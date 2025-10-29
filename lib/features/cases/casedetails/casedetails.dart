import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/bloc/case_details_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/bloc/case_details_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/finalopinionsubmission/final_opinion_confirmation.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/repository/case_det_repository.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/cases_tab_view.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/repository/model/open_case_model.dart';

// ignore: must_be_immutable
class CaseDetailsPage extends StatelessWidget {
  CaseDetailsPage({super.key});
  final repository = CaseDetRepository();

  @override
  Widget build(BuildContext context) {
    final opencases =
        ModalRoute.of(context)?.settings.arguments as OpenCaseModel?;
    context.read<CaseDetailsBloc>().add(
      CaseDetailsEventRequested(saltID: opencases?.saltKey.toString() ?? ""),
    );
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
          "Case ID : ${opencases?.id.toString()} ",
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
            return Center(child: LoadingAnimation());
          } else if (state is casedetailsSuccess) {
            final CaseInfo = state.caseDetailsModel.caseInfo!;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
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
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/qaPage");
                          },
                          child: Container(
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
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
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
                        SizedBox(width: 7),
                        Text(
                          CaseInfo.gender,
                          style: AppFonts.subheading16.copyWith(fontSize: 14),
                        ),
                        SizedBox(width: 15),
                        CaseInfo.dob!.isNotEmpty || CaseInfo.dob != ""
                            ? Icon(Icons.cake,size: 19,color: AppColors.textPrimary,)
                            : SizedBox(),
                        SizedBox(width: 7),
                        Text(
                          CaseInfo.dob.toString(),
                          style: AppFonts.subheading16.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                        SizedBox(width: 3),
                        Icon(Icons.circle, size: 6, color: AppColors.red),
                        SizedBox(width: 3),
                        Text(
                          "Due Date: ${CaseInfo.dueDate}",
                          style: AppFonts.textSecondary.copyWith(
                            fontSize: 14,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    CustomButton(
                      text: "Submit Review",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinalOpinionConfirmation(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 14),
                    CasesTabView(caseDetailsModel: state.caseDetailsModel),
                    SizedBox(height: 14),
                  ],
                ),
              ),
            );
          } else if (state is casedetailsFailure) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }
}
