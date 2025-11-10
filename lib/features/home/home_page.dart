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
                      CircleAvatar(
                        backgroundColor: AppColors.profilepink.withAlpha(13),
                        child: SvgPicture.asset("assets/svg/person.svg"),
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
                  
                  // // 🔸 Verification notice
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 15),
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 10,
                  //     vertical: 10,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.profilepink.withAlpha(13),
                  //     border: Border.all(
                  //       color: const Color(0xffF6E3B3),
                  //       width: 1,
                  //     ),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         width: 16.67,
                  //         height: 16.67,
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xffFFF8E6),
                  //           shape: BoxShape.circle,
                  //           border: Border.all(
                  //             color: const Color(0xff983C3C),
                  //             width: 1.5,
                  //           ),
                  //         ),
                  //         child: const Icon(
                  //           Icons.priority_high,
                  //           color: Color(0xff983C3C),
                  //           size: 10,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Flexible(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Profile Verification Pending",
                  //               style: AppFonts.textblue.copyWith(
                  //                 color: const Color(0xff983C3C),
                  //               ),
                  //             ),
                  //             Text(
                  //               "Your profile is currently under review by a GHO administrator. We will notify you when it is approved.",
                  //               style: AppFonts.textappbar.copyWith(
                  //                 fontFamily: 'Roboto Flex',
                  //                 color: const Color(0xffAA5757),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
