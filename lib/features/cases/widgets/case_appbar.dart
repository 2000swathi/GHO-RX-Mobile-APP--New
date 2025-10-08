import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title, style: AppFonts.heading),
        actions:
            istrue == true
                ? []
                : [
                  CircleAvatar(
                    backgroundColor: AppColors.primarycolor.withAlpha(8),
                    child: SvgPicture.asset("assets/svg/email_svg.svg"),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    backgroundColor: AppColors.primarycolor.withAlpha(8),
                    child: SvgPicture.asset("assets/svg/notification_svg.svg"),
                  ),
                  SizedBox(width: 15),
                ],
      ),
    );
  }
}
