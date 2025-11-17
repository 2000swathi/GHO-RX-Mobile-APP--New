import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/case_details_page/questions/widget/patientquery_tabs.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/case_details_page/questions/widget/queries_bottom_sheet.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/case_details_page/repository/model/case_details_model.dart';

class QuestionansSheet {
  static void showSheet(
    BuildContext context,
    QuestionAnswerModel qAndA,
    String saltID,
  ) {
    print(qAndA.id.toString());
    print(qAndA.question.toString());
    print(qAndA.answer.toString());
    print(qAndA.support.toString());
    print(saltID.toString());
    CustomQuerySheet.showsheet(
      context: context,
      heading: "Patient Queries",
      content: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  height: 40,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(color: AppColors.yellow),
                ),
                Expanded(
                  child: Text(qAndA.question, style: AppFonts.textprimary),
                ),
              ],
            ),
            const SizedBox(height: 10),
            QueriesTabs(
              answer: qAndA.answer,
              support: qAndA.support,
              questID: qAndA.id.toString(),
              saltID: saltID,
            ),
          ],
        ),
      ],
    );
  }
}
