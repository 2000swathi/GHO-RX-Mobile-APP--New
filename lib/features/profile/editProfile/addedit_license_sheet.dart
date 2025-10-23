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
    final TextEditingController numController = TextEditingController(
      text: editing ? info.data[0].licenseNumber : "",
    );

    // final TextEditingController idController = TextEditingController(
    //   text: editing ? info.data[0].id.toString() : "",
    // );

    final TextEditingController issueDateController = TextEditingController(
      text: editing ? info.data[0].issueDate : "",
    );

    final TextEditingController expDateController = TextEditingController(
      text: editing ? info.data[0].expiryDate : "",
    );

    String? selectedLicenseTypeID =
        editing ? info.data[0].licenseTypeID.toString() : "0";

    String? selectIssuingAuthority =
        editing ? info.data[0].issuingAuthority.toString() : "0";

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
                  // CustomDropdownFormField<String>(
                  //   name: "Issuing Authority",
                  //   hintText: "-Select Authority-",
                  //   value: selectIssuingAuthority,
                  //   validator:
                  //       (value) => Validation.field(
                  //         value,
                  //         fieldName: "Issuing Authority",
                  //       ),
                  //   items:
                  //       licList
                  //           .map(
                  //             (d) => DropdownItem<String>(
                  //               value: d.issuingAuthorityId.toString(),
                  //               label: d.issuingAuthority,
                  //             ),
                  //           )
                  //           .toList(),
                  //   // onChanged: (id) {
                  //   //   setState(() {
                  //   //     selectIssuingAuthority = id;
                  //   //   }
                  //   //   );
                  //   // },
                  // ),
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
      actionButton: BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          return BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                context.read<ListBloc>().add(FetchLicenseList());
              }
            },
            child: CustomButton(
              text: editing ? "Edit License" : "Add License",
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  //if (editing) {
                  context.read<AddBloc>().add(
                    AddLicense(
                      licenseNumber: numController.text,
                      licenseType: int.parse(selectedLicenseTypeID.toString()),
                      issuingAuthority: int.parse(
                        selectIssuingAuthority.toString(),
                      ),
                      issueDate: issueDateController.text,
                      expiryDate: expDateController.text,
                    ),
                  );
                  //  } else {
                  // context.read<EditBloc>().add(
                  //   EditLicenseEvent(
                  //     licenseNumber: numController.text,
                  //     licenseType: int.parse(selectedLicenseTypeID.toString()),
                  //     issueDate: issueDateController.text,
                  //     expiryDate: expDateController.text,
                  //     // id: id,
                  //   ),
                  // );
                }
              },
              // },
            ),
          );
        },
      ),
    );
  }
}
