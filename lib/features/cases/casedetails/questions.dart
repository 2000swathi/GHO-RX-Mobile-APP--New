import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/patient_queries_POPUP.dart';

class QuestionTab extends StatelessWidget {
  final List<QuestionAnswerModel>? questionAnswer;
  QuestionTab({super.key, required this.questionAnswer});

  @override
  Widget build(BuildContext context) {
    final questionAns = questionAnswer ?? [];
    if (questionAns.isEmpty) {
      return Center(child: Text("No Questions Added"));
    }
    return Container(
      margin: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q&A",
              style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questionAns.length,
              itemBuilder: (context, index) {
                final qAndA = questionAns[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          QuestionansSheet.showSheet(context, qAndA.question);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/pointdot.svg",
                              width: 15,
                              height: 15,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                qAndA.question,
                                style: AppFonts.buttontxt16.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
