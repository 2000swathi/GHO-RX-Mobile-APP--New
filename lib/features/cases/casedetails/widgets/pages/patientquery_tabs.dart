import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/tab_contents/answer_tab.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/widgets/pages/tab_contents/support_tab.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/scrollabale_tabs.dart';

class QueriesTabs extends StatefulWidget {
  const QueriesTabs({super.key});

  @override
  State<QueriesTabs> createState() => _QueriesTabsState();
}

class _QueriesTabsState extends State<QueriesTabs> {
  int selectedIndex = 0;

  final List<String> tabNames = [
    "Answer",
    "Support",
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
            useBoxStyle: true,
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
        return AnswerTab();
      case 1:
        return SupportTab();
      default:
        return const SizedBox();
    }
  }
}
