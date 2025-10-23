import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/insurance_model.dart';

class AddEditInsuranceSheet {
  static void showSheet(
    BuildContext context,
    InsuranceData? info,
    bool isEdit,
    {
      required ProfileBloc profileBloc,
    }
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
      heading: isEdit ? "Edit Insurance" : "Add Insurance",
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
                hintText: "mm/dd/yyyy",
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: expDateController,
                name: "Expiry Date",
                hintText: "mm/dd/yyyy",
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
                profileBloc.add(FetchInsurance());
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
                profileBloc.add(FetchInsurance());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.message,
                );
              } else if (state is EditFailure) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.error,
                );
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
                  text: isEdit ? "Edit Insurance" : "Submit Insurance",
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
