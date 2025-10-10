import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/closesd_cases.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/tab_contents/open_cases.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({super.key});

  @override
  State<CasesPage> createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CaseAppBar(
          height: 45,
          title: "Cases",
          tabBar: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primarycolor,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: [Tab(text: "Open"), Tab(text: "Closed")],
          ),
        ),
        body: const TabBarView(children: [OpenCasesTab(), ClosedCasesTab()]),
      ),
    );
  }
}
