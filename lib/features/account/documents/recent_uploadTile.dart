import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class RecentUploadTile extends StatelessWidget {
  final String fileName;
  final String size;
  final String time;
  final IconData icon;

  const RecentUploadTile({
    super.key,
    required this.fileName,
    required this.size,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, 
          color: AppColors.primarycolor, 
          size: 32
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppFonts.subheading16
                ),
                const SizedBox(height: 4),
                Text(
                  "$size • $time",
                  style: AppFonts.hinttext2.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xffE8F9EF),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Uploaded",
              style: TextStyle(
                color: Color(0xff2ECC71),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
