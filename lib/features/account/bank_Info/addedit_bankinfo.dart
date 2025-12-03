import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_bottomsheet.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_textformfield.dart';
import 'package:ghorx_mobile_app_new/core/constants/validation.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/bloc/bank_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/model/bankinfo_model.dart';

class AddEditBankInfoBottonSheet {
  static void showSheet(
    BuildContext context,
    BankInfoModel? info,
    bool? isEdit, {
    required BankInfoBloc bankinfobloc,
  }) {
    final bool editing = isEdit == true && info != null;
    final _formKey = GlobalKey<FormState>();

    final TextEditingController bankNameController = TextEditingController(
      text: editing ? info.bankName : "",
    );
    final TextEditingController bankTypeController = TextEditingController(
      text: editing ? info.accountType : "",
    );
    final TextEditingController routingNumberController = TextEditingController(
      text: editing ? info.routingNumber : "",
    );
    final TextEditingController accountNumberController = TextEditingController(
      text: editing ? info.accountNumber : "",
    );
    final TextEditingController accountNameController = TextEditingController(
      text: editing ? info.accountHolderName : "",
    );
    CustomBottomSheet.show(
      context: context,
      heading: editing ? "Edit Bank Information" : "Add Bank Information",
      content: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: bankNameController,
                name: "Bank Name",
                hintText: "Enter Bank Name",
                validator:
                    (value) =>
                        Validation.field(value, fieldName: "Bank Name"),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: bankTypeController,
                name: "Bank Type",
                hintText: "Enter Account Type",
                validator:
                    (value) =>
                        Validation.field(value, fieldName: "Account type"),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: routingNumberController,
                name: "Routing Number (Branch Code)",
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
      actionButton: BlocListener<BankInfoBloc, BankInfoState>(
        listener: (context, state) {
          if (state is BankInfoSuccess) {
            if (Navigator.canPop(context)) Navigator.pop(context);
            bankinfobloc.add(FetchBankInfo());
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
          } else if (state is BankInfoError) {
            CustomScaffoldMessenger.showErrorMessage(context, state.message);
          }
        },

        child: BlocBuilder<BankInfoBloc, BankInfoState>(
          builder: (context, addState) {
            final bool isAddLoading = addState is BankInfoAddLoading;
            return BlocBuilder<BankInfoBloc, BankInfoState>(
              builder: (context, editState) {
                final bool isEditLoading = editState is BankInfoEditLoading;
                final bool isLoading = isAddLoading || isEditLoading;

                return CustomButton(
                  text: isEdit! ? "Update Bank Info" : "Submit Bank Info",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEdit) {
                        context.read<BankInfoBloc>().add(
                          EditBankInfoEvent(
                            id: info!.id.toString(),
                            accountNumber: accountNameController.text.trim(),
                            accountType: bankTypeController.text.trim(),
                            holderName: accountNameController.text.trim(),
                            routingNumber: routingNumberController.text.trim(),
                            bankName: bankNameController.text.trim()
                          ),
                        );
                      } else {
                        context.read<BankInfoBloc>().add(
                          AddBankInfo(
                            accountNumber: accountNameController.text.trim(),
                            accountType: bankTypeController.text.trim(),
                            holderName: accountNameController.text.trim(),
                            routingNumber: routingNumberController.text.trim(),
                            bankName: bankNameController.text.trim()
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
