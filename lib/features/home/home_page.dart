import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/common_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/home/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/performance_snapshot.dart';
import 'package:ghorx_mobile_app_new/features/shimmer/home_page_shimmer.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // When HomeBloc is already provided outside, we just access it here.
    final homeBloc = context.read<HomeBloc>();

    // Trigger the event once if needed (example: when entering the page)
    homeBloc.add(FetchHomePageInfo());

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
                  // 🔸 Verification notice
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.profilepink.withAlpha(13),
                      border: Border.all(color: const Color(0xffF6E3B3), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 16.67,
                          height: 16.67,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF8E6),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xff983C3C), width: 1.5),
                          ),
                          child: const Icon(Icons.priority_high, color: Color(0xff983C3C), size: 10),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile Verification Pending",
                                style: AppFonts.textblue.copyWith(color: const Color(0xff983C3C)),
                              ),
                              Text(
                                "Your profile is currently under review by a GHO administrator. We will notify you when it is approved.",
                                style: AppFonts.textappbar.copyWith(
                                  fontFamily: 'Roboto Flex',
                                  color: const Color(0xffAA5757),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const PerformanceSnapshotWidget(),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Key Performance Indicators",
                        style: AppFonts.subtext.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 32.h,
                            width: 46.h,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundcolor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "7 Days",
                                style: AppFonts.subtext.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down, size: 24),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CommonContainer(
                          borderColor: const Color(0xff667EFA).withAlpha(33),
                          color: const Color(0xff667EFA).withAlpha(5),
                          textColor: const Color(0xff384EC1),
                          data: "Second Opinion",
                          data1: "17",
                          icon: const Icon(Icons.expand_less, color: Colors.green),
                          data2Color: Colors.green,
                          data2: "+2%",
                          data3: "vs last Period",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CommonContainer(
                          borderColor: const Color(0xffFF8A65).withAlpha(48),
                          color: const Color(0xffFF8A65).withAlpha(10),
                          textColor: const Color(0xffB93106),
                          data: "Total Consults",
                          data1: "3",
                          image: Image.asset("assets/images/double.png"),
                          data2: "0%",
                          data2Color: const Color(0xff39393A),
                          data3: "vs last period",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CommonContainer(
                          borderColor: const Color(0xffC5EFC8),
                          color: const Color(0xffF1FFF2),
                          textColor: const Color(0xff146B1A),
                          data: "Total Revenue",
                          data1: "\$150.31",
                          icon: const Icon(Icons.arrow_upward_outlined, color: Colors.green),
                          data2Color: Colors.green,
                          data2: "+2%",
                          data3: "vs last period",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CommonContainer(
                          borderColor: const Color(0xffCCCDCD),
                          color: const Color(0xffF4F5F7),
                          textColor: const Color(0xff404040).withAlpha(48),
                          data: "Next Payout",
                          data1: "\$80.00",
                          data2Color: const Color(0xff94989B),
                          data2: "Due:",
                          data3: "Oct 10",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        } else if (state is HomePageError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${state.message}", style: AppFonts.textprimary),
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
