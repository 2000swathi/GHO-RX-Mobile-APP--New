import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class CustomAccountAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onEdit;
  final VoidCallback? onAdd;

  const CustomAccountAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onEdit,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 24, color: AppColors.black),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),

      title: Text(
        title,
        style: AppFonts.heading.copyWith(fontWeight: FontWeight.w500),
      ),

      actions: [
        // EDIT BUTTON
        if (onEdit != null)
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: InkWell(
              onTap: onEdit,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/account/pencil.svg",
                      height: 20,
                    ),
                    const SizedBox(width: 6),
                    Text("Edit", style: AppFonts.textblue),
                  ],
                ),
              ),
            ),
          ),

        // ADD ICON
        if (onAdd != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    Icon(Icons.add, color: AppColors.primarycolor),
                    const SizedBox(width: 6),
                    Text("Add", style: AppFonts.textblue),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
