import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/patient_queries_POPUP.dart';

class QuestionTab extends StatelessWidget {
  QuestionTab({super.key});
  final List<String> queries = [
    'Do my symptoms definitely suggest a stroke, or could it be something else?',
    'What risks do I face if I delay admission or treatment?',
    'What treatment options are available for my condition right now?',
    'Based on my reports, what is your recommendation?',
  ];

  @override
    Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.all(1.0),
      padding:  EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset:  Offset(0, 3),
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
              physics:NeverScrollableScrollPhysics(),
              itemCount: queries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                           QuestionansSheet.showSheet(context,queries[index] );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svg/pointdot.svg",
                            width: 15,
                            height: 15,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                queries[index],
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