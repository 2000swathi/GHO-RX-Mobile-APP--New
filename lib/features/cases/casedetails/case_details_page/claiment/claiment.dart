import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/audiosummery.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/summary.dart';

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
