import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/open_cases.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/repository/model/open_case_model.dart';
import 'package:ghorx_mobile_app_new/main_page.dart';

class UpcomingCase extends StatelessWidget {
  dynamic cases;
  UpcomingCase({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Cases", style: AppFonts.subheading),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MainPage(initialIndex: 1),
                  ),
                );
              },
              child: Text("See All >"),
            ),
          ],
        ),
        SizedBox(height: 10),
        OpenCaseCard(
          caseId: cases["id"].toString(),
          ontap: () {
             final openCase = OpenCaseModel.fromJson(cases);
          Navigator.pushNamed(
            context,
            AppRouter.casedetails,
            arguments: openCase,
          );
          },
          patient: cases["Patient"] ?? "",
          dueDate: cases["DueDate"] ?? "",
          description: cases["MedicalSummary"] ?? "",
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
