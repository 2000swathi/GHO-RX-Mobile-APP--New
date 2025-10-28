// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
// import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
// import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
// import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
// import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
// import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
// import 'package:ghorx_mobile_app_new/features/profile/editProfile/bloc/list_bloc.dart';
// import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/licence_authority_model.dart';
// import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
// import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
// import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
// import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';

// class AddEditLicenseSheet {
//   static void showSheet(
//     BuildContext context,
//     LicenseData? info,
//     List<LicenseListModel> licList,
//     List<Authority> licAuth,
//     bool isEdit, {
//     required ProfileBloc profileBloc,
//   }) {
//     final bool editing = isEdit == true;

//     final formKey = GlobalKey<FormState>();
//     // Prefill only when editing

//     String? selectLicenseID = isEdit ? info?.licenseTypeID.toString() : null;
//     String? selectauthorityID =
//         isEdit ? info?.issuingAuthorityID.toString() : null;
//     final TextEditingController numController = TextEditingController(
//       text: editing ? info?.licenseNumber : "",
//     );

//     final TextEditingController issueDateController = TextEditingController(
//       text: editing ? info?.issueDate : "",
//     );

//     final TextEditingController expDateController = TextEditingController(
//       text: editing ? info?.expiryDate : "",
//     );
//     final TextEditingController idController = TextEditingController(
//       text: editing ? info?.id.toString() : "",
//     );
//     final TextEditingController issuingAuthorityController =
//         TextEditingController(text: editing ? info?.issuingAuthority : "");

//     String? selectIssuingAuthority;
//     if (isEdit && info?.issuingAuthority != null) {
//       try {
//         selectIssuingAuthority =
//             licAuth
//                 .firstWhere((e) => e.issuingAuthority == info?.issuingAuthority)
//                 .issuingAuthorityID
//                 .toString();
//       } catch (e) {
//         selectIssuingAuthority = null;
//       }
//     }
//     String? selectType;
//     String? selectedLicenseType;
//     if (isEdit && info?.licenseType != null) {
//       try {
//         selectedLicenseType =
//             licList
//                 .firstWhere((e) => e.licenseTypeName == info?.licenseType)
//                 .licenseTypeID
//                 .toString();
//       } catch (e) {
//         selectedLicenseType = null;
//       }
//     }

//     CustomBottomSheet.show(
//       context: context,
//       heading: editing ? "Edit License" : "Add License",
//       content: [
//         StatefulBuilder(
//           builder: (context, setState) {
//             return Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   CustomTextFormField(
//                     controller: numController,
//                     name: "License Number",
//                     hintText: "Enter License Number",
//                     validator:
//                         (value) => Validation.field(
//                           value,
//                           fieldName: "License Number",
//                         ),
//                   ),

//                   const SizedBox(height: 10),
//                   CustomDropdownFormField<String>(
//                     name: "Issuing Authority",
//                     hintText: "-Select Authority-",

//                     validator: Validation.validateAuthority,

//                     items:
//                         licAuth
//                             .map(
//                               (e) => DropdownItem<String>(
//                                 label: e.issuingAuthority,
//                                 value: e.issuingAuthorityID.toString(),
//                               ),
//                             )
//                             .toList(),
//                     value: selectIssuingAuthority,
//                     onChanged:
//                         (id) => setState(() {
//                           selectauthorityID = id;
//                         }),
//                   ),
//                   const SizedBox(height: 10),
//                   CustomDropdownFormField<String>(
//                     name: "License Type",
//                     hintText: "-Select License-",
//                     value: selectType,
//                     validator:
//                         (value) =>
//                             Validation.field(value, fieldName: "License Type"),
//                     items:
//                         licList
//                             .map(
//                               (c) => DropdownItem<String>(
//                                 value: c.licenseTypeID.toString(),
//                                 label: c.licenseTypeName,
//                               ),
//                             )
//                             .toList(),
//                     onChanged: (id) {
//                       setState(() {
//                         selectLicenseID = id;
//                       });
//                     },
//                   ),

//                   const SizedBox(height: 10),
//                   CustomTextFormField(
//                     controller: issueDateController,
//                     name: "Issue Date",
//                     hintText: "DD Month, YYYY",
//                     // validator: Validation.validateIssueDate,
//                   ),
//                   const SizedBox(height: 10),
//                   CustomTextFormField(
//                     controller: expDateController,
//                     name: "Expiry Date",
//                     hintText: "DD Month, YYYY",
//                     // validator:
//                     //     (value) => Validation.validateExpiryDate(
//                     //       issueDateController.text,
//                     //       value,
//                     //     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//       actionButton: MultiBlocListener(
//         listeners: [
//           BlocListener<AddBloc, AddState>(
//             listener: (context, state) {
//               if (state is AddSuccess) {
//                 Navigator.pop(context);
//                 context.read<ProfileBloc>().add(FetchLicence());
//                 CustomScaffoldMessenger.showSuccessMessage(
//                   context,
//                   state.response["Data"][0][0]['msg'],
//                 );
//               } else if (state is AddError) {
//                 CustomScaffoldMessenger.showErrorMessage(
//                   context,
//                   state.message,
//                 );
//               }
//             },
//           ),
//           BlocListener<EditBloc, EditState>(
//             listener: (context, state) {
//               if (state is EditSuccess) {
//                 Navigator.pop(context);
//                 context.read<ProfileBloc>().add(FetchLicence());
//                 CustomScaffoldMessenger.showSuccessMessage(
//                   context,
//                   state.message ?? "Edited Successfully",
//                 );
//               } else if (state is EditFailure) {
//                 CustomScaffoldMessenger.showErrorMessage(
//                   context,
//                   state.error ?? "Failed to edit",
//                 );
//               }
//             },
//           ),
//         ],
//         child: BlocBuilder<AddBloc, AddState>(
//           builder: (context, addState) {
//             final isAddLoading = addState is AddLoading;

//             return BlocBuilder<EditBloc, EditState>(
//               builder: (context, editState) {
//                 final isEditLoading = editState is EditLoading;
//                 final isLoading = isAddLoading || isEditLoading;
//                 return CustomButton(
//                   text:
//                       isEdit
//                           ? (isLoading ? "Updating..." : "Update License")
//                           : (isLoading ? "Adding..." : "Add License"),
//                   isLoading: isLoading,
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       if (isEdit) {
//                         String issuingAuthorityName = '';
//                         if (selectIssuingAuthority != null) {
//                           try {
//                             selectIssuingAuthority =
//                                 licAuth
//                                     .firstWhere(
//                                       (b) =>
//                                           b.issuingAuthorityID.toString() ==
//                                           selectIssuingAuthority,
//                                     )
//                                     .issuingAuthority;
//                           } catch (e) {
//                             // Handle case where ID is not found, though unlikely if dropdown is populated correctly
//                           }
//                         }
//                         context.read<EditBloc>().add(
//                           EditLicenseEvent(
//                             licenseNumber: numController.text,
//                             licenseType: int.parse(selectLicenseID.toString()),
//                             issuingAuthority: int.parse(
//                               selectauthorityID.toString(),
//                             ),
//                             issueDate: issueDateController.text,
//                             expiryDate: expDateController.text,
//                             id: idController.text,
//                           ),
//                         );
//                       } else {
//                         context.read<AddBloc>().add(
//                           AddLicense(
//                             licenseNumber: numController.text,
//                             licenseType: int.parse(selectLicenseID.toString()),
//                             issuingAuthority: int.parse(
//                               selectauthorityID.toString(),
//                             ),
//                             issueDate: issueDateController.text,
//                             expiryDate: expDateController.text,
//                           ),
//                         );
//                       }
//                     }
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    bool isEdit, {
    required ProfileBloc profileBloc,
  }) {
    final bool editing = isEdit == true;
    final formKey = GlobalKey<FormState>();

    // Prefill controllers if editing
    String? selectLicenseID = editing ? info.licenseTypeID.toString() : null;
    String? selectAuthorityID =
        editing ? info.data[0].issuingAuthority.toString() : null;

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

    // Handle preselected dropdowns
    String? selectIssuingAuthority;
    if (editing) {
      try {
        selectIssuingAuthority =
            licAuth
                .firstWhere(
                  (e) => e.issuingAuthority == licAuth[0].issuingAuthority,
                )
                .issuingAuthorityID
                .toString();
      } catch (e) {
        selectIssuingAuthority = null;
      }
    }

    String? selectLicenseType;
    if (editing) {
      try {
        selectLicenseType =
            licList
                .firstWhere(
                  (e) => e.licenseTypeName == licList[0].licenseTypeName,
                )
                .licenseTypeID
                .toString();
      } catch (_) {
        selectLicenseType = null;
      }
    }

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
                    value: selectIssuingAuthority,
                    onChanged:
                        (id) => setState(() {
                          selectAuthorityID = id;
                        }),
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownFormField<String>(
                    name: "License Type",
                    hintText: "-Select License-",
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
                    value: selectLicenseType,
                    onChanged:
                        (id) => setState(() {
                          selectLicenseID = id;
                        }),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: issueDateController,
                    name: "Issue Date",
                    hintText: "DD Month, YYYY",
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: expDateController,
                    name: "Expiry Date",
                    hintText: "DD Month, YYYY",
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ],
      // actionButton: MultiBlocListener(
      //   listeners: [
      //     /// ✅ Handle AddBloc messages
      //     BlocListener<AddBloc, AddState>(
      //       listener: (context, state) {
      //         if (state is AddSuccess) {
      //           Navigator.pop(context);
      //           context.read<ProfileBloc>().add(FetchLicence());
      //           CustomScaffoldMessenger.showSuccessMessage(
      //             context,
      //             state.response["Data"][0][0] ?? "License added successfully",
      //           );
      //         } else if (state is AddError) {
      //           CustomScaffoldMessenger.showErrorMessage(
      //             context,
      //             state.message ?? "Failed to add license",
      //           );
      //         }
      //       },
      //     ),

      //     /// ✅ Handle EditBloc messages
      //     BlocListener<EditBloc, EditState>(
      //       listener: (context, state) {
      //         if (state is EditSuccess) {
      //           Navigator.pop(context);
      //           context.read<ProfileBloc>().add(FetchLicence());
      //           CustomScaffoldMessenger.showSuccessMessage(
      //             context,
      //             state.message ?? "License updated successfully",
      //           );
      //         } else if (state is EditFailure) {
      //           CustomScaffoldMessenger.showErrorMessage(
      //             context,
      //             state.error ?? "Failed to update license",
      //           );
      //         }
      //       },
      //     ),
      //   ],
      //   child: BlocBuilder<AddBloc, AddState>(
      //     builder: (context, addState) {
      //       final isAddLoading = addState is AddLoading;

      //       return BlocBuilder<EditBloc, EditState>(
      //         builder: (context, editState) {
      //           final isEditLoading = editState is EditLoading;
      //           final isLoading = isAddLoading || isEditLoading;

      //           return CustomButton(
      //             text:
      //                 editing
      //                     ? (isLoading ? "Updating..." : "Update License")
      //                     : (isLoading ? "Adding..." : "Add License"),
      //             isLoading: isLoading,
      //             onPressed: () {
      //               if (!formKey.currentState!.validate()) return;

      //               if (editing) {
      //                 context.read<EditBloc>().add(
      //                   EditLicenseEvent(
      //                     licenseNumber: numController.text,
      //                     licenseType: int.parse(selectLicenseID.toString()),
      //                     issuingAuthority: int.parse(
      //                       selectAuthorityID.toString(),
      //                     ),
      //                     issueDate: issueDateController.text,
      //                     expiryDate: expDateController.text,
      //                     id: idController.text,
      //                   ),
      //                 );
      //               } else {
      //                 context.read<AddBloc>().add(
      //                   AddLicense(
      //                     licenseNumber: numController.text,
      //                     licenseType: int.parse(selectLicenseID.toString()),
      //                     issuingAuthority: int.parse(
      //                       selectAuthorityID.toString(),
      //                     ),
      //                     issueDate: issueDateController.text,
      //                     expiryDate: expDateController.text,
      //                   ),
      //                 );
      //               }
      //             },
      //           );
      //         },
      //       );
      //     },
      //   ),
      // ),
      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                profileBloc.add(FetchLicence());
                CustomScaffoldMessenger.showSuccessMessage(context, "success");
              } else if (state is AddError) {
                print(" ${state.message}");
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
                final isEditLoading = editState is EditLoading;
                final isLoading = isAddLoading || isEditLoading;

                return CustomButton(
                  text: isEdit ? "Edit License" : "Add License",

                  isLoading: isLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (isEdit) {
                        context.read<EditBloc>().add(
                          EditLicenseEvent(
                            licenseNumber: numController.text,
                            issuingAuthority: selectAuthorityID.toString(),
                            licenseType: selectLicenseID.toString(),
                            issueDate: issueDateController.text,
                            expiryDate: expDateController.text,
                            id: idController.text,
                          ),
                        );
                      } else {
                        context.read<AddBloc>().add(
                          AddLicense(
                            licenseNumber: numController.text,
                            issuingAuthority: int.parse(
                              selectAuthorityID.toString(),
                            ),
                            licenseType: int.parse(selectLicenseID.toString()),
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
