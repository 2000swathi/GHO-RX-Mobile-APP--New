import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/insurance_model.dart';

class EditInsuranceSheet {
  static void showSheet(
    BuildContext context,
    InsuranceData? info,
    bool isEdit,
  ) {
    final TextEditingController prIDController = TextEditingController(
      text: isEdit ? info?.providerID ?? '' : '',
    );
    final TextEditingController pNameController = TextEditingController(
      text: isEdit ? info?.providerName ?? '' : '',
    );
    final TextEditingController issueDateController = TextEditingController(
      text: isEdit ? info?.issueDate ?? '' : '',
    );
    final TextEditingController expDateController = TextEditingController(
      text: isEdit ? info?.expiryDate ?? '' : '',
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
                hintText: "mm/dd/yyyy",
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: expDateController,
                name: "Expiry Date",
                hintText: "mm/dd/yyyy",
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],

      actionButton: BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          return CustomButton(
            text: isEdit ? "Edit Insurance" : "Submit Insurance",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (isEdit) {
                  context.read<EditBloc>().add(
                    EditInsuranceEvent(
                      insuranceId: info!.id.toString(),
                      providerID: prIDController.text,
                      providerName: pNameController.text,
                      issueDate: issueDateController.text,
                      expiryDate: expDateController.text,
                    ),
                  );
                } else {
                  context.read<AddBloc>().add(
                    AddInsurance(
                      providerID: prIDController.text,
                      providerName: pNameController.text,
                      issueDate: issueDateController.text,
                      expiryDate: expDateController.text,
                    ),
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
