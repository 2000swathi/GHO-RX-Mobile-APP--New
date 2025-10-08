import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/common_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/bloc/profile_state.dart';
import 'package:ghorx_mobile_app_new/utilities/size_config.dart';

import '../profile/repository/Profile_repo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = ProfileRepository();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CaseAppBar(
        isHome: true,
        widgets: Column(
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.profilepink.withAlpha(13),
                  child: SvgPicture.asset("assets/svg/person.svg"),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello", style: AppFonts.textblue),
                    BlocProvider(
                      create:
                          (_) =>
                              ProfileBloc(repository: repository)
                                ..add(FetchPersonalInfo()),
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return const Center(child: Text("loading...",style: AppFonts.labelItalic,));
                          } else if (state is PersonalInfoState) {
                            final info = state.personalInfomodel;
                            return Text(
                              "${info.firstName} ${info.lastName}",
                              style: AppFonts.subtext,
                            );
                          } else if (state is ProfileError) {
                            return Center(child: Text(state.message));
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.profilepink.withAlpha(13),
                  border: Border.all(color: Color(0xffF6E3B3), width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 16.67,
                      height: 16.67,
                      decoration: BoxDecoration(
                        color: Color(0xffFFF8E6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xff983C3C),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.priority_high,
                        color: Color(0xff983C3C),
                        size: 10,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile Verification Pending",
                            style: AppFonts.textblue.copyWith(
                              color: Color(0xff983C3C),
                            ),
                          ),

                          Text(
                            textAlign: TextAlign.left,
                            style: AppFonts.textappbar.copyWith(
                              fontFamily: 'Roboto Flex',
                              color: Color(0xffAA5757),
                            ),
                            "Your profile is currently under review by a GHO administrator.We will notify you when it is approved.",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

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
                            "7D",
                            style: AppFonts.subtext.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, size: 24),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: CommonContainer(
                      borderColor: Color(0xff667EFA).withAlpha(33),
                      color: Color(0xff667EFA).withAlpha(5),
                      textColor: Color(0xff384EC1),

                      data: "Second Opinion",
                      data1: "17",
                      icon: Icon(Icons.expand_less, color: Colors.green),
                      data2Color: Colors.green,
                      data2: "+2%",
                      data3: "vs last Period",
                    ),
                  ),
                  SizedBox(width: 12),

                  Expanded(
                    child: CommonContainer(
                      borderColor: Color(0xffFF8A65).withAlpha(48),
                      color: Color(0xffFF8A65).withAlpha(10),
                      textColor: Color(0xffB93106),
                      data: "Total Consults",
                      data1: "3",
                      image: Image.asset("assets/images/double.png"),
                      data2: "0%",
                      data2Color: Color(0xff39393A),
                      data3: "vs last period",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CommonContainer(
                      borderColor: Color(0xffC5EFC8),
                      color: Color(0xffF1FFF2),
                      textColor: Color(0xff146B1A),
                      data: "Total Revenue",
                      data1: "\$150.31",
                      icon: Icon(
                        Icons.arrow_upward_outlined,
                        color: Colors.green,
                      ),
                      data2Color: Colors.green,
                      data2: "+2%",
                      data3: "vs last period",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CommonContainer(
                      borderColor: Color(0xffCCCDCD),
                      color: Color(0xffF4F5F7),
                      textColor: Color(0xff404040).withAlpha(48),
                      data: "Next Payout",
                      data1: "\$80.00",
                      data2Color: Color(0xff94989B),
                      data2: "Due:",
                      data3: "Oct 10",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Second Opinion Request",
                    style: AppFonts.subheading.copyWith(fontSize: 16),
                  ),

                  Text(
                    "See All",
                    style: AppFonts.subheading.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F8FF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff667EFA).withAlpha(75),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Color(0xff667EFA).withAlpha(80),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Case Identifier", style: AppFonts.subtext),
                            Text(
                              "Allotted Time: 5hrs",
                              style: AppFonts.subtext,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Padding(padding: EdgeInsets.only(right: .12)),
                            Text(
                              "GHO-2024-9481",
                              style: AppFonts.subheading.copyWith(fontSize: 16),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Due Date:",
                                    style: AppFonts.subtext,
                                  ),
                                  TextSpan(
                                    text: "Oct 9,2024",
                                    style: AppFonts.subtext,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Color(0xff667EFA).withAlpha(15)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "34-year-old female presenting with acute chest pain, radiating to left arm. Requesting urgent cardiologist opinion. ",
                          style: AppFonts.textprimary.copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.all(2)),
                          Expanded(
                            child: CustomButton(
                              text: "Accept Case",
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomButton(
                              text: "Deny",
                              color: AppColors.primarycolor.withAlpha(15),
                              colortext: AppColors.primarycolor,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
