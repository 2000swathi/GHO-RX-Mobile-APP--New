import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/accreditation_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class AccreditationScreen extends StatelessWidget {
  AccreditationScreen({super.key});

  List<Map<String, dynamic>> accreditationData = [
    {
      "accreNum": "TN0217893",
      "accreType": "NABH Hospital Accreditation",
      "accreBody": "ABCD",
    },
    {
      "accreNum": "TN0217893",
      "accreType": "NABH Hospital Accreditation",
      "accreBody": "ABCD",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Accreditation",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(
        onAdd: () {}
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: accreditationData.length,
          itemBuilder: (context, index) {
            final accreditation = accreditationData[index];
            
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: AccreditationCard(
                index: index + 1, 
                accreNum: accreditation["accreNum"]!, 
                accreType: accreditation["accreType"]!, 
                accreBody: accreditation["accreBody"]!, 
                onEdit: () {},
                onDelete: () {},
              )
            );
          }
        ),
      )
    );
  }
}