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
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/bankinfo_model.dart';

class AddEditBankInfoBottonSheet {
  static void showSheet(
    BuildContext context,
    BankInfoResponseModel? info,
    bool? isEdit,
  ) {
    final bool editing = isEdit == true && info != null;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController bankTypeController = TextEditingController(
      text: editing ? info.data[0].accountType : "",
    );
    final TextEditingController routingNumberController = TextEditingController(
      text: editing ? info.data[0].routingNumber : "",
    );
    final TextEditingController accountNumberController = TextEditingController(
      text: editing ? info.data[0].accountNumber : "",
    );
    final TextEditingController accountNameController = TextEditingController(
      text: editing ? info.data[0].accountHolderName : "",
    );
    // void dispose(){
    //   bankTypeController.dispose();
    // }
    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit Bank Information" : "Add Bank Information",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: bankTypeController,
                name: "Bank Type",
                hintText: "Enter Bank Type",
                validator:
                    (value) =>
                        Validation.field(value, fieldName: "Account type"),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: routingNumberController,
                name: "Routing Number",
                hintText: "Enter Routing Number",
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: accountNumberController,
                name: "Account Number",
                hintText: "Enter Account Number",
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: accountNameController,
                name: "Account Name",
                hintText: "Enter Account Name",
                validator:
                    (value) =>
                        Validation.field(value, fieldName: "Account Name"),
              ),
            ],
          ),
        ),
      ],
      actionButton: BlocListener<AddBloc, AddState>(
        listener: (context, state) {
          if (state is AddSuccess) {
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
                      : (isEdit == true ? "Edit Bank Info" : "Add Bank Info"),
              onPressed: () {
                // 1️⃣ Prevent click during loading
                if (state is AddLoading) return;

                // 2️⃣ Validate form safely
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  context.read<AddBloc>().add(
                    AddBankInfo(
                      accountNumber: accountNameController.text,
                      accountType: bankTypeController.text,
                      holderName: accountNameController.text,
                      routingNumber: routingNumberController.text,
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
