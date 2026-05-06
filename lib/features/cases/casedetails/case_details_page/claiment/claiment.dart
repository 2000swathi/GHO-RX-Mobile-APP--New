import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/existing_condition_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/life_style_widget.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/medical_history.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/audiosummery.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/pages/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/summary.dart';

class Clainment extends StatelessWidget {
  final CaseDetailsModel caseDetailsModel;
  const Clainment({super.key, required this.caseDetailsModel});

  @override
  Widget build(BuildContext context) {
    final conditions = ["COPD", "Asthma", "Anemia"];
    final lifestyleData = {
      "Diet": "Vegetarian",
      "Smoking Status": "Non-smoker",
      "Alcohol Use": "Occasionally",
      "Exercise Status": "Regular",
      "Weight": "70 kg",
      "Height": "175 cm",
    };
    return Column(
      children: [
        Summerypage(medicalSummary: caseDetailsModel.caseInfo),
        SizedBox(height: 10),
        ConditionListWidget(conditions: conditions),
        SizedBox(height: 10),
        LifestyleWidget(lifestyleData: lifestyleData),
        const SizedBox(height: 10),
        const MedicalHistoryWidget(),
        SizedBox(height: 10),
        Audiosummery(documents: caseDetailsModel.clientDocuments),
        Medicalreport(medicalsummery: caseDetailsModel.clientDocuments),
        Medications(medicationModel: caseDetailsModel.medications),
        SizedBox(height: 10),
      ],
    );
  }
}
