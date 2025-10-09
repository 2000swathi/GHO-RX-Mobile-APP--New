import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/scrollabale_tabs.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/in_progress.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/new_case.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/pending_case.dart';

class CasesTabView extends StatefulWidget {
  const CasesTabView({super.key});

  @override
  State<CasesTabView> createState() => _CasesTabViewState();
}

class _CasesTabViewState extends State<CasesTabView> {
  int selectedIndex = 0;

  final List<String> tabNames = [
    "New Cases",
    "In Progress",
    "Pending",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
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
      ),
    );
  }
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return NewCasesTab();
      case 1:
        return InProgressTab();
      case 2:
        return PendingTab();
      default:
        return const SizedBox();
    }
  }
}
