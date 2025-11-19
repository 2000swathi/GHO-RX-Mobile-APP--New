import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/education/education_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class EducationScreen extends StatelessWidget {
  EducationScreen({super.key});

  final List<Map<String, dynamic>> educationData = [
    {
      "institute": "Sri Ramachandra Medical College & Research Institute",
      "degree": "MBBS (Bachelor of Medicine and Bachelor of Surgery)",
      "duration": "5",
      "completedyr": "2024",
      "comments": "Completed MBBS with essential clinical training.",
    },
    {
      "institute": "Sri Ramachandra Medical College & Research Institute",
      "degree": "MBBS (Bachelor of Medicine and Bachelor of Surgery)",
      "duration": "5",
      "completedyr": "2020",
      "comments": "Completed MBBS with essential clinical training.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Edcuation",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(
        onAdd: () {}
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: educationData.length,
          itemBuilder: (context, index) {
            final education = educationData[index];
            
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: EducationCard(
                index: index + 1, 
                institute: education["institute"]!, 
                degree: education["degree"]!, 
                duration: education["duration"]!, 
                year: education["completedyr"]!, 
                comments: education["comments"]!,
                onEdit: () {},
                onDelete: () {},
              ),
            );
          }
        ),
      )
    );
  }
}