import 'package:flutter/material.dart';
import 'package:flutter/services.dart';import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';

class AddEditLicenseSheet {
  static void showSheet(
    BuildContext context,
    LicenseData? info,
    bool isEdit, {
       required ProfileBloc profileBloc,
    required List<LicenseList> licList,
  }) {
    final _formKey = GlobalKey<FormState>();
    String? licenseTypeID = isEdit
        ? licList
            .firstWhere(
              (e) => e.licenseTypeName == info?.licenseType,
              orElse: () => licList.isNotEmpty ? licList.first : LicenseList(licenseTypeID: 0, licenseTypeName: ''),
            )
            .licenseTypeID
            .toString()
        : null;

    final numController = TextEditingController(
      text: isEdit ? info?.licenseNumber ?? '' : '',
    );
    final issueDateController = TextEditingController(
      text: isEdit ? info?.issueDate ?? '' : '',
    );
    final expDateController = TextEditingController(
      text: isEdit ? info?.expiryDate ?? '' : '',
    );

    CustomBottomSheet.show(
      context: context,
      heading: isEdit ? "Edit License" : "Add License",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  /// License Number
                  CustomTextFormField(
                    controller: numController,
                    keyboardType: TextInputType.text,
                    name: "License Number",
                    hintText: "Enter License Number",
                  
                  ),
                  const SizedBox(height: 20),

               
                  CustomDropdownFormField<String>(
                    name: "License Type",
                    hintText: " -Select License Type- ",
                    items: licList
                        .map(
                          (e) => DropdownItem<String>(
                            label: e.licenseTypeName ?? 'Unknown',
                            value: e.licenseTypeID.toString(),
                          ),
                        )
                        .toList(),
                    value: licenseTypeID,
                    onChanged: (id) {
                      setState(() {
                        licenseTypeID = id;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  /// Issue Date
                  CustomTextFormField(
                    controller: issueDateController,
                    name: "Issue Date",
                    hintText: "Enter Issue Date",
                    validator: Validation.validateDate,
                  ),
                  const SizedBox(height: 20),

                  /// Expiry Date
                  CustomTextFormField(
                    controller: expDateController,
                    name: "Expiry Date",
                    hintText: "Enter Expiry Date",
                    validator: Validation.validateDate,
                  ),
                ],
              ),
            );
          },
        ),
      ],

      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                profileBloc.add(FetchLicence());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.response["Data"][0][0]['msg'] ?? "License Added Successfully",
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
                profileBloc.add(FetchLicence());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.message ?? "License Updated Successfully",
                );
              } else if (state is EditFailure) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.error ?? "Failed to update license",
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
                  text: isEdit ? "Update License" : "Add License",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        context.read<EditBloc>().add(
                              EditLicenseEvent(
                               id: info!.id.toString(),
 licenseType: int.tryParse(licenseTypeID ?? '0') ?? 0,
                                licenseNumber: numController.text,
                                issueDate: issueDateController.text,
                                expiryDate: expDateController.text,
                              ),
                            );
                      } else {
                        context.read<AddBloc>().add(
                              AddLicense(
                                licenseType:
                                    int.tryParse(licenseTypeID ?? '0') ?? 0,
                                licenseNumber: numController.text,
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
