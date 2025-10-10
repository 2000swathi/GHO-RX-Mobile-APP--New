import 'package:flutter/material.dart';

import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/patientquery_tabs.dart';

class QuestionansSheet {
  static void showSheet(BuildContext context, String quires) {
    CustomBottomSheet.show(
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
                  child: Text(
                    quires,
                    style: AppFonts.textprimary, 
                )),
              ],
            ),
            const SizedBox(height: 10),
            QueriesTabs(),
          ],
        ),
      ],
      actionButton: CustomButton(text: "Submit", onPressed: () {}),
    );
  }
}
