import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/bankinfo_model.dart';

class AddEditBankInfoBottonSheet {
  static void showSheet(
    BuildContext context,
    BankInfoResponseModel? info,
    bool? isEdit,
  ) {
    final bool editing = isEdit == true && info != null;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController bankTypeController = TextEditingController(
      text: editing ? info.data[0].accountType : "",
    );
    final TextEditingController routingNumberController = TextEditingController(
      text: editing ? info.data[0].routingNumber : "",
    );
    final TextEditingController accountNumberController = TextEditingController(
      text: editing ? info.data[0].accountNumber : "",
    );
    final TextEditingController accountNameController = TextEditingController(
      text: editing ? info.data[0].accountHolderName : "",
    );
    // void dispose(){
    //   bankTypeController.dispose();
    // }
    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit Bank Information" : "Add Bank Information",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: bankTypeController,
                name: "Bank Type",
                hintText: "Enter Bank Type",
                validator:
                    (value) =>
                        Validation.field(value, fieldName: "Account type"),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: routingNumberController,
                name: "Routing Number",
                hintText: "Enter Routing Number",
                validator: Validation.validateRoutigNumber,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: accountNumberController,
                name: "Account Number",
                hintText: "Enter Account Number",
                validator: Validation.validateAccountNumber,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: accountNameController,
                name: "Account Name",
                hintText: "Enter Account Name",
                validator:
                    (value) =>
                        Validation.field(value, fieldName: "Account Name"),
              ),
            ],
          ),
        ),
      ],
      actionButton: CustomButton(
        text: editing ? "Update Bank Information" : "Add Bank Information",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final String accountType = bankTypeController.text.trim();
            final String accountNumber = accountNumberController.text.trim();
            final String routingNumber = routingNumberController.text.trim();
          }
        },
      ),
    );
  }
}
