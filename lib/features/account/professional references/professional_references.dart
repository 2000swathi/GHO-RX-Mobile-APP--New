import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/professionalreff_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class ProfessionalReferencesScreen extends StatelessWidget {
  ProfessionalReferencesScreen({super.key});

  final List<Map<String, dynamic>> referenceData = [
    {
      "fullnameRefe": "Marco",
      "designationRefe": "Surgeon",
      "accountType": "ABCD",
      "emailRefe": "abcd@gmail.com",
      "departRefe": "abcd@gmail.com",
    },
    {
      "fullnameRefe": "Marco",
      "designationRefe": "Surgeon",
       "accountType": "ABCD",
      "departRefe": "ABCD",
      "emailRefe": "abcd@gmail.com",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(title: "Professional References"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(onAdd: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: referenceData.length,
          itemBuilder: (context, index) {
            final reference = referenceData[index];

            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: ProfessionalRefeCard(
                index: index + 1,
                fullnameRefe: reference["fullnameRefe"],
                designationRefe: reference["designationRefe"],
                departRefe: reference["departRefe"],
                emailRefe: reference["emailRefe"],
                onEdit: () {},
                onDelete: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
