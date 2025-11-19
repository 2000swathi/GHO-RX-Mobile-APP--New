import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/license/license_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class Licensescreen extends StatelessWidget {
  Licensescreen({super.key});

  final List<Map<String, dynamic>> licenseData = [
     {
      "licenseNumber": "TN0217893",
      "issueDate": "12-03-2020",
      "expiryDate": "12-03-2030",
      "licenseType": "Medical License",
    },
    {
      "licenseNumber": "TN0392834",
      "issueDate": "20-01-2019",
      "expiryDate": "20-01-2029",
      "licenseType": "Surgical License",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Licence",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(
        onAdd: () {}
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: licenseData.length,
          itemBuilder: (context, index) {
            final license = licenseData[index];
            
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: LicenseCard(
                index: index + 1, 
                licenseNumber: license["licenseNumber"]!,
                issueDate: license["issueDate"]!,
                expiryDate: license["expiryDate"]!,
                licenseType: license["licenseType"]!,
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