import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/logo_widget.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/date_range_list.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/performance_snapshot.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/upcoming_case.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/home_page_shimmer.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _saveEmailToPrefs(String? email) async {
    if (email == null || email.isEmpty) return;
    await SharedPreference.setEmail(email);
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchHomePageInfo());
    context.read<DateRangeBloc>().add(FetchDateRangeInfo());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomePageInfoState) {
          final data = state.response["Data"];

          if (data != null &&
              data is List &&
              data.isNotEmpty &&
              data[0] != null &&
              data[0] is List &&
              data[0].isNotEmpty &&
              data[0][0] != null) {
            final info = data[0][0];
            final email = info["Email"] ?? "";

            _saveEmailToPrefs(email);
          }
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomePageLoading) {
            return const HomePageShimmerWidget();
          } else if (state is HomePageInfoState) {
            final data = state.response["Data"];

            if (data == null ||
                data.isEmpty ||
                data[0] == null ||
                data[0].isEmpty ||
                data[0][0] == null) {
              return Scaffold(body: const Center(child: Text("No data available")));
            }
            final cases = (data.length > 1 ? data[1] : []);

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: CaseAppBar(
                isHome: true,
                widgets: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [CustomLogo(isSmall: true)],
                ),
              ),
              body: RefreshIndicator(
                color: AppColors.white,
                backgroundColor: AppColors.primarycolor,
                onRefresh: () async {
                  context.read<HomeBloc>().add(FetchHomePageInfo());
                  context.read<DateRangeBloc>().add(FetchDateRangeInfo());

                  await Future.delayed(const Duration(seconds: 1));
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
              ),
            );
          } else if (state is HomePageError) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Error: ${state.message}",
                  style: AppFonts.textprimary,
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
      ),
    );
  }
}
