import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/custom_datepicker.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/bloc/license_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/issueing_authority.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/model/license_model.dart';

class AddEditLicenseSheet {
  static void showSheet(
    BuildContext context,
    LicenseData? info,
    List<LicenseList> licList,
    List<IssueingList> issueingList,
    bool isEdit, {
    required LicenseBloc licenseBloc,
  }) {
    final _formKey = GlobalKey<FormState>();

    String? selectedLicenceType;
    if (isEdit && info?.licenseTypeID != null) {
      selectedLicenceType =
          licList
              .firstWhere(
                (e) => e.licenseTypeID == info!.licenseTypeID,
                orElse: () => licList.first,
              )
              .licenseTypeID
              .toString();
    }

    String? selectedIssueingType;
    if (isEdit && info?.issuingAuthority != null) {
      selectedIssueingType =
          issueingList
              .firstWhere(
                (e) => e.IssueingTypeID == info!.issuingAuthority,
                orElse: () => issueingList.first,
              )
              .IssueingTypeID
              .toString();
    }

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
                    items:
                        licList
                            .map(
                              (e) => DropdownItem<String>(
                                label: e.licenseTypeName,
                                value: e.licenseTypeID.toString(),
                              ),
                            )
                            .toList(),
                    value: selectedLicenceType,
                    onChanged: (id) {
                      setState(() => selectedLicenceType = id);
                    },
                    validator: Validation.validateLicenecType,
                  ),
                  const SizedBox(height: 20),

                  CustomDropdownFormField<String>(
                    name: "Issuing Authority",
                    hintText: " -Select issuing Authority- ",
                    items:
                        issueingList
                            .map(
                              (e) => DropdownItem<String>(
                                label: e.IssueingTypeName,
                                value: e.IssueingTypeID.toString(),
                              ),
                            )
                            .toList(),
                    value: selectedIssueingType,
                    onChanged: (id) {
                      setState(() => selectedIssueingType = id);
                    },
                    validator:
                        (value) => Validation.field(
                          value,
                          fieldName: "Issuing Authority",
                        ),
                  ),
                  const SizedBox(height: 20),

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
                    validator: Validation.validateIssueDate,
                  ),
                  const SizedBox(height: 20),

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
                ],
              ),
            );
          },
        ),
      ],

      actionButton: MultiBlocListener(
        listeners: [
          /// ADD success/error
          BlocListener<LicenseBloc, LicenseState>(
            listener: (context, state) {
              if (state is LicSuccess) {
                licenseBloc.add(FetchLicense());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.message,
                );
              } else if (state is LicenseError) {
                CustomScaffoldMessenger.showErrorMessage(
                  context,
                  state.message,
                );
              }
            },
          ),

          /// EDIT success/error
          BlocListener<EditBloc, EditState>(
            listener: (context, state) {
              if (state is EditSuccess) {
                licenseBloc.add(FetchLicense());
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
            final isAddLoading = addState is AddLoading;

            return BlocBuilder<EditBloc, EditState>(
              builder: (context, editState) {
                final isEditLoading = editState is EditLoading;
                final bool isLoading = isAddLoading || isEditLoading;

                return CustomButton(
                  text: isEdit ? "Update License" : "Add License",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        context.read<LicenseBloc>().add(
                          EditLicenseEvent(
                            id: info!.id.toString(),
                            licenseType: selectedLicenceType ?? '',
                            licenseNumber: numController.text,
                            issueDate: issueDateController.text,
                            expiryDate: expDateController.text,
                            issuingAuthority: selectedIssueingType ?? '',
                          ),
                        );
                      } else {
                        context.read<LicenseBloc>().add(
                          AddLicenseEvent(
                            licenseType: selectedLicenceType ?? '',
                            licenseNumber: numController.text,
                            issueDate: issueDateController.text,
                            expiryDate: expDateController.text,
                            issuingAuthority: selectedIssueingType ?? '',
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
