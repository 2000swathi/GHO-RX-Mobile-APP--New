import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class SupportTabScreen extends StatelessWidget {
  const SupportTabScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20, 
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: const SupportTab(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
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
              const Divider(
                thickness: 1,
                height: 1,
                color: AppColors.hint2color,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F5F8),
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
                    Container(
                      width: 1,
                      height: 24,
                      color: AppColors.hint2color,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Save",
                         style: AppFonts.textblue.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _toolbarIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: Colors.grey[600], size: 22),
        splashRadius: 20,
      ),
    );
  }
}
