import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/license/addedit_license_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/license/widget/license_card.dart';
import 'package:ghorx_mobile_app_new/features/account/license/repo/bloc/license_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class Licensescreen extends StatelessWidget {
  const Licensescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final licenseBloc = context.read<LicenseBloc>();
    final deleteBloc = context.read<DeleteBloc>();
    final listBloc = context.read<ListBloc>();

    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(title: "Licence"),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: CustomFAB(
        onAdd: () async {
          listBloc.add(FetchLicenseList());
          listBloc.add(FetchIssueingAuthorityList());

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );

          final licenseState = await listBloc.stream.firstWhere(
            (s) => s is LicenseListState || s is ListFailure,
          );
          final issueingState = await listBloc.stream.firstWhere(
            (s) => s is IssueingauthorityListState || s is ListFailure,
          );

          Navigator.pop(context);

          if (licenseState is LicenseListState &&
              issueingState is IssueingauthorityListState) {
            final licList =
                licenseState.licenseResponse.data.expand((e) => e).toList();
            final issuingList =
                issueingState.issueingauthorityResponse.data
                    .expand((e) => e)
                    .toList();

            AddEditLicenseSheet.showSheet(
              context,
              null,
              licList,
              issuingList,
              false,
              licenseBloc: licenseBloc,
            );
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocListener<DeleteBloc, DeleteState>(
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
                "License deleted successfully",
              );
              licenseBloc.add(FetchLicense());
            } else if (state is DeleteFailure) {
              Navigator.pop(context);
              CustomScaffoldMessenger.showErrorMessage(
                context,
                "Failed to delete license",
              );
            }
          },
          child: BlocBuilder<LicenseBloc, LicenseState>(
            builder: (context, state) {
              if (state is LicenseLoading) {
                return const Center(child: LoadingAnimation());
              }

              if (state is LicenseError) {
                return Center(child: Text(state.message));
              }

              if (state is Licensegetsuccess) {
                final licenses = state.licenseModel.data;

                if (licenses.isEmpty) {
                  return const Center(child: Text("No licenses found"));
                }

                return ListView.builder(
                  itemCount: licenses.length,
                  itemBuilder: (context, index) {
                    final license = licenses[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: LicenseCard(
                        index: index + 1,
                        licenseNumber: license.licenseNumber,
                        issueDate: license.issueDate,
                        expiryDate: license.expiryDate,
                        licenseType: license.licenseType,

                        /// ------------ DELETE CLICK ----------------
                        onDelete: () async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: "Delete License",
                            content: "Are you sure you want to delete?",
                          );

                          if (confirmed == true) {
                            deleteBloc.add(
                              DeleteProfileItem(
                                id: license.id.toString(),
                                action: "reviewerlic",
                                isLang: false,
                              ),
                            );
                          }
                        },

                        /// ------------ EDIT CLICK ----------------
                        onEdit: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );

                          listBloc.add(FetchLicenseList());
                          listBloc.add(FetchIssueingAuthorityList());

                          final listState = await listBloc.stream.firstWhere(
                            (s) => s is LicenseListState || s is ListFailure,
                          );
                          final issueingState = await listBloc.stream
                              .firstWhere(
                                (s) =>
                                    s is IssueingauthorityListState ||
                                    s is ListFailure,
                              );

                          Navigator.pop(context);

                          if (listState is LicenseListState &&
                              issueingState is IssueingauthorityListState) {
                            final licList =
                                listState.licenseResponse.data
                                    .expand((e) => e)
                                    .toList();
                            final issuingList =
                                issueingState.issueingauthorityResponse.data
                                    .expand((e) => e)
                                    .toList();

                            AddEditLicenseSheet.showSheet(
                              context,
                              license,
                              licList,
                              issuingList,
                              true,
                              licenseBloc: licenseBloc,
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              }

              return const Center(child: Text("Invalid State"));
            },
          ),
        ),
      ),
    );
  }
}
