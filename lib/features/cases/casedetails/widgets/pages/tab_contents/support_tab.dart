import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class SupportTab extends StatelessWidget {
  const SupportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffF3F5F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Attach supporting files (reports, images, prescription)...",
                  style: AppFonts.textprimary.copyWith(
                    fontSize: 13,
                    color: AppColors.textPrimary.withAlpha(70),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.link_outlined, size: 30),
                splashRadius: 22,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        Container(
          height: 400,
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText:
                          "Add supporting details or clarification (e.g., extra notes, guidance)…",
                      hintStyle: AppFonts.textprimary.copyWith(
                        color: AppColors.textPrimary.withAlpha(70),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
