import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/bloc/education_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/professionalreff_card.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/bloc/professionalref_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/professional%20references/widget/addEditbottomSheet.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class ProfessionalReferencesScreen extends StatefulWidget {
  ProfessionalReferencesScreen({super.key});

  @override
  State<ProfessionalReferencesScreen> createState() =>
      _ProfessionalReferencesScreenState();
}

class _ProfessionalReferencesScreenState
    extends State<ProfessionalReferencesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfessionalrefBloc>().add(FetchProfessionalref());
  }

  @override
  Widget build(BuildContext context) {
    // final professionalrefBloc = context.read<ProfessionalrefBloc>();
    final deleteBloc = context.read<DeleteBloc>();
    final listBloc = context.read<ListBloc>();
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Professional References",
        onAdd: () async {
          listBloc.add(FetchReferenceList());
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );
          final listState = await listBloc.stream.firstWhere(
            (s) => s is ReferenceTypeListState || s is ListFailure,
          );
          Navigator.pop(context);

          if (listState is ReferenceTypeListState) {
            final referenceTypelist = listState.referenceTypeResponse;

            AddProfessionalRefBottomSheet.showSheet(
              context,
              null,
              false, // info = null for Add
              profRefBloc: context.read<ProfessionalrefBloc>(),
              relationList: referenceTypelist.data,
            );
          }
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
              "Reference deleted successfully",
            );
            context.read<ProfessionalrefBloc>().add(FetchProfessionalref());
          } else if (state is DeleteFailure) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showSuccessMessage(
              context,
              "Failed to delete Reference",
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<ProfessionalrefBloc, ProfessionalrefState>(
            builder: (context, state) {
              if (state is ProfessionalrefLoading) {
                return const Center(child: LoadingAnimation());
              } else if (state is ProfessionalrefError) {
                return Center(child: Text(state.message));
              } else if (state is ProfessionalrefgetState) {
                final info = state.professionalerefModel.data;
                if (info.isEmpty) {
                  return Center(child: Text("No Professional reference Added"));
                }
                return ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (context, index) {
                    final reference = info[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: ProfessionalRefeCard(
                        index: index + 1,
                        fullnameRefe: reference.fullName,
                        designationRefe: reference.designation,
                        // designation1Refe: reference.designation1,
                        relationshipRefe: reference.relationship,
                        phoneRefe: reference.phone,
                        onEdit: () async {
                          listBloc.add(FetchReferenceList());
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );

                          final listState = await listBloc.stream.firstWhere(
                            (s) =>
                                s is ReferenceTypeListState || s is ListFailure,
                          );
                          Navigator.pop(context);
                          if (listState is ReferenceTypeListState) {
                            final referenceTypeList =
                                listState.referenceTypeResponse.data;
                            AddProfessionalRefBottomSheet.showSheet(
                              context,
                              reference,
                              true,
                              profRefBloc: context.read<ProfessionalrefBloc>(),
                              relationList: referenceTypeList,
                            );
                          }
                        },
                        onDelete: () async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: "Delete License",
                            content: "Are you sure you want to delete?",
                          );

                          if (confirmed == true) {
                            deleteBloc.add(
                              DeleteProfileItem(
                                id: reference.id.toString(),
                                action: "reviewerref",
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
