import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/audiosummery.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/summary.dart';

class Clainment extends StatelessWidget {
  const Clainment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Summerypage(),
        SizedBox(height: 10),
        Audiosummery(),
        SizedBox(height: 10),
        Medicalreport(),
        SizedBox(height: 10),
        Medications(),
        SizedBox(height: 10),
      ],
    );
  }
}