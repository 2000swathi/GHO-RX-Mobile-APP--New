import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/accreditation/bloc/accreditation_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/accreditationtype_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/accreditation/model/accreditationsmodel.dart';

class AddEditAccrediationBottomSheet {
  static void showSheet(
    BuildContext context,
    AccreditationData? info,
    bool isEdit, {
    required AccreditationBloc accrBloc,
    required List<AccreditationTypeData> accreList,
  }) {
    final _formKey = GlobalKey<FormState>();
    String? accreTypeID =
        isEdit
            ? accreList
                .firstWhere(
                  (e) => e.name == info?.accreditationType,
                  orElse: () => accreList.first,
                )
                .accreditationTypeID
                .toString()
            : null;
    final accBodyController = TextEditingController(
      text: isEdit ? info?.accreditationBody ?? '' : '',
    );
    final accNumController = TextEditingController(
      text: isEdit ? info?.accreditationNumber ?? '' : '',
    );

    accBodyController.addListener(() {
      final text = accBodyController.text;
      if (text != text.toUpperCase()) {
        accBodyController.value = accBodyController.value.copyWith(
          text: text.toUpperCase(),
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });

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
                    name: "Accrediation Type",
                    hintText: " -Select Accreditation Type- ",
                    items:
                        accreList
                            .map(
                              (e) => DropdownItem<String>(
                                label: e.name,
                                value: e.accreditationTypeID.toString(),
                              ),
                            )
                            .toList(),
                    value: accreTypeID,
                    onChanged:
                        (id) => setState(() {
                          accreTypeID = id;
                        }),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: accBodyController,
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

      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                accrBloc.add(FetchAccreditation());
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
                accrBloc.add(FetchAccreditation());
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
                  text: isEdit ? "Update Accreditation" : "Add Accreditation",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        context.read<EditBloc>().add(
                          EditAcreditationEvent(
                            accreditationId: info!.id.toString(),
                            accreditationtype: accreTypeID ?? '',
                            accreditationbody: accBodyController.text,
                            accreditationnumber: accNumController.text,
                          ),
                        );
                      } else {
                        context.read<AddBloc>().add(
                          AddAccrediation(
                            accreditationtype: accreTypeID ?? '',
                            accreditationbody: accBodyController.text,
                            accreditationnumber: accNumController.text,
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
