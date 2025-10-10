import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Summerypage extends StatelessWidget {
  const Summerypage({super.key});
  @override
  Widget build(BuildContext context) {
    final isExpanded = ValueNotifier<bool>(false);
    const summaryText =
        "I am a 60-year-old male experiencing slurred speech and weakness in my right arm for the past 2 hours. I consulted a doctor who mentioned it could be a possible stroke and advised immediate admission for further tests and treatment. As I am not fully convinced with the explanation and plan provided, I am seeking an urgent second opinion from a neurologist. I have attached the reports and necessary documents available with me for your review.";

    return Container(
      margin:  EdgeInsets.all(1.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.hint2color.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summery",
            style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, isExpandedValue, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    summaryText,
                    style: AppFonts.textprimary,
                    maxLines: isExpandedValue ? null : 5,
                    overflow: isExpandedValue ? null : TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => isExpanded.value = !isExpanded.value,
                    child: Text(
                      isExpandedValue ? "Read less" : "Read more...",
                      style: AppFonts.hinttext,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
