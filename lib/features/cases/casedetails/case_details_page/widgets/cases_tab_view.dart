import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/claiment/claiment.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/questions.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/widgets/custom_scrollable_tabs.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/reviewpage.dart';

class CasesTabView extends StatefulWidget {
  final CaseDetailsModel caseDetailsModel;
  final String saltID;
  CasesTabView({
    super.key,
    required this.caseDetailsModel,
    required this.saltID,
  });

  @override
  State<CasesTabView> createState() => _CasesTabViewState();
}

class _CasesTabViewState extends State<CasesTabView> {
  int selectedIndex = 0;

  final List<String> tabNames = ["Claimant", "Questions", "Review"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomScrollableTabs(
          tabs: tabNames,
          onTabSelected: (index) {
            setState(() => selectedIndex = index);
          },
          useBoxStyle: true,
        ),

        SizedBox(height: 8),
        _buildTabContent(selectedIndex, widget.saltID),
      ],
    );
  }

  Widget _buildTabContent(int index, String saltID) {
    switch (index) {
      case 0:
        return Clainment(caseDetailsModel: widget.caseDetailsModel);
      case 1:
        return QuestionTab(
          questionAnswer: widget.caseDetailsModel.questions,
          saltID: saltID,
        );
      default:
        return Reviewpage();
    }
  }
}
