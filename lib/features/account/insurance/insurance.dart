import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/insurance_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class InsuranceScreen extends StatelessWidget {
  InsuranceScreen({super.key});

  final List<Map<String, dynamic>> insuranceData = [
    {
      "providerId": "23546",
      "providerName": "ABCD",
      "issueDate": "17 Nov, 2025",
      "expiryDate": "21 Nov, 2025",
    },
    {
      "providerId": "23546",
      "providerName": "ABCD",
      "issueDate": "17 Nov, 2025",
      "expiryDate": "21 Nov, 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(
        title: "Professional Indemnity Insurance"
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(
        onAdd: () {}
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: insuranceData.length,
          itemBuilder: (context, index) {
            final insurance = insuranceData[index];
            
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: InsuranceCard(
                index: index, 
                providerId: insurance["providerId"], 
                providerName: insurance["providerName"], 
                issueDate: insurance["issueDate"], 
                expiryDate: insurance["expiryDate"], 
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