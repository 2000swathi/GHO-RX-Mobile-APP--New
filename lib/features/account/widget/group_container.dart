import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class SettingsGroupContainer extends StatelessWidget {
  final List<Widget> children;

  const SettingsGroupContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: children[i],
            ),

            if (i != children.length - 1)
              Divider(
                thickness: 1,
                height: 1,
                color: AppColors.black.withOpacity(0.06),
              ),
          ],
        ],
      ),
    );
  }
}
