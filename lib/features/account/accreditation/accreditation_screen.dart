import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/addedit_accreditation_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/widget/accreditation_card.dart';
import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/bloc/accreditation_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/customFAB.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class AccreditationScreen extends StatefulWidget {
  AccreditationScreen({super.key});

  @override
  State<AccreditationScreen> createState() => _AccreditationScreenState();
}

class _AccreditationScreenState extends State<AccreditationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AccreditationBloc>().add(FetchAccreditation());
  }

  @override
  Widget build(BuildContext context) {
    final accreditationBloc = context.read<AccreditationBloc>();
    final deleteBloc = context.read<DeleteBloc>();
    final listBloc = context.read<ListBloc>();
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(title: "Accreditation"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomFAB(
        onAdd: () async {
          listBloc.add(FetchAccrediationList());
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );
          final listState = await listBloc.stream.firstWhere(
            (s) => s is AccreditationTypeListState || s is ListFailure,
          );

          Navigator.pop(context);
          if (listState is AccreditationTypeListState) {
            final accreditationTypeList =
                listState.accreditationTypeResponse.data;

            AddEditAccreditationBottomSheet.showSheet(
              context,
              null,
              false,
              accrBloc: context.read<AccreditationBloc>(),
              accreList: accreditationTypeList,
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
            CustomScaffoldMessenger.showSuccessMessage(context, state.message);
            accreditationBloc.add(FetchAccreditation());
          } else if (state is DeleteFailure) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showErrorMessage(context, state.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<AccreditationBloc, AccreditationState>(
            builder: (context, state) {
              if (state is AccrediationLoading) {
                return const Center(child: LoadingAnimation());
              }

              if (state is AccrediationError) {
                return Center(child: Text(state.message));
              }
              if (state is AccreditationgetState) {
                final info = state.accreditationModel.data;
                return ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (context, index) {
                    final accreditation = info[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: AccreditationCard(
                        index: index + 1,
                        accreNum: accreditation.accreditationNumber,
                        accreType: accreditation.accreditationType,
                        accreBody: accreditation.accreditationBody,
                        onEdit: () async {
                          listBloc.add(FetchAccrediationList());
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );
                          final listState = await listBloc.stream.firstWhere(
                            (s) =>
                                s is AccreditationTypeListState ||
                                s is ListFailure,
                          );

                          Navigator.pop(context);
                          if (listState is AccreditationTypeListState) {
                            final accreditationTypeList =
                                listState.accreditationTypeResponse.data;

                            AddEditAccreditationBottomSheet.showSheet(
                              context,
                              accreditation,
                              true,
                              accrBloc: context.read<AccreditationBloc>(),
                              accreList: accreditationTypeList,
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
                                id: accreditation.id.toString(),
                                action: "revieweraccred",
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
