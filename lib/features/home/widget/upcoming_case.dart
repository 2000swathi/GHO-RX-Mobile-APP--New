import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/closesd_cases.dart';

class UpcomingCase extends StatelessWidget {
  const UpcomingCase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text("Cases"), Spacer(), Text("See All")]),
        SizedBox(height: 15),
        CaseCard(
          caseId: "17",
          name: "name",
          payout: "payout",
          dueDate: "dueDate",
          description: "description.....here",
        ),
        SizedBox(height: 15,)
      ],
    );
  }
}
