import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';

class AddEditLicenseSheet {
  static void showSheet(
    BuildContext context,
    LicenseModel info,
    List<LicenseList> licList,
    bool? isEdit,
  ) {
    final bool editing = isEdit == true && info.data.isNotEmpty;

    final _formKey = GlobalKey<FormState>();
    // Prefill only when editing
    final TextEditingController NumController = TextEditingController(
      text: editing ? info.data[0].licenseNumber : "",
    );

    final TextEditingController issueDateController = TextEditingController(
      text: editing ? info.data[0].issueDate : "",
    );

    final TextEditingController expDateController = TextEditingController(
      text: editing ? info.data[0].expiryDate : "",
    );

    final TextEditingController licenseTypeController = TextEditingController(
      text: editing ? info.data[0].licenseType : "",
    );

    String? selectedLicenseTypeID =
        editing ? info.data[0].licenseTypeID.toString() : null;

    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit License" : "Add License",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: NumController,
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
                    validator: Validation.validateDate,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: expDateController,
                    name: "Expiry Date",
                    hintText: "DD Month, YYYY",
                    validator: Validation.validateDate,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: BlocListener<AddBloc, AddState>(
        listener: (context, state) {
          if (state is AddLicenseInfoState) {
            context.read<ProfileBloc>().add(FetchLicence());
            Navigator.of(context).pop();
          } else if (state is AddError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<AddBloc, AddState>(
          builder: (context, state) {
            return CustomButton(
              text:
                  state is AddLoading
                      ? "Saving..."
                      : (isEdit == true ? "Edit License" : "Add License"),
              onPressed: () {
                if (state is AddLoading) return;

                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  context.read<AddBloc>().add(
                    AddLicense(
                      licenseNumber: NumController.text,
                      licenseType: licenseTypeController.text,
                      issueDate: issueDateController.text,
                      expiryDate: expDateController.text,
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
