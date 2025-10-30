import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';

class Writtenreport extends StatelessWidget {
  final VoidCallback? onNext;
  final TextEditingController controller = TextEditingController();

  Writtenreport({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.hint2color),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: controller,
                    maxLines: null, // allow multiple lines
                    expands: false, // ✅ prevent infinite layout
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText:
                          'Start typing your structured report here (e.g., Summary of Findings, Recommendations, Next Steps...)',
                      hintStyle: AppFonts.hinttext2,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Next button at bottom
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 100,
                  child: CustomButton(text: "Next", onPressed: onNext!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
