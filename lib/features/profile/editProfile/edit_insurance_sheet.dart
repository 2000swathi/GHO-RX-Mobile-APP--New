import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/insurance_model.dart';

class EditInsuranceSheet {
  static void showSheet(
    BuildContext context,
    InsuranceModel info,
    bool isEdit,
  ) {
    final TextEditingController prIDController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].providerID
              : "",
    );
    final TextEditingController pNameController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].providerName
              : "",
    );
    final TextEditingController issueDateController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].issueDate
              : "",
    );
    final TextEditingController expDateController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].expiryDate
              : "",
    );
    final _formKey = GlobalKey<FormState>();

    CustomBottomSheet.show(
      context: context,
      heading: "Edit Insurance",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: prIDController,
                name: "Provider ID",
                hintText: "Enter Provider ID",
                validator: Validation.validateID,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: pNameController,
                name: "Provider Name",
                hintText: "Enter Provider name",
                validator: Validation.validateProviderName,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: issueDateController,
                name: "Issue Date",
                hintText: "dd/mm/yyyy",
                validator: Validation.validateDate,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: expDateController,
                name: "Exp Date",
                hintText: "dd/mm/yyyy",
                validator: Validation.validateDate,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
      actionButton: CustomButton(
        text: "Submit Request",
        onPressed: () {
          print("clicked");
          if (_formKey.currentState!.validate()) {
            Navigator.pop(context);
            print("clicked");
          }
        },
      ),
    );
  }
}
