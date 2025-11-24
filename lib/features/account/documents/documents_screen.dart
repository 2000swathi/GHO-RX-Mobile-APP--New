import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/commondelete_dialogbox.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/get_files_icons.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/repo/bloc/doctfile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/widget/uploadfiles_card.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_event.dart';

class DocumentsScreen extends StatefulWidget {
  DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctfileBloc>().add(UploadDocFileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      listener: (context, state) {
        if (state is CommonListState) {
          final docTypes = state.response["Data"][0];
          showDialog(
            context: context,
            builder: (_) => UploadDoc(docTypes: docTypes),
          );
        }

        if (state is ListFailure) {
          CustomScaffoldMessenger.showErrorMessage(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        appBar: CustomAccountAppBar(
          title: "Upload Documents",
          onAdd: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: LoadingAnimation()),
            );
            context.read<ListBloc>().add(FetchDocTypeList());
            Navigator.pop(context);
          },
        ),
        body: BlocListener<GetFileIdBloc, GetFileIdState>(
          listener: (context, state) async {
            if (state is DeleteFileSuccess) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            } else if (state is GetFileIdFailure) {
              Navigator.pop(context);
              CustomScaffoldMessenger.showErrorMessage(context, state.message);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<DoctfileBloc, DoctfileState>(
              builder: (context, state) {
                if (state is DoctfileLoading) {
                  return const Center(child: LoadingAnimation());
                } else if (state is DoctfileSuccess) {
                  if (state.response["Data"] == null ||
                      state.response["Data"].isEmpty) {
                    return Center(
                      child: Text(
                        "No documents uploaded yet.",
                        style: AppFonts.hinttext2,
                      ),
                    );
                  }
                  final List documents = state.response["Data"][0];

                  final Map<String, List> groupedDocs = {};

                  for (var doc in documents) {
                    final String title = doc["DisplyText"] ?? "Others";
                    groupedDocs.putIfAbsent(title, () => []);
                    groupedDocs[title]!.add(doc);
                  }

                  return ListView(
                    children:
                        groupedDocs.entries.map((entry) {
                          final String title = entry.key;
                          final List docs = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ===== HEADING =====
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                  title,
                                  style: AppFonts.subheading16,
                                ),
                              ),

                              // ===== FILE LIST =====
                              ...docs.map((report) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: AppColors.primarycolor,
                                            width: 1,
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: SvgPicture.asset(
                                            GetFilesandIcons.getFileIcon(
                                              report["DownloadUrl"],
                                            ),
                                            width: 24,
                                            height: 24,
                                          ),
                                          title: Text(
                                            report["OrgFileName"],
                                            style: AppFonts.subheading16,
                                          ),
                                          onTap: () async {
                                            try {
                                              await GetFilesandIcons.openDocument(
                                                report["DownloadUrl"],
                                              );
                                            } catch (e) {
                                              CustomScaffoldMessenger.showErrorMessage(
                                                context,
                                                "Could not open document",
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final confirmed =
                                            await showDeleteConfirmationDialog(
                                              context: context,
                                              title: "Delete Document",
                                              content:
                                                  "Are you sure want to delete",
                                            );
                                        if (confirmed == true &&
                                            context.mounted) {
                                          context.read<GetFileIdBloc>().add(
                                            DeleteFileEvent(
                                              saltID: "",
                                              docTypeId:
                                                  report["DocumentTypeID"],
                                              fileUploadedID: report["id"],
                                              filePath: "",
                                              context: context,
                                            ),
                                          );
                                        }
                                      },
                                      icon: SvgPicture.asset(
                                        "assets/svg/trash.svg",
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          );
                        }).toList(),
                  );
                } else if (state is DoctfileFailure) {
                  return Center(
                    child: Text(
                      "Error: ${state.error}",
                      style: AppFonts.hinttext2,
                    ),
                  );
                }
                return Center(
                  child: Text(
                    "No documents uploaded yet.",
                    style: AppFonts.hinttext2,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
