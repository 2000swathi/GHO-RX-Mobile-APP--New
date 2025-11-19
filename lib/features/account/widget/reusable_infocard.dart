import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final List<Map<String, String>> fields;

  const InfoCard({
    super.key,
    required this.title,
    required this.fields,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppFonts.hinttext2.copyWith(fontSize: 14)),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/account/pencil.svg",
                            height: 20,
                          ),
                          const SizedBox(width: 6),
                          Text("Edit", style: AppFonts.textblue),
                          const SizedBox(width: 12), 
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: onDelete,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/trash.svg",
                            height: 20,
                          ),
                          const SizedBox(width: 6),
                          Text("Delete", style: AppFonts.subheading16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
        
            const SizedBox(height: 12),
        
            for (var item in fields) ...[
              Text(item["label"]!, style: AppFonts.hinttext2),
              const SizedBox(height: 3),
              Text(item["value"]!, style: AppFonts.textprimary),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}
