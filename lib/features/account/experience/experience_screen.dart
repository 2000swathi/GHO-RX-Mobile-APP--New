import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/experience/addedit_expsheet.dart';
import 'package:ghorx_mobile_app_new/features/account/experience/repo/bloc/professinal_experince_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/experience/widget/experience_card.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/month/bloc/month_bloc.dart';

class ProfessionalExperienceScreen extends StatefulWidget {
  const ProfessionalExperienceScreen({super.key});

  @override
  State<ProfessionalExperienceScreen> createState() =>
      _ProfessionalExperienceScreenState();
}

class _ProfessionalExperienceScreenState
    extends State<ProfessionalExperienceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfessinalExperinceBloc>().add(FetchExperience());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(
        title: "Professional Experience",
        onAdd: () async {
          final monthBloc = context.read<MonthBloc>();
          monthBloc.add(FetchMonthEvent());

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );

          final listState = await monthBloc.stream.firstWhere(
            (state) => state is MonthScuccess || state is MonthFailure,
          );

          Navigator.pop(context);

          if (listState is MonthScuccess) {
            final monthList = listState.response["Months"];

            AddEditExperienceSheet.showSheet(
              context,
              null,
              false,
              experienceBloc: context.read<ProfessinalExperinceBloc>(),
              months: listState.response["Data"][0],
            );
          } else if (listState is MonthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(listState.error)));
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
              "Experience deleted successfully",
            );
            context.read<ProfessinalExperinceBloc>().add(FetchExperience());
          } else if (state is DeleteFailure) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showSuccessMessage(
              context,
              "Failed to delete experience",
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<
            ProfessinalExperinceBloc,
            ProfessinalExperinceState
          >(
            builder: (context, state) {
              if (state is ProfessinalExperinceLoading) {
                return const Center(child: LoadingAnimation());
              }

              if (state is ExpError) {
                return Center(child: Text(state.message));
              }

              if (state is ProfessinalExperinceListState) {
                final data = state.experienceResponse.data;

                final items =
                    data is List
                        ? data.expand((e) => e is List ? e : [e]).toList()
                        : [];

                if (items.isEmpty) {
                  return const Center(child: Text("No experience added."));
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final exp = items[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ProfessionalExperienceCard(
                        index: index + 1,
                        institute: exp.institution,
                        designation: exp.designation,
                        dateFrom: exp.dateFrom,
                        dateTo: exp.dateTo,
                        onEdit: () async {
                          final monthBloc = context.read<MonthBloc>();
                          monthBloc.add(FetchMonthEvent());

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );

                          final listState = await monthBloc.stream.firstWhere(
                            (state) =>
                                state is MonthScuccess || state is MonthFailure,
                          );

                          Navigator.pop(context);

                          if (listState is MonthScuccess) {
                            AddEditExperienceSheet.showSheet(
                              context,
                              exp,
                              true,
                              experienceBloc:
                                  context.read<ProfessinalExperinceBloc>(),
                              months: listState.response["Data"][0],
                            );
                          } else if (listState is MonthFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(listState.error)),
                            );
                          }
                        },
                        onDelete: () async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: "Delete Experience",
                            content: "Are you sure want to delete",
                          );
                          if (confirmed == true && context.mounted) {
                            context.read<DeleteBloc>().add(
                              DeleteProfileItem(
                                id: exp.id.toString(),
                                action: "reviewerexp",
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

              return const Center(child: Text("Invalid state"));
            },
          ),
        ),
      ),
    );
  }
}
