import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/open_cases.dart';
import 'package:ghorx_mobile_app_new/main_page.dart';

class UpcomingCase extends StatelessWidget {
  const UpcomingCase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Cases",style: AppFonts.subheading,),
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
        SizedBox(height: 15),
        OpenCaseCard(
          caseId: "Case: 21",
          allottedTime: "time",
          dueDate: "dueDate",
          description: "description",
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
