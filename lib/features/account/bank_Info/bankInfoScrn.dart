import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/bankInfocard.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class Bankinfoscrn extends StatelessWidget {
  Bankinfoscrn({super.key});
  final List<Map<String, dynamic>> bankInfodata = [
    {
      "bankName": "Canara Bank",
      "accounName": "Marco",
      "accountType": "Savings",
      "accountNumber": "3322114215236",
    },
    {
      "bankName": "Canara Bank",
      "accounName": "Marco",
      "accountType": "Savings",
      "accountNumber": "3322114215236",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(title: "Bank Information"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(onAdd: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: bankInfodata.length,
          itemBuilder: (context, index) {
            final info = bankInfodata[index];

            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Bankinfocard(
                index: index,
                bankName: info["bankName"],
                accounName: info["accounName"],
                accountType: info["accountType"],
                accountNumber: info["accountNumber"],
              ),
            );
          },
        ),
      ),
    );
  }
}
