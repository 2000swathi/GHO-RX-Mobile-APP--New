import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/claiment.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/questions.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/custom_scrollable_tabs.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/reviewpage.dart';

class CasesTabView extends StatefulWidget {
  final CaseDetailsModel caseDetailsModel;
  CasesTabView({super.key, required this.caseDetailsModel});

  @override
  State<CasesTabView> createState() => _CasesTabViewState();
}

class _CasesTabViewState extends State<CasesTabView> {
  int selectedIndex = 0;

  final List<String> tabNames = ["Claimant", "Questions", 'Review'];

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
        _buildTabContent(selectedIndex),
      ],
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return Clainment(caseDetailsModel: widget.caseDetailsModel);
      case 1:
        return QuestionTab(questionAnswer:widget.caseDetailsModel.questions);
      default:
        return Reviewpage();
    }
  }
}
