import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/bloc/profile_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/accreditation_model.dart';

class AddEditAccrediationBottomSheet {
  static void showSheet(
    BuildContext context,
    AccreditationData? info, 
    bool isEdit,
  ) {
    final _formKey = GlobalKey<FormState>();

    final accTypeController = TextEditingController(
      text: isEdit ? info?.accreditationType ?? '' : '',
    );
    final accBodyController = TextEditingController(
      text: isEdit ? info?.accreditationBody ?? '' : '',
    );
    final accNumController = TextEditingController(
      text: isEdit ? info?.accreditationNumber ?? '' : '',
    );

    CustomBottomSheet.show(
      context: context,
      heading: isEdit ? "Edit Accreditation" : "Add Accreditation",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: accNumController,
                name: "Accreditation Number",
                hintText: "Enter Accreditation Number",
                validator: Validation.validateAccreditationNumber,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: accTypeController,
                name: "Accreditation Type",
                hintText: "Enter Accreditation Type",
                validator: Validation.validateProviderName,
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
        ),
      ],

   
      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(FetchAccreditation());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message ?? "Added Successfully")),
                );
              } else if (state is AddError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message ?? "Failed to add")),
                );
              }
            },
          ),
          BlocListener<EditBloc, EditState>(
            listener: (context, state) {
              if (state is EditSuccess) {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(FetchAccreditation());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is EditFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
        ],

        child: BlocBuilder<AddBloc, AddState>(
          builder: (context, addState) {
            return CustomButton(
              text: isEdit ? "Update Accreditation" : "Add Accreditation",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isEdit) {
                    context.read<EditBloc>().add(EditAcreditationEvent(
                          accreditationId: info!.id.toString(),
                          accreditationtype: accTypeController.text,
                          accreditationbody: accBodyController.text,
                          accreditationnumber: accNumController.text,
                        ));
                  } else {
                    context.read<AddBloc>().add(AddAccrediation(
                          accreditationtype: accTypeController.text,
                          accreditationbody: accBodyController.text,
                          accreditationnumber: accNumController.text,
                        ));
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
