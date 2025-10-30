import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/bloc/open_closed_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/repository/open_closed_repo.dart';

class ClosedCasesTab extends StatelessWidget {
  const ClosedCasesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              OpenClosedBloc(repository: OpenClosedRepository())
                ..add(FetchClosedCases()),
      child: BlocBuilder<OpenClosedBloc,OpenClosedState>(
        builder: (context, state) {
          if (state is OpenClosedInitial || state is OpenClosedLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is ClosedCaseLoaded) {
            final closedCases = state.closedcases;
            if (closedCases.isEmpty) {
              return const Center(child: Text('No closed cases available'));
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemCount: closedCases.length,
              itemBuilder: (context, index) {
                final caseItem = closedCases[index];
                return CaseCard(
                  caseId: "Csse ID ${caseItem.id.toString()}",
                  name: caseItem.patientName,
                  payout: "80",
                  dueDate: caseItem.completedDate,
                  description: caseItem.summaryOfRecords,
                );
              },
            );
          } else if (state is OpenCloseError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: AppFonts.subtext.copyWith(color: AppColors.warningred),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class CaseCard extends StatelessWidget {
  final String caseId;
  final String name;
  final String payout;
  final String dueDate;
  final String description;
  final String? status;

  const CaseCard({
    super.key,
    required this.caseId,
    required this.name,
    required this.payout,
    required this.dueDate,
    required this.description,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.hint2color),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status != null)
            Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successcolor.withAlpha(10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status!,
                style: AppFonts.subtext.copyWith(color: AppColors.successcolor),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$caseId : $name",
                style: AppFonts.semiratechart,
                textAlign: TextAlign.left,
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(description, style: AppFonts.subtext),
          SizedBox(height: 15),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Anticipated Payout",
                    style: AppFonts.subtext.copyWith(
                      color: AppColors.hint1color,
                    ),
                  ),
                  Text(
                    "\$$payout",
                    style: AppFonts.semiratechart.copyWith(
                      color: AppColors.successcolor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Completed Date",
                    style: AppFonts.subtext.copyWith(
                      color: AppColors.hint1color,
                    ),
                  ),
                  Text(
                    dueDate,
                    style: AppFonts.subtext.copyWith(
                      fontSize: 16,
                      color: AppColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
