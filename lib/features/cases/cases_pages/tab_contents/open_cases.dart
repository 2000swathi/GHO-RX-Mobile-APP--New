import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/bloc/open_closed_bloc.dart';

class OpenCasesTab extends StatefulWidget {
  const OpenCasesTab({super.key});

  @override
  State<OpenCasesTab> createState() => _OpenCasesTabState();
}

class _OpenCasesTabState extends State<OpenCasesTab> {
  @override
  void initState() {
    super.initState();
    context.read<OpenClosedBloc>().add(FetchOpenCases());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenClosedBloc, OpenClosedState>(
      builder: (context, state) {
        if (state is OpenClosedLoading) {
          return const Center(child: LoadingAnimation());
        } else if (state is OpenCaseLoaded) {
          final openCases = state.openCases;
          if (openCases.isEmpty) {
            return const Center(child: Text('No open cases available'));
          }
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            itemCount: openCases.length,
            separatorBuilder: (_, _) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final caseItem = openCases[index];
              return OpenCaseCard(
                ontap: () {
                  Navigator.pushNamed(
                    context,
                    '/casedetails',
                    arguments: caseItem,
                  );
                },

                caseId: caseItem.id,

                dueDate: caseItem.dueDate,
                description: caseItem.medicalSummary,
              );
            },
          );
        } else if (state is OpenCloseError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(state.message, style: AppFonts.subtext),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

class OpenCaseCard extends StatelessWidget {
  final String caseId;

  final String dueDate;
  final String description;
  final Function()? ontap;
  const OpenCaseCard({
    super.key,
    required this.caseId,

    required this.dueDate,
    required this.description,
    this.ontap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.hint2color),
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Case ID : $caseId",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Due Date :', style: AppFonts.subtext),
                          const SizedBox(height: 8),

                          Text(
                            ' $dueDate',
                            style: AppFonts.subtext.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: AppColors.primarycolor.withAlpha(15),
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: AppFonts.textappbar,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
