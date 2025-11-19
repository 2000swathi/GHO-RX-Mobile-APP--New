import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/profile/Bank_info/bloc/bank_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_bloc.dart';
import 'package:ghorx_mobile_app_new/features/profile/add/bloc/add_event.dart';
import 'package:ghorx_mobile_app_new/features/profile/Bank_info/model/bankinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/edit/bloc/edit_bloc.dart';

class AddEditBankInfoBottonSheet {
  static void showSheet(
    BuildContext context,
    BankInfoResponseModel? info,
    bool? isEdit, {
    required BankInfoBloc bankinfobloc,
  }) {
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
      actionButton: MultiBlocListener(
        listeners: [
          BlocListener<AddBloc, AddState>(
            listener: (context, state) {
              if (state is AddSuccess) {
                if (Navigator.canPop(context)) Navigator.pop(context);
                bankinfobloc.add(FetchBankInfo());
                CustomScaffoldMessenger.showSuccessMessage(
                  context,
                  state.response["Data"][0][0]["msg"].toString(),
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
                if (Navigator.canPop(context)) Navigator.pop(context);
                bankinfobloc.add(FetchBankInfo());
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
                  text: isEdit! ? "Update Bank Info" : "Submit Bank Info",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        context.read<EditBloc>().add(
                          EditBankInfoEvent(
                            id: info!.data[0].id.toString(),
                            accountNumber: accountNameController.text,
                            accountType: bankTypeController.text,
                            holderName: accountNameController.text,
                            routingNumber: routingNumberController.text,
                          ),
                        );
                      } else {
                        context.read<AddBloc>().add(
                          AddBankInfo(
                            accountNumber: accountNameController.text,
                            accountType: bankTypeController.text,
                            holderName: accountNameController.text,
                            routingNumber: routingNumberController.text,
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
