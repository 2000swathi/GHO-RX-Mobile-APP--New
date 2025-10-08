import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool istrue;

  const CaseAppBar({super.key, required this.title, this.istrue = false});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title, style: AppFonts.heading),
      actions:
          istrue == true
              ? []
              : [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.email, color: AppColors.primarycolor),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: AppColors.primarycolor,
                  ),
                ),
              ],
    );
  }
}
