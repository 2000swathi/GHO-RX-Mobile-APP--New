import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/Summery.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/customScrollableTabs.dart';
import 'package:ghorx_mobile_app_new/features/cases/medicalreport.dart';
import 'package:ghorx_mobile_app_new/features/cases/medications.dart';
import 'package:ghorx_mobile_app_new/features/cases/patientqueries.dart';

class CasesTabView extends StatefulWidget {
  const CasesTabView({super.key});

  @override
  State<CasesTabView> createState() => _CasesTabViewState();
}

class _CasesTabViewState extends State<CasesTabView> {
  int selectedIndex = 0;

  final List<String> tabNames = [
    "Summary",
    "Patient Queries",
    "Medical Report",
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

        const SizedBox(height: 10),
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
        return SizedBox(); // fallback
    }
  }
}