import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/licence_authority_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';

class AddEditLicenseSheet {
  static void showSheet(
    BuildContext context,
    LicenseModel info,
    List<LicenseListModel> licList,
    List<Authority> licAuth,
    bool? isEdit,
  ) {
    final bool editing = isEdit == true && info.data.isNotEmpty;

    final formKey = GlobalKey<FormState>();
    // Prefill only when editing
    final TextEditingController numController = TextEditingController(
      text: editing ? info.data[0].licenseNumber : "",
    );

    final TextEditingController issueDateController = TextEditingController(
      text: editing ? info.data[0].issueDate : "",
    );

    final TextEditingController expDateController = TextEditingController(
      text: editing ? info.data[0].expiryDate : "",
    );
    final TextEditingController idController = TextEditingController(
      text: editing ? info.data[0].id.toString() : "",
    );
    final TextEditingController issuingAuthorityController =
        TextEditingController(
          text: editing ? info.data[0].issuingAuthority : "",
        );

    String? selectedLicenseTypeID =
        editing ? info.data[0].licenseTypeID.toString() : "";

    // String? selectIssuingAuthority =
    //     editing ? info.data[0].issuingAuthority.toString() : "";
    String? selectIssuingAuthorityID =
        editing ? info.data[0].issuingAuthorityID.toString() : "";
    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit License" : "Add License",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: numController,
                    name: "License Number",
                    hintText: "Enter License Number",
                    validator:
                        (value) => Validation.field(
                          value,
                          fieldName: "License Number",
                        ),
                  ),

                  const SizedBox(height: 10),
                  CustomDropdownFormField<String>(
                    name: "Issuing Authority",
                    hintText: "-Select Authority-",

                    validator: Validation.validateAuthority,

                    items:
                        licAuth
                            .map(
                              (e) => DropdownItem<String>(
                                label: e.issuingAuthority,
                                value: e.issuingAuthorityID.toString(),
                              ),
                            )
                            .toList(),
                    value: selectIssuingAuthorityID,
                    onChanged:
                        (id) => setState(() {
                          selectIssuingAuthorityID = id;
                        }),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownFormField<String>(
                    name: "License Type",
                    hintText: "-Select License-",
                    value: selectedLicenseTypeID,
                    validator:
                        (value) =>
                            Validation.field(value, fieldName: "License Type"),
                    items:
                        licList
                            .map(
                              (c) => DropdownItem<String>(
                                value: c.licenseTypeID.toString(),
                                label: c.licenseTypeName,
                              ),
                            )
                            .toList(),
                    onChanged: (id) {
                      setState(() {
                        selectedLicenseTypeID = id;
                      });
                    },
                  ),

                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: issueDateController,
                    name: "Issue Date",
                    hintText: "DD Month, YYYY",
                    validator: Validation.validateIssueDate,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: expDateController,
                    name: "Expiry Date",
                    hintText: "DD Month, YYYY",
                    validator:
                        (value) => Validation.validateExpiryDate(
                          issueDateController.text,
                          value,
                        ),
                  ),
                  const SizedBox(height: 10),
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
                context.read<ProfileBloc>().add(FetchLicence());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.response["Data"][0][0]['msg'])),
                );
              } else if (state is AddError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<EditBloc, EditState>(
            listener: (context, state) {
              if (state is EditSuccess) {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(FetchLicence());
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is EditFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
        ],
        child: BlocBuilder<AddBloc, AddState>(
          builder: (context, state) {
            return CustomButton(
              text: isEdit == true ? "Edit License" : "Add License",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (isEdit == true && info != null) {
                    context.read<EditBloc>().add(
                      EditLicenseEvent(
                        licenseNumber: numController.text,
                        licenseType: int.parse(
                          selectedLicenseTypeID.toString(),
                        ),
                        issuingAuthority: int.parse(
                          selectIssuingAuthorityID.toString(),
                        ),
                        issueDate: issueDateController.text,
                        expiryDate: expDateController.text,
                        id: idController.text,
                      ),
                    );
                  } else {
                    context.read<AddBloc>().add(
                      AddLicense(
                        licenseNumber: numController.text,
                        licenseType: int.parse(
                          selectedLicenseTypeID.toString(),
                        ),
                        issuingAuthority: int.parse(
                          selectIssuingAuthorityID.toString(),
                        ),
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
      ),
    );
  }
}
