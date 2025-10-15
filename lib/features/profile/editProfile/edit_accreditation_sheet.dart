import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/accreditation_model.dart';

class AddEditAccrediationBottomSheet {
  static void showSheet(
    BuildContext context,
    AccreditationModel info,
    bool isEdit,
  ) {
    final TextEditingController revIDController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].reviewerId.toString()
              : "",
    );
    final TextEditingController accTypeController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].accreditationType
              : "",
    );
    final TextEditingController accBodyController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].accreditationBody
              : "",
    );
    final TextEditingController accNumController = TextEditingController(
      text:
          isEdit && info != null && info.data.isNotEmpty
              ? info.data[0].accreditationNumber
              : "",
    );
    final _formKey = GlobalKey<FormState>();


    CustomBottomSheet.show(
      context: context,
      heading: isEdit == true ? "Edit Accrediation" : "Add Accrediation",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: revIDController,
                name: "Reviewer ID",
                hintText: "Enter Reviwer ID",
                validator: Validation.validateID,
              ),
          
              SizedBox(height: 10),
              CustomTextFormField(
                controller: accTypeController,
                name: "Accrediation Type",
                hintText: "Enter Accrediation Type",
                validator: Validation.validateProviderName,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: accBodyController,
                name: "Accrediation body",
                hintText: "----",
                validator: Validation.validateProviderName,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: accNumController,
                name: "Accrediation Number",
                hintText: "Accrediation Number",
                validator: Validation.validateAccreditationNumber,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
      actionButton: CustomButton(
        text: isEdit == true ? "Submit Request" : "Add Accrediation",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
