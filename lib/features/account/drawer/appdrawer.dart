import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/links.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/delete_account.dart/delAcc.dart';
import 'package:ghorx_mobile_app_new/features/account/drawer/help/help.dart';
import 'package:ghorx_mobile_app_new/features/account/logout/logout_scrn.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_toggleBtn.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/group_container.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/single_container.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final ValueNotifier<bool> micToggle = ValueNotifier(false);
  final ValueNotifier<bool> msgToggle = ValueNotifier(false);
  AppDrawer({super.key});
  Future<void> toggleMicrophoneSwitch(ValueNotifier<bool> micToggle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (micToggle.value) {
      // Turn OFF microphone
      micToggle.value = false;
      await prefs.setBool('isMicOn', false);
    } else {
      // Request microphone permission
      PermissionStatus status = await Permission.microphone.request();

      if (status.isGranted) {
        micToggle.value = true;
        await prefs.setBool('isMicOn', true);
      } else if (status.isPermanentlyDenied) {
        micToggle.value = true;
        await prefs.setBool('isMicOn', true);
        openAppSettings();
      } else {
        micToggle.value = false;
        await prefs.setBool('isMicOn', false);
      }
    }
  }

  Future<void> toggleNotificationSwitch(ValueNotifier<bool> msgToggle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (msgToggle.value) {
      msgToggle.value = false;
      await prefs.setBool('isNotificationOn', false);
    } else {
      PermissionStatus status = await Permission.notification.request();

      if (status.isGranted) {
        msgToggle.value = true;
        await prefs.setBool('isNotificationOn', true);
      } else if (status.isPermanentlyDenied) {
        msgToggle.value = true;
        await prefs.setBool('isNotificationOn', true);
        openAppSettings();
      } else {
        msgToggle.value = false;
        await prefs.setBool('isNotificationOn', false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button — whole row is tappable with ripple
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    Navigator.of(context).pop(); // close drawer
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_back, size: 24),
                        SizedBox(width: 8),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Text(
                    "Security & Privacy",
                    style: AppFonts.header_5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SettingsGroupContainer(
                    children: [
                      SettingRow(
                        title: "Change Password",
                        subTitle: "Reset your password anytime for safety.",
                        svgPath: "assets/svg/account/lockblack.svg",
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.changePW);
                        },
                      ),
                      SettingRow(
                        title: "Privacy Policy",
                        subTitle: "Review our data protection practices.",
                        svgPath: "assets/svg/account/locky.svg",
                        onTap: () {
                          Links().privacyPolicy();
                        },
                      ),
                      SettingRow(
                        title: "Microphone Access",
                        subTitle: "Allow app to use microphone.",
                        svgPath: "assets/svg/account/mic.svg",
                        pushBtn: CustomSwitch(
                          notifier: micToggle,
                          onToggle: () => toggleMicrophoneSwitch(micToggle),
                        ),
                      ),
                      SettingRow(
                        title: "Notifications",
                        subTitle: "Allow app to send alerts.",
                        svgPath: "assets/svg/account/bell.svg",
                        pushBtn: CustomSwitch(
                          notifier: msgToggle,
                          onToggle: () => toggleNotificationSwitch(msgToggle),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),
                  Text(
                    "Account Control",
                    style: AppFonts.header_5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SettingsGroupContainer(
                    children: [
                      SettingRow(
                        title: "Logout",
                        subTitle: "Sign out from your account safely.",
                        svgPath: "assets/svg/account/logout.svg",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const LogoutScrn(),
                          );
                        },
                      ),
                      SettingRow(
                        title: "Delete Account",
                        subTitle: "Close your account permanently.",
                        svgPath: "assets/svg/account/del.svg",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const Delacc(),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),
                  Text(
                    "Information & Support",
                    style: AppFonts.header_5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SettingsGroupContainer(
                    children: [
                      SettingRow(
                        title: "About",
                        subTitle: "View app details.",
                        svgPath: "assets/svg/account/about.svg",
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.aboutScrn);
                        },
                      ),
                      SettingRow(
                        title: "Help",
                        subTitle: "Contact us via email.",
                        svgPath: "assets/svg/account/helpp.svg",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const HelpScrn(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
