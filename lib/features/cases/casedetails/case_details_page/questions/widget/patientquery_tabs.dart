import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/tab_contents/answer_tab.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/tab_contents/support_tab.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/scrollabale_tabs.dart';

class QueriesTabs extends StatefulWidget {
  final String? answer;
  final String? support;
  final String saltID;
  final String questID;

  const QueriesTabs({
    super.key,
    this.answer,
    this.support,
    required this.saltID,
    required this.questID,
  });

  @override
  State<QueriesTabs> createState() => _QueriesTabsState();
}

class _QueriesTabsState extends State<QueriesTabs> {
  int selectedIndex = 0;
  String? answerText;
  String? supportText;
  String saltId = "";
  String questID = "";

  final List<String> tabNames = ["Answer*", "Support*"];

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    answerText = widget.answer;
    supportText = widget.support;
    saltId = widget.saltID;
    questID = widget.questID;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          CustomScrollableTabs(
            tabs: tabNames,
            selectedIndex: selectedIndex,
            onTabSelected: (index) => changeTab(index),
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
        return AnswerTab(
          answer: answerText,
          onNext: (text) {
            setState(() {
              print(text);
              answerText = text;
              selectedIndex = 1;
            });
          },
        );

      case 1:
        return SupportTab(
          previousAnswer: answerText,
          supportText: supportText,
          questID: questID,
          saltID: saltId,
        );

      default:
        return const SizedBox();
    }
  }
}
