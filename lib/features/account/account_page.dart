import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_event.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_appdrawer.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/group_container.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/single_container.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';
import 'package:ghorx_mobile_app_new/features/home/widget/profile_pic_dialogue.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    context.read<PicBloc>().add(FetchPicEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CustomAppDrawer(),
      ),
      drawerEnableOpenDragGesture: false,
      appBar: CaseAppBar(title: "Account", color: AppColors.backgroundcolor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<PicBloc, PicState>(
              builder: (context, state) {
                if (state is PicLoading) {
                  return LoadingAnimation();
                } else if (state is PicFailure) {
                  return SizedBox();
                } else if (state is PicSuccess) {
                  final data = state.response["Data"];

                  if (data == null ||
                      data.isEmpty ||
                      data[0] == null ||
                      data[0].isEmpty) {
                    return SizedBox();
                  }

                  final info = data[0][0];
                  return Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 110,
                          width: 110,
                          child: Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 47,
                                  backgroundColor: AppColors.primarycolor
                                      .withAlpha(13),
                                  child:
                                      info["_Url"] != null &&
                                              info["_Url"].isNotEmpty
                                          ? ClipOval(
                                            child: Image.network(
                                              info["_Url"],
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                              loadingBuilder: (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null)
                                                  return child;

                                                return Center(
                                                  child: SizedBox(
                                                    height: 15,
                                                    width: 15,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                            Color
                                                          >(
                                                            AppColors
                                                                .primarycolor,
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

                              // Edit Icon
                              Positioned(
                                right: 4,
                                bottom: 4,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) =>
                                              ProfileDialog(url: info["_Url"]),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppColors.white,
                                    child: SvgPicture.asset(
                                      "assets/svg/account/edit.svg",
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(info["FullName"], style: AppFonts.heading),
                      Text(info["email"], style: AppFonts.textSecondary),
                    ],
                  );
                }
                return Text("invalid State");
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 49),
                  Text(
                    "Manage Account",
                    style: AppFonts.header_5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      return SettingsGroupContainer(
                        children: [
                          SettingRow(
                            title: "Profile Information",
                            subTitle: "Manage your account details",
                            svgPath: "assets/svg/account/accperson.svg",
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 36),
                  Text(
                    "Security & Privacy",
                    style: AppFonts.header_5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SettingsGroupContainer(
                    children: [
                      SettingRow(
                        title: "Change Password",
                        subTitle: "Reset your password anytime for safety.",
                        svgPath: "assets/svg/account/lock.svg",
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.changePW);
                        },
                      ),
                      SettingRow(
                        title: "Privacy Policy",
                        subTitle: "Review our data protection practices.",
                        svgPath: "assets/svg/account/locky.svg",
                        onTap: () {},
                      ),
                      SettingRow(
                        title: "Microphone Access",
                        subTitle: "Allow app to use microphone.",
                        svgPath: "assets/svg/account/mic.svg",
                        // actionBtn: Switch(
                        //   value: state.pushNotification,           // toggle button
                        //   activeColor: AppColors.white,
                        //   activeTrackColor: AppColors.primarycolor,
                        //   onChanged: () {},
                        // ),
                      ),
                      SettingRow(
                        title: "Notifications",
                        subTitle: "Allow app to send alerts.",
                        svgPath: "assets/svg/account/bell.svg",
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  Text(
                    "Account Control",
                    style: AppFonts.header_5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SettingsGroupContainer(
                    children: [
                      SettingRow(
                        title: "Logout",
                        subTitle: "Sign out from your account safely.",
                        svgPath: "assets/svg/account/logout.svg",
                      ),
                      SettingRow(
                        title: "Delete Account",
                        subTitle: "Close your account permanently.",
                        svgPath: "assets/svg/account/del.svg",
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  Text(
                    "Information & Support",
                    style: AppFonts.header_5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SettingsGroupContainer(
                    children: [
                      SettingRow(
                        title: "About",
                        subTitle: "View app details.",
                        svgPath: "assets/svg/account/about.svg",
                      ),
                      SettingRow(
                        title: "Help",
                        subTitle: "Contact us via email.",
                        svgPath: "assets/svg/account/helpp.svg",
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
