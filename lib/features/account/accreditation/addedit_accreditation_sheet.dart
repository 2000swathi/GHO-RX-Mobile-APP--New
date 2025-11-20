import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/bloc/accreditation_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/accreditationtype_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/model/accreditationsmodel.dart';

class AddEditAccreditationBottomSheet {
  static void showSheet(
    BuildContext context,
    AccreditationData? info,
    bool isEdit, {
    required AccreditationBloc accrBloc,
    required List<AccreditationTypeData> accreList,
  }) {
    final _formKey = GlobalKey<FormState>();

    // Initialize accreditation type
    String? accreTypeID;
    if (isEdit && info != null && accreList.isNotEmpty) {
      final matched = accreList.firstWhere(
        (e) => e.name == info.accreditationType,
        orElse: () => accreList.first,
      );
      accreTypeID = matched.accreditationTypeID.toString();
    }

    // Controllers
    final accBodyController = TextEditingController(text: isEdit ? info?.accreditationBody ?? '' : '');
    final accNumController = TextEditingController(text: isEdit ? info?.accreditationNumber ?? '' : '');

    // Uppercase input formatter
    final uppercaseFormatter = UpperCaseTextFormatter();

    CustomBottomSheet.show(
      context: context,
      heading: isEdit ? "Edit Accreditation" : "Add Accreditation",
      content: [
        StatefulBuilder(
          builder: (context, setState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: accNumController,
                    name: "Accreditation Number",
                    hintText: "Enter Accreditation Number",
                    validator: Validation.validateAccreditationNumber,
                  ),
                  const SizedBox(height: 20),
                  CustomDropdownFormField<String>(
                    name: "Accreditation Type",
                    hintText: " -Select Accreditation Type- ",
                    items: accreList
                        .map((e) => DropdownItem<String>(
                              label: e.name,
                              value: e.accreditationTypeID.toString(),
                            ))
                        .toList(),
                    value: accreTypeID,
                    onChanged: (id) => setState(() => accreTypeID = id),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: accBodyController,
                    inputFormatters: [uppercaseFormatter],
                    name: "Accreditation Body",
                    hintText: "Enter Accreditation Body",
                    validator: Validation.validateProviderName,
                  ),
                ],
              ),
            );
          },
        ),
      ],
      actionButton: BlocListener<AccreditationBloc, AccreditationState>(
        listener: (context, state) {
          if (state is AccSuccess) {
            Navigator.pop(context);
            accrBloc.add(FetchAccreditation());
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
          } else if (state is AccrediationError) {
            CustomScaffoldMessenger.showErrorMessage(context, state.message);
          }
        },
        child: BlocBuilder<AccreditationBloc, AccreditationState>(
          builder: (context, state) {
            final bool isLoading = state is AccrediationAddLoading || state is AccrediationeditLoading;

            return CustomButton(
              text: isEdit ? "Update Accreditation" : "Add Accreditation",
              isLoading: isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final event = isEdit
                      ? EditAcreditationEvent(
                          accreditationId: info!.id.toString(),
                          accreditationtype: accreTypeID ?? '',
                          accreditationbody: accBodyController.text,
                          accreditationnumber: accNumController.text,
                        )
                      : AddAccrediation(
                          accreditationtype: accreTypeID ?? '',
                          accreditationbody: accBodyController.text,
                          accreditationnumber: accNumController.text,
                        );
                  context.read<AccreditationBloc>().add(event);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// Uppercase input formatter
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}
