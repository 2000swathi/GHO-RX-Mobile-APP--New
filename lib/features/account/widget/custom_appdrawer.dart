import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/router/app_router.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/draweritem_tile.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, size: 24),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Profile Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Manage your account details",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  DrawerItemTile(
                    imagePath: "assets/svg/account/user.png",
                    title: "Personal Information",
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.personalinformation,
                      );
                    },
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/translation.png",
                    title: "Languages",
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.languagescreen);
                    },
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/accredited 1.png",
                    title: "Accreditations",
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/graduation-hat.png",
                    title: "Education",
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/refer.png",
                    title: "Professional References",
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/agreement.png",
                    title: "Licenses",
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/health-insurance.png",
                    title: "Professional Indemnity Insurance",
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/folders.png",
                    title: "Documents",
                  ),
                  DrawerItemTile(
                    imagePath: "assets/svg/account/question-mark.png",
                    title: "Questionnaire",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
