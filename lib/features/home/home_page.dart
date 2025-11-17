import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/date_range_list.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/performance_snapshot.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/upcoming_case.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/home_page_shimmer.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Future<void> _saveEmailToPrefs(String? email) async {
    if (email == null || email.isEmpty) return;

    await SharedPreference.setEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchHomePageInfo());
    context.read<DateRangeBloc>().add(FetchDateRangeInfo());

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial || state is HomePageLoading) {
          return const HomePageShimmerWidget();
        } else if (state is HomePageInfoState) {
          final info = state.response["Data"][0][0];
          final email = info["Email"];
          _saveEmailToPrefs(email);
          final cases = state.response["Data"][1];
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CaseAppBar(
              isHome: true,
              widgets: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [CustomLogo(isSmall: true)],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cases.isEmpty
                      ? SizedBox.shrink()
                      : UpcomingCase(cases: cases[0]),

                  const SizedBox(height: 10),
                  KPIHeader(),
                  const PerformanceSnapshotWidget(),
                ],
              ),
            ),
          );
        } else if (state is HomePageError) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Error: ${state.message}",
                  style: AppFonts.textprimary,
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Unknown state", style: AppFonts.textprimary),
          ),
        );
      },
    );
  }
}
