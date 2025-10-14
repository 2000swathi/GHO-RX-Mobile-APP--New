import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/bankinfo_model.dart';

class AddEditBankInfo {
  static void showSheet(
    BuildContext context,
    BankInfoModel? info,
    bool? isEdit,
  ) {
    final bool editing = isEdit == true && info != null;

    final TextEditingController bankTypeController =
        TextEditingController(text: editing ? info.accountType : "");
    final TextEditingController routingNumberController =
        TextEditingController(text: editing ? info.routingNumber : "");
    final TextEditingController accountNumberController =
        TextEditingController(text: editing ? info.accountNumber : "");
    final TextEditingController accountNameController =
        TextEditingController(text: editing ? info.accountHolderName : "");

    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit Bank Information" : "Add Bank Information",
      content: [
        Column(
          children: [
            CustomTextFormField(
              controller: bankTypeController,
              name: "Bank Type",
              hintText: "Enter Bank Type",
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              controller: routingNumberController,
              name: "Routing Number",
              hintText: "Enter Routing Number",
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: accountNumberController,
              name: "Account Number",
              hintText: "Enter Account Number",
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: accountNameController,
              name: "Account Name",
              hintText: "Enter Account Name",
            ),
          ],
        )
      ],
      actionButton: CustomButton(
        text: editing ? "Update Bank Information" : "Add Bank Information", 
        onPressed: () {}
      )
    );
  
  }
}