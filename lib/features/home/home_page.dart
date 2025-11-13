import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/bloc/home_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_bloc.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/bloc/date_range_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/date_range_list.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/performance_snapshot.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/profile_pic_dialogue.dart';
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
          final cases = state.response["Data"][1][0];

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
                            builder: (context) => ProfileDialog(url:info["url"] ,),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: AppColors.profilepink.withAlpha(13),
                            child:
                                info["url"] != null && info["url"].isNotEmpty
                                    ? ClipOval(
                                      child: Image.network(
                                        info["url"],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          loadingProgress,
                                        ) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                         
                                          return Center(
                                            child: SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<Color>(
                                                      AppColors.profilepink,
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          // Fallback if image fails to load
                                          return SvgPicture.asset(
                                            "assets/svg/person.svg",
                                            height: 24,
                                            width: 24,
                                          );
                                        },
                                      ),
                                    )
                                    : SvgPicture.asset(
                                      "assets/svg/person.svg",
                                      height: 24,
                                      width: 24,
                                    ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello", style: AppFonts.textblue),
                          SizedBox(height: 5,),
                          Text(info["Name"], style: AppFonts.subtext),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UpcomingCase(cases: cases),
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
