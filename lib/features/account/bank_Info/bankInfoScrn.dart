import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/addedit_bankinfo.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/bloc/bank_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/bank_Info/widget/bankInfocard.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class Bankinfoscrn extends StatefulWidget {
  Bankinfoscrn({super.key});

  @override
  State<Bankinfoscrn> createState() => _BankinfoscrnState();
}

class _BankinfoscrnState extends State<Bankinfoscrn> {
  @override
  void initState() {
    super.initState();
    context.read<BankInfoBloc>().add(FetchBankInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Bank Information",
        onAdd: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );
          Navigator.pop(context);
          AddEditBankInfoBottonSheet.showSheet(
            context,
            null,
            false,
            bankinfobloc: context.read<BankInfoBloc>(),
          );
        },
      ),
      body: BlocListener<DeleteBloc, DeleteState>(
        listener: (context, state) {
          if (state is DeleteLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: LoadingAnimation()),
            );
          } else if (state is DeleteSuccess) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showSuccessMessage(
              context,
              "Bank Information deleted successfully",
            );
            context.read<BankInfoBloc>().add(FetchBankInfo());
          } else if (state is DeleteFailure) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showSuccessMessage(
              context,
              "Failed to delete Bank Information",
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<BankInfoBloc, BankInfoState>(
            builder: (context, state) {
              if (state is BankInfoLoading) {
                return Center(child: LoadingAnimation());
              } else if (state is BankInfoError) {
                return Center(child: Text(state.message));
              } else if (state is BankInfoGetState) {
                final info = state.bankListModel.data;
                if (info.isEmpty) {
                  return Center(child: Text("No Bank Informations"));
                }
                return ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (context, index) {
                    final bankinfo = info[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Bankinfocard(
                        index: index,
                        bankName: bankinfo.bankName,
                        accounName: bankinfo.accountHolderName,
                        accountType: bankinfo.accountType,
                        accountNumber: bankinfo.accountNumber,
                        onEdit: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                          AddEditBankInfoBottonSheet.showSheet(
                            context,
                            bankinfo,
                            true,
                            bankinfobloc: context.read<BankInfoBloc>(),
                          );
                        },
                        onDelete: () async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: "Delete Bank information",
                            content: "Are you sure want to delete",
                          );
                          if (confirmed == true && context.mounted) {
                            context.read<DeleteBloc>().add(
                              DeleteProfileItem(
                                id: bankinfo.id.toString(),
                                action: "revieweracc",
                                isLang: false,
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              }
              return Center(child: Text("Invalid State"));
            },
          ),
        ),
      ),
    );
  }
}
