import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class LifestyleWidget extends StatelessWidget {
  final Map<String, String> lifestyleData;

  const LifestyleWidget({super.key, required this.lifestyleData});

  @override
  Widget build(BuildContext context) {
    if (lifestyleData.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lifestyle",
            style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          Column(
            children:
                lifestyleData.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        /// 🔹 TITLE
                        Expanded(
                          flex: 2,
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        /// 🔹 VALUE
                        Expanded(
                          flex: 2,
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
