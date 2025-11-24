import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/addedit_specialty_sheet.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/bloc/specialty_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/specialty/widget/specialty_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class SpecialtyScreen extends StatefulWidget {
  SpecialtyScreen({super.key});

  @override
  State<SpecialtyScreen> createState() => _SpecialtyScreenState();
}

class _SpecialtyScreenState extends State<SpecialtyScreen> {
  final List<Map<String, dynamic>> specialtyData = [
    {"specialty": "Surgeon", "certifiedBoard": "NABH", "specialtyType": "ABCD"},
    {"specialty": "Surgeon", "certifiedBoard": "NABH", "specialtyType": "ABCD"},
  ];
  @override
  void initState() {
    super.initState();
    context.read<SpecialtyBloc>().add(FetchSpecialty());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(
        title: "Specialty",
        onAdd: () async {
          final listBloc = context.read<ListBloc>();
          listBloc.add(FetchSpecialtyList());
          listBloc.add(FetchCertifiedList());
          listBloc.add(FetchSpecialtyTypeList());
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );

          final results = await Future.wait([
            listBloc.stream.firstWhere(
              (s) => s is SpecialtyListState || s is ListFailure,
            ),
            listBloc.stream.firstWhere(
              (s) => s is CertifiedListState || s is ListFailure,
            ),
            listBloc.stream.firstWhere(
              (s) => s is SpecialtyTypeListState || s is ListFailure,
            ),
          ]);

          Navigator.of(context, rootNavigator: true).pop();

          final listState = results[0];
          final certifiedState = results[1];
          final typeState = results[2];

          if (listState is SpecialtyListState &&
              certifiedState is CertifiedListState &&
              typeState is SpecialtyTypeListState) {
            final specialties =
                listState.specialtyResponse.data
                    .expand((inner) => inner)
                    .toList();
            final certifiedBoards =
                certifiedState.certifiedResponse.data
                    .expand((inner) => inner)
                    .toList();
            final specialtyTypes =
                typeState.specialtyTypeResponse.data
                    .expand((inner) => inner)
                    .toList();

            AddEditSpecialtySheet.showSheet(
              context,
              null,
              specialties,
              certifiedBoards,
              specialtyTypes,
              false,
              specBloc: context.read<SpecialtyBloc>(),
            );
          } else {
            String errorMessage = "Failed to load data.";
            if (listState is ListFailure) {
              errorMessage = listState.error;
            } else if (certifiedState is ListFailure) {
              errorMessage = certifiedState.error;
            }

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(errorMessage)));
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
              "Specialty deleted successfully",
            );
            context.read<SpecialtyBloc>().add(FetchSpecialty());
          } else if (state is DeleteFailure) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showSuccessMessage(
              context,
              "Failed to delete specialty",
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<SpecialtyBloc, SpecialtyState>(
            builder: (context, state) {
              if (state is SpecialityLoading) {
                return Center(child: LoadingAnimation());
              } else if (state is SpecialtyError) {
                return Center(child: Text(state.message));
              } else if (state is SpecialtyGetState) {
                final info = state.specialtyModel.data;
                if (info.isEmpty ) {
                return  Center(child: Text("No specialty Added"));
                }
                return ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (context, index) {
                    final specialty = info[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: SpecialtyCard(
                        index: index + 1,
                        specialty: specialty.specialty,
                        certifiedBoard: specialty.certifiedBoard,
                        specialtyType: specialty.specialtyType,
                        onEdit: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );

                          final listBloc = context.read<ListBloc>();
                          listBloc.add(FetchSpecialtyList());
                          listBloc.add(FetchCertifiedList());
                          listBloc.add(FetchSpecialtyTypeList());

                          final results = await Future.wait([
                            listBloc.stream.firstWhere(
                              (s) =>
                                  s is SpecialtyListState || s is ListFailure,
                            ),
                            listBloc.stream.firstWhere(
                              (s) =>
                                  s is CertifiedListState || s is ListFailure,
                            ),
                            listBloc.stream.firstWhere(
                              (s) =>
                                  s is SpecialtyTypeListState ||
                                  s is ListFailure,
                            ),
                          ]);

                          Navigator.of(context, rootNavigator: true).pop();

                          final listState = results[0];
                          final certifiedState = results[1];
                          final typeState = results[2];

                          if (listState is SpecialtyListState &&
                              certifiedState is CertifiedListState &&
                              typeState is SpecialtyTypeListState) {
                            final specialties =
                                listState.specialtyResponse.data
                                    .expand((inner) => inner)
                                    .toList();

                            final certifiedBoards =
                                certifiedState.certifiedResponse.data
                                    .expand((inner) => inner)
                                    .toList();

                            final specialtyTypes =
                                typeState.specialtyTypeResponse.data
                                    .expand((inner) => inner)
                                    .toList();

                            AddEditSpecialtySheet.showSheet(
                              context,
                              specialty,
                              specialties,
                              certifiedBoards,
                              specialtyTypes,
                              true,
                              specBloc: context.read<SpecialtyBloc>(),
                            );
                          } else {
                            String errorMessage = "Failed to load data.";
                            if (listState is ListFailure) {
                              errorMessage = listState.error;
                            } else if (certifiedState is ListFailure) {
                              errorMessage = certifiedState.error;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        },
                        onDelete: () async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: "Delete Specialty",
                            content: "Are you sure want to delete",
                          );
                          if (confirmed == true && context.mounted) {
                            context.read<DeleteBloc>().add(
                              DeleteProfileItem(
                                id: specialty.id.toString(),
                                action: "reviewerspl",
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
