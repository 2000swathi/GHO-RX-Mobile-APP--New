import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/cases/cases_pages/widgets/case_appbar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CaseAppBar(title: "Account", color: AppColors.backgroundcolor),
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
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
                SizedBox(height: 5),
                Text("data", style: AppFonts.heading),
                Text("data", style: AppFonts.textSecondary),
              ],
            ),
            ///////////////////////
            Text("Manage Account"),
          ],
        ),
      ),
    );
  }
}
