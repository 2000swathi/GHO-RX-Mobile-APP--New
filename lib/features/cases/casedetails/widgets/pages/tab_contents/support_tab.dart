import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class SupportTab extends StatelessWidget {
  const SupportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, 
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_italic),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_underline),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_list_bulleted),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_list_bulleted),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
