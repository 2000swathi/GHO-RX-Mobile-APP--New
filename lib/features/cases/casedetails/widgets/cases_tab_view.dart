import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/summary.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/custom_scrollable_tabs.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/patientqueries.dart';

class CasesTabView extends StatefulWidget {
  const CasesTabView({super.key});

  @override
  State<CasesTabView> createState() => _CasesTabViewState();
}

class _CasesTabViewState extends State<CasesTabView> {
  int selectedIndex = 0;

  final List<String> tabNames = [
    "Summary",
    "Questions",
    "Medical Documents",
    "Medications",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomScrollableTabs(
          tabs: tabNames,
          onTabSelected: (index) {
            setState(() => selectedIndex = index);
          },
        ),

        const SizedBox(height: 8),
        _buildTabContent(selectedIndex),
      ],
    );
  }
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return Summerypage();
      case 1:
        return Patientqueries();
      case 2:
        return Medicalreport();
      case 3:
        return Medications();
      default:
        return SizedBox(); 
    }
  }
}