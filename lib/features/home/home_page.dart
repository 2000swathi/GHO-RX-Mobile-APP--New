import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/home/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_event.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/date_range_list.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/performance_snapshot.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/upcoming_case.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/home_page_shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchHomePageInfo());
    context.read<DateRangeBloc>().add(FetchDateRangeInfo());

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial || state is HomePageLoading) {
          return const HomePageShimmerWidget();
        } else if (state is HomePageInfoState) {
          final info = state.homePageModel.data[0];

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CaseAppBar(
              isHome: true,
              widgets: Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Profile avatar container
                                    Container(
                                      color: AppColors.profilepink.withAlpha(
                                        13,
                                      ),
                                      height: 200,
                                      width: 200,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svg/person.svg",
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    // Second container with edit & delete icons
                                    Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Edit icon
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              // TODO: Add your edit logic here
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.edit,
                                                  color: Colors.blueAccent,
                                                  size: 22,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Edit",
                                                  style: AppFonts.subtext
                                                      .copyWith(
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Delete icon
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              // TODO: Add your delete logic here
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                  size: 22,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Delete",
                                                  style: AppFonts.subtext
                                                      .copyWith(
                                                        color: Colors.redAccent,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.profilepink.withAlpha(13),
                          child: SvgPicture.asset("assets/svg/person.svg"),
                        ),
                      ),

                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello", style: AppFonts.textblue),
                          Text(info.name, style: AppFonts.subtext),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UpcomingCase(),

                  const PerformanceSnapshotWidget(),
                  const SizedBox(height: 15),
                  KPIHeader(),
                ],
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
    );
  }
}
