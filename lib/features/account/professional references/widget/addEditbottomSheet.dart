import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/bloc/professionalref_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/model/professionaleref_model.dart';

class AddProfessionalRefBottomSheet {
  static void showSheet(
    BuildContext context,
    ReferenceModel? info, {
    required ProfessionalrefBloc profRefBloc,
  }) {
    final _formKey = GlobalKey<FormState>();

    // Controllers
    final nameController = TextEditingController();
    final designationController = TextEditingController();
    final phoneController = TextEditingController();
    final relationShipController = TextEditingController();

    CustomBottomSheet.show(
      context: context,
      heading: "Add Professional Reference",
      content: [
        Form(
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
                // validator: Validation.validatePhoneNumber,
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                controller: relationShipController,
                name: "Relationship",
                // keyboardType: TextInputType.emailAddress,
                hintText: "Enter relation",
                // validator: Validation.validateEmail,
              ),
            ],
          ),
        ),
      ],
      actionButton: BlocListener<ProfessionalrefBloc, ProfessionalrefState>(
        // listener: (context, state) {
        //   if (state is ProRefSuccess) {
        //     Navigator.pop(context);
        //     profRefBloc.add(FetchProfessionalref());
        //     CustomScaffoldMessenger.showSuccessMessage(context, state.message);
        //   } else if (state is ProfessionalrefError) {
        //     CustomScaffoldMessenger.showErrorMessage(context, state.message);
        //   }
        // },
        listener: (context, state) {
          if (state is ProRefSuccess) {
            Navigator.pop(context); // closes loader
            // Navigator.pop(context); // closes bottom sheet

            profRefBloc.add(FetchProfessionalref());

            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
          } else if (state is ProfessionalrefError) {
            Navigator.pop(context); // close loader if open
            CustomScaffoldMessenger.showErrorMessage(context, state.message);
          }
        },

        child: BlocBuilder<ProfessionalrefBloc, ProfessionalrefState>(
          builder: (context, state) {
            final bool isLoading = state is ProfessionalrefAddLoading;

            return CustomButton(
              text: "Add Reference",
              isLoading: isLoading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final event = AddProRef(
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
