import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_appdrawer.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/group_container.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/single_container.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
            Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.glasscontainer,
                        radius: 47,
                      ),

                      Positioned(
                        right: 0,
                        bottom: 0,
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
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text("data", style: AppFonts.heading),
                Text("data", style: AppFonts.textSecondary),
              ],
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
                              Scaffold.of(
                                context,
                              ).openDrawer(); 
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
                        onTap: () {},
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
