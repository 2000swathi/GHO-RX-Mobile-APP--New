import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/bloc/open_closed_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/closesd_cases.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/tab_contents/open_cases.dart';
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
        body: TabBarView(
          children: [
            RefreshIndicator(
              color: AppColors.white,
              backgroundColor: AppColors.primarycolor,
              onRefresh: () async {
                context.read<OpenClosedBloc>().add(FetchOpenCases());
              },
              child: OpenCasesTab(),
            ),
            RefreshIndicator(
              color: AppColors.white,
              backgroundColor: AppColors.primarycolor,
              onRefresh: () async {
                context.read<OpenClosedBloc>().add(FetchClosedCases());
              },
              child: ClosedCasesTab(),
            ),
          ],
        ),
      ),
    );
  }
}
