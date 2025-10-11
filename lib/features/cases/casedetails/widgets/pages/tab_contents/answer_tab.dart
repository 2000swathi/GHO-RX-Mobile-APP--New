import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class AnswerTab extends StatelessWidget {
  const AnswerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F8),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText:
                      "Type your answer here (e.g., explanation, advice, next steps)…",
                  hintStyle: AppFonts.textprimary.copyWith(
                    color: AppColors.textPrimary.withAlpha(70),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(thickness: 1, height: 1, color: AppColors.hint2color),

          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 4),
                _toolbarIcon(Icons.format_bold),
                _toolbarIcon(Icons.format_italic),
                _toolbarIcon(Icons.format_underline),
                _toolbarIcon(Icons.format_align_center),
                _toolbarIcon(Icons.format_list_bulleted),
                const Spacer(),
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.hint2color,
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: AppFonts.textprimary.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbarIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.grey[600],
          size: 22,
        ),
        splashRadius: 20,
      ),
    );
  }
}
