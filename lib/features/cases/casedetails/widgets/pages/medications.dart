import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';

class Medications extends StatelessWidget {
   Medications({super.key});
  
  final List<Map<String, dynamic>> medication =  [
    {   
      'title': 'Metformin',
      'title1': '(500mg BID)',
      'subtitle': 'Jun 2024',
    },
    {
       'title': 'Gabapentin',
      'title1': '(300mg TID)',
      'subtitle': 'Jun 2024',
    },
    {
      'title': 'Lisinopril',
      'title1': '(10mg QD)',
      'subtitle': 'Jun 2024',
    },
   
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color:AppColors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color:AppColors.hint2color.withAlpha(1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Text(
            'Medications',
            style: AppFonts.subheading16
          ),
            const SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(),
            itemCount: medication.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 5,
                          height: 50,
                       
                          decoration: const BoxDecoration(
                            color: AppColors.yellow,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.yellow.withAlpha(10),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      medication[index]['title'] as String,
                                      style: AppFonts.subheading16.copyWith(fontSize: 16),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      medication[index]['title1'] as String,
                                      style: AppFonts.subtext.copyWith(fontSize: 16, color: AppColors.red),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                medication[index]['subtitle'] as String,
                                  style: AppFonts.buttontxt16,
                                ),
                              ],
                            ),
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