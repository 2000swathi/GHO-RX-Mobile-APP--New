import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool istrue;
  final bool? isHome;
  final Widget? widgets;
  final double height;
  final PreferredSizeWidget? tabBar;
  final bool? isLogout;

  const CaseAppBar({
    super.key,
    this.title,
    this.istrue = false,
    this.isHome = false,
    this.widgets,
    this.height = 70,
    this.tabBar,
    this.isLogout = false,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (tabBar?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      title:
          isHome == true
              ? widgets
              : Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(title ?? '', style: AppFonts.heading),
              ),
      bottom: tabBar,
      actions:
          istrue
              ? []
              : isLogout == true
              ? [
                InkWell(
                  onTap: () async {
                    final confirmed = await showDeleteConfirmationDialog(
                      context: context,
                      title: "Logout App",
                      content: "Are you sure want to logout?",
                      deleteText: "Yes"
                    );
                    if(confirmed==true){
                      CustomScaffoldMessenger.showSuccessMessage(context, "Logout your Account");
                    }
                    else{
                      CustomScaffoldMessenger.showErrorMessage(context, "Logout Failed");
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primarycolor.withAlpha(8),
                    child: Icon(Icons.logout, color: AppColors.primarycolor),
                  ),
                ),
                const SizedBox(width: 15),
              ]
              : [
                CircleAvatar(
                  backgroundColor: AppColors.primarycolor.withAlpha(8),
                  child: SvgPicture.asset("assets/svg/email_svg.svg"),
                ),
                const SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: AppColors.primarycolor.withAlpha(8),
                  child: SvgPicture.asset("assets/svg/notification_svg.svg"),
                ),
                const SizedBox(width: 15),
              ],
    );
  }
}
