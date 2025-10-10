import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class SupportTabUI extends StatelessWidget {
  const SupportTabUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        height: 180, // fixed height (you can adjust)
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.offgreycolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text("Support tab content",
      
      ),
    );
  }
}