import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/addedit_insurance_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/widget/insurance_card.dart';
import 'package:ghorx_mobile_app_new/features/account/insurance/repo/bloc/insurance_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class InsuranceScreen extends StatefulWidget {
  InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InsuranceBloc>().add(FetchInsurance());
  }

  @override
  Widget build(BuildContext context) {
    final insuranceBloc = context.read<InsuranceBloc>();
    return Scaffold(
      appBar: CustomAccountAppBar(
        title: "Insurance",
        onAdd: () {
          AddEditInsuranceSheet.showSheet(
            context,
            null,
            false,
            insuranceBloc: insuranceBloc,
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
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
            context.read<InsuranceBloc>().add(FetchInsurance());
          } else if (state is DeleteFailure) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showSuccessMessage(context, state.error);
          }
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<InsuranceBloc, InsuranceState>(
            builder: (context, state) {
              if (state is InsuranceLoading) {
                return Center(child: LoadingAnimation());
              } else if (state is InsuranceError) {
                return Center(child: Text(state.message));
              } else if (state is InsuranceGetState) {
                final info = state.insuranceModel.data;
                return ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (context, index) {
                    final insurance = info[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: InsuranceCard(
                        index: index,
                        providerId: insurance.id.toString(),
                        providerName: insurance.providerName ?? "",
                        issueDate: insurance.issueDate ?? "",
                        expiryDate: insurance.expiryDate ?? "",
                        onEdit: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );
                          Navigator.pop(context);
                          AddEditInsuranceSheet.showSheet(
                            context,
                            insurance,
                            true,
                            insuranceBloc: insuranceBloc,
                          );
                        },
                        onDelete: () async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: "Delete Insurance",
                            content: "Are you sure want to delete",
                          );
                          if (confirmed == true && context.mounted) {
                            context.read<DeleteBloc>().add(
                              DeleteProfileItem(
                                id: insurance.id.toString(),
                                action: "reviewerins",
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
