import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Medications extends StatelessWidget {
  Medications({super.key});

  final List<Map<String, dynamic>> medication = [
    {'title': 'Metformin', 'subtitle': '(Jun 2024)'},
    {'title': 'Gabapentin', 'subtitle': '(Jun 2024)'},
    {'title': 'Lisinopril', 'subtitle': '(Jun 2024)'},
  ];

  @override
  Widget build(BuildContext context) {
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
            "Medications",
            style: AppFonts.hinttext2.copyWith(fontWeight: FontWeight.w600),
          ),
         SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: medication.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                medication[index]['title'] as String,
                                style: AppFonts.subheading16.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                medication[index]['subtitle'] as String,
                                style: AppFonts.buttontxt16.copyWith(
                                  fontSize: 16,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
