import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/specialty_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class SpecialtyScreen extends StatelessWidget {
  SpecialtyScreen({super.key});

  final List<Map<String, dynamic>> specialtyData = [
    {
      "specialty": "Surgeon",
      "certifiedBoard": "NABH",
      "specialtyType": "ABCD",
    },
     {
      "specialty": "Surgeon",
      "certifiedBoard": "NABH",
      "specialtyType": "ABCD",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(
        title: "Specialty"
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(
        onAdd: () {}
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: specialtyData.length,
          itemBuilder: (context, index) {
            final specialty = specialtyData[index];
            
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: SpecialtyCard(
                index: index + 1, 
                specialty: specialty["specialty"], 
                certifiedBoard: specialty["certifiedBoard"], 
                specialtyType: specialty["specialtyType"], 
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