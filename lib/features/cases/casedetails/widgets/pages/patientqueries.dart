import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/patient_queries_POPUP.dart';
import 'package:ghorx_mobile_app_new/features/profile/widget/edit_profile_sheet.dart';

class Patientqueries extends StatelessWidget {
  Patientqueries({super.key});

  final List<String> queries = [
    'Do my symptoms definitely suggest a stroke, or could it be something else?',
    'What risks do I face if I delay admission or treatment?',
    'What treatment options are available for my condition right now?',
    'Based on my reports, what is your recommendation?',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color:AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Text(
            'Patient Queries',
            style: AppFonts.subheading16 
          ),
           const SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(),
            itemCount: queries.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        PatientQueriesPopup.showSheet(context, queries[index]);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 5,
                            height: 50,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: const BoxDecoration(
                              color: AppColors.yellow,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              queries[index],
                              style: AppFonts.buttontxt16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Reply',
                          style: AppFonts.subheading16.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/svg/replay.svg',
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}