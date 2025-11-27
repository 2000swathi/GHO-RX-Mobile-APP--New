import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/education/addedit_educationsheet.dart';
import 'package:ghorx_mobile_app_new/features/account/education/widget/education_card.dart';
import 'package:ghorx_mobile_app_new/features/account/education/repo/bloc/education_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class EducationScreen extends StatefulWidget {
  EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  void initState() {
    super.initState();
    final contextBloc = context.read;
    contextBloc<EducationBloc>().add(FetchEducation());
  }

  @override
  Widget build(BuildContext context) {
    final listBloc = context.read<ListBloc>();
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: CustomAccountAppBar(
        title: "Education",
        onAdd: () async {
          listBloc.add(FetchEducationList());

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );

          final listState = await listBloc.stream.firstWhere(
            (s) => s is EductionTypeListState || s is ListFailure,
          );

          Navigator.pop(context);

          if (listState is EductionTypeListState) {
            final degreeTypeList = listState.educationTypeResponse;

            AddeditEducationBottomSheet.showSheet(
              context,
              null,
              false,
              educationBloc: context.read<EducationBloc>(),
              educationList: degreeTypeList.data,
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
              "Education deleted successfully",
            );
            context.read<EducationBloc>().add(FetchEducation());
          } else if (state is DeleteFailure) {
            Navigator.pop(context);
            CustomScaffoldMessenger.showSuccessMessage(
              context,
              "Failed to delete education",
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<EducationBloc, EducationState>(
            builder: (context, state) {
              if (state is EducationLoading) {
                return Center(child: LoadingAnimation());
              } else if (state is EducationError) {
                return Center(child: Text(state.message));
              } else if (state is EducationListState) {
                final rawData = state.educationResponse.data;

                if (rawData == null || rawData is! List) {
                  return Center(
                    child: Text(
                      "No education details added yet",
                      style: AppFonts.textprimary,
                    ),
                  );
                }

                final flattened =
                    rawData.expand((item) {
                      if (item is List) return item;
                      if (item == null) return [];
                      return [item];
                    }).toList();

                final info =
                    flattened.where((item) {
                      try {
                        final institution =
                            item?.institution?.toString().trim();
                        return institution != null && institution.isNotEmpty;
                      } catch (_) {
                        return false;
                      }
                    }).toList();

                if (info.isEmpty) {
                  return Center(
                    child: Text(
                      "No education details added yet",
                      style: AppFonts.textprimary,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (context, index) {
                    final education = info[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: EducationCard(
                        index: index + 1,
                        institute: education.institution,
                        degree: education.degree,
                        duration: education.duration,
                        year: education.completedYear?.toString() ?? "",
                        comments: education.comments,
                        onEdit: () async {
                          listBloc.add(FetchEducationList());
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => const Center(child: LoadingAnimation()),
                          );
                          final listState = await listBloc.stream.firstWhere(
                            (s) =>
                                s is EductionTypeListState || s is ListFailure,
                          );

                          Navigator.pop(context);

                          if (listState is EductionTypeListState) {
                            final degreeTypeList =
                                listState.educationTypeResponse.data;

                            AddeditEducationBottomSheet.showSheet(
                              context,
                              education,
                              true,
                              educationBloc: context.read<EducationBloc>(),
                              educationList: degreeTypeList,
                            );
                          }
                        },
                        onDelete: () async {
                          final confirmed = await showDeleteConfirmationDialog(
                            context: context,
                            title: "Delete Education",
                            content: "Are you sure want to delete",
                          );
                          if (confirmed == true && context.mounted) {
                            context.read<DeleteBloc>().add(
                              DeleteProfileItem(
                                id: education.id.toString(),
                                action: "revieweredu",
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
