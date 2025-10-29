import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/audiosummery.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/summary.dart';

class Clainment extends StatelessWidget {
  final CaseDetailsModel caseDetailsModel;
  Clainment({super.key, required this.caseDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Summerypage(medicalSummary: caseDetailsModel.medicalSummary),
        SizedBox(height: 10),
        Audiosummery(audiosummery: caseDetailsModel.audiosummery),
        SizedBox(height: 10),
        Medicalreport(medicalsummery: caseDetailsModel.audiosummery),
        SizedBox(height: 10),
        Medications(medicationModel: caseDetailsModel.medications),
        SizedBox(height: 10),
      ],
    );
  }
}
