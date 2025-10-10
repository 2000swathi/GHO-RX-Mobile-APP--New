import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/claiment.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/reviewpage.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/scrollabale_tabs.dart';

class CasesTabView extends StatefulWidget {
  const CasesTabView({super.key});

  @override
  State<CasesTabView> createState() => _CasesTabViewState();
}

class _CasesTabViewState extends State<CasesTabView> {
  int selectedIndex = 0;

  final List<String> tabNames = [
    "Claimant",
    "Questions",
    'Review'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      //  CustomScrollableTabs(
      //     tabs: tabNames,
      //     onTabSelected: (index) {
      //       setState(() => selectedIndex = index);
      //     },
      //     useBoxStyle: true,
      //   ),
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
        return Clainment();
      case 1:
        return SizedBox();
      case 2:
        return Reviewpage();
      default:
        return SizedBox(); 
    }
  }
}