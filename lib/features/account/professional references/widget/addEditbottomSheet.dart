import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/referenceListResponse.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/bloc/professionalref_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/model/professionaleref_model.dart';

class AddProfessionalRefBottomSheet {
  static void showSheet(
    BuildContext context,
    ReferenceModel? info,
    bool isEdit, {
    required ProfessionalrefBloc profRefBloc,
    required List<List<ReferenceData>> relationList,
  }) {
    final flattenedList = relationList.expand((e) => e).toList();
    final _formKey = GlobalKey<FormState>();

    String? relationID = isEdit ? info?.relationship : null;

    // Controllers
    final nameController = TextEditingController();
    final designationController = TextEditingController();
    final phoneController = TextEditingController();
    final relationShipController = TextEditingController();
    final otherRelationController = TextEditingController();

    /// Prefill when editing
    if (isEdit && info != null) {
      nameController.text = info.fullName;
      designationController.text = info.designation;
      phoneController.text = info.phone;
      relationShipController.text = info.relationship;
    }

    CustomBottomSheet.show(
      context: context,
      heading:
          isEdit ? "Edit Professional Reference" : "Add Professional Reference",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: nameController,
                    name: "Full Name",
                    hintText: "Enter full name",
                    validator: Validation.validateProviderName,
                  ),
                  const SizedBox(height: 20),

                  CustomTextFormField(
                    controller: designationController,
                    name: "Designation",
                    hintText: "Enter designation",
                    validator: Validation.validateProviderName,
                  ),
                  const SizedBox(height: 20),

                  CustomTextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    name: "Phone Number",
                    hintText: "Enter phone number",
                  ),
                  const SizedBox(height: 20),

                  /// ---------------------------
                  /// Relationship Dropdown + Other
                  /// ---------------------------
                  CustomDropdownFormField(
                    name: "Relationship",
                    hintText: "--Choose Your Relationship--",
                    value: relationID,
                    items:
                        flattenedList
                            .map(
                              (e) => DropdownItem(
                                value:
                                    (e.displyText.isEmpty)
                                        ? e.dataValue
                                        : e.displyText,
                                label:
                                    (e.displyText.isEmpty)
                                        ? e.dataValue
                                        : e.displyText,
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        relationID = value;

                        if (value != "Other") {
                          relationShipController.text = value ?? "";
                          otherRelationController.clear();
                        }
                      });
                    },
                  ),

                  if (relationID == "Other")
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: CustomTextFormField(
                        name: "Other",
                        hintText: "Enter your relationship",
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],

      /// -----------------------------------
      /// ACTION BUTTON (Submit)
      /// -----------------------------------
      actionButton: BlocListener<ProfessionalrefBloc, ProfessionalrefState>(
        listener: (context, state) {
          if (state is ProRefSuccess) {
            Navigator.pop(context); // close loading
            // Navigator.pop(context); // close sheet
            profRefBloc.add(FetchProfessionalref());
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
          } else if (state is ProfessionalrefError) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showErrorMessage(context, state.message);
          }
        },

        child: BlocBuilder<ProfessionalrefBloc, ProfessionalrefState>(
          builder: (context, state) {
            final bool isLoading = state is ProfessionalrefAddLoading;

            return CustomButton(
              text:
                  isEdit
                      ? "Update Professional Reference"
                      : "Add Professional Reference",
              isLoading: isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final event =
                      isEdit
                          ? EditProRef(
                            refId: info!.id.toString(),
                            fullName: nameController.text,
                            designation: designationController.text,
                            relationship: relationShipController.text,
                            phone: phoneController.text,
                          )
                          : AddProRef(
                            fullName: nameController.text,
                            designation: designationController.text,
                            relationship: relationShipController.text,
                            phone: phoneController.text,
                          );

                  profRefBloc.add(event);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
