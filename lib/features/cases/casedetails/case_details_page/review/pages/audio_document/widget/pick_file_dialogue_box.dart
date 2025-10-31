import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class PickFileDialogueBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const PickFileDialogueBox({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(238, 241, 244, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: AppColors.primarycolor),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppFonts.textprimary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
