import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/custom_datepicker.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/bloc/insurance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/model/insurance_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';

class AddEditInsuranceSheet {
  static void showSheet(
    BuildContext context,
    InsuranceData? info,
    bool isEdit, {
    required InsuranceBloc insuranceBloc,
  }) {
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
      heading: isEdit ? "Edit Insurance" : "Add Insurance",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: prIDController,
                name: "Provider ID",
                hintText: "Enter Provider ID",
                validator: Validation.validateID,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: pNameController,
                name: "Provider Name",
                hintText: "Enter Provider name",
                validator: Validation.validateProviderName,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: issueDateController,
                name: "Issue Date",
                hintText: "Issue Date",
                readOnly: true,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.primarycolor,
                  size: 20,
                ),
                onTap:
                    () => showCommonDatePicker(
                      context: context,
                      controller: issueDateController,
                    ),
                validator: (value) => Validation.validateIssueDate(value),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: expDateController,
                name: "Expiry Date",
                hintText: "Expiry Date",
                readOnly: true,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.primarycolor,
                  size: 20,
                ),
                onTap:
                    () => showCommonDatePicker(
                      context: context,
                      controller: expDateController,
                    ),
                validator:
                    (value) => Validation.validateExpiryDate(
                      issueDateController.text,
                      value,
                    ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],

      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                insuranceBloc.add(FetchInsurance());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.response["Data"][0][0]['msg'],
                );
              } else if (state is AddError) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.message,
                );
              }
            },
          ),

          BlocListener<EditBloc, EditState>(
            listener: (context, state) {
              if (state is EditSuccess) {
                Navigator.pop(context);
                insuranceBloc.add(FetchInsurance());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.message,
                );
              } else if (state is EditFailure) {
                CustomScaffoldMessenger.showErrorMessage(context, state.error);
              }
            },
          ),
        ],

        child: BlocBuilder<AddBloc, AddState>(
          builder: (context, addState) {
            final bool isAddLoading = addState is AddLoading;
            return BlocBuilder<EditBloc, EditState>(
              builder: (context, editState) {
                final bool isEditLoading = editState is EditLoading;
                final bool isLoading = isAddLoading || isEditLoading;

                return CustomButton(
                  text: isEdit ? "Update Insurance" : "Submit Insurance",
                  isLoading: isLoading,
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
            );
          },
        ),
      ),
    );
  }
}
