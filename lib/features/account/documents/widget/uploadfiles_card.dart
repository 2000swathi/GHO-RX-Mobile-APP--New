import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_dotted_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_drop_down_field.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/file_picker.dart';
import 'package:ghorx_mobile_app_new/features/account/documents/repo/bloc/doctfile_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/widget/pick_file_dialogue_box.dart';

class UploadDoc extends StatefulWidget {
  final List docTypes;
  const UploadDoc({super.key, required this.docTypes});

  @override
  State<UploadDoc> createState() => _UploadDocState();
}

class _UploadDocState extends State<UploadDoc> {
  int? selectedDocTypeId; 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titlePadding: const EdgeInsets.only(left: 20),
      title: Row(
        children: [
          Text("Upload Files", style: AppFonts.subheading),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: AppColors.black),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: BlocConsumer<GetFileIdBloc, GetFileIdState>(
          listener: (context, state) {
            if (state is SuccessAPI) {
              context.read<DoctfileBloc>().add(UploadDocFileEvent());
              Navigator.pop(context);
            } else if (state is GetFileIdFailure) {
              CustomScaffoldMessenger.showErrorMessage(
                context,
                state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is GetFileIdLoading) {
              return SizedBox(
                  height: 100,
                child: const Center(child: LoadingAnimation()));
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDropdownFormField<int>(
                  borderColor: AppColors.grey,
                  name: "Document Type*",
                  hintText: "- Select Document Type -",
                  value: selectedDocTypeId,
                  items: widget.docTypes.map<DropdownItem<int>>((doc) {
                    return DropdownItem<int>(
                      value: int.parse(doc['DataValue']),     
                      label: doc['DisplyText'],    
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDocTypeId = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: CustomDottedBorderContainer(
                          color: AppColors.textPrimary,
                          strokeWidth: 1,
                          dashWidth: 3,
                          dashSpace: 3,
                          borderRadius: BorderRadius.circular(8),
                          padding: EdgeInsets.zero,
                          child: PickFileDialogueBox(
                            icon: Icons.file_upload_outlined,
                            label: "Upload Doc",
                            onTap: () async {
                              if (selectedDocTypeId == null) {
                                CustomScaffoldMessenger.showErrorMessage(
                                  context,
                                  "Please select document type",
                                );
                                return;
                              }

                              final picker = ImagePickerService();
                              await picker.pickFile(context);

                              if (picker.fileList.isNotEmpty) {
                                final file = picker.fileList.first;
                                final fileSize =
                                    (await file.length()).toString();
                                final fileName = file.path.split('/').last;
                                final filePath = file.path;

                                context.read<GetFileIdBloc>().add(
                                  GetFileIdEvent(
                                    filePath: filePath,
                                    caseID: "",
                                    docTypeID: selectedDocTypeId!, 
                                    filename: fileName,
                                    fileSize: fileSize,
                                    saltKey: "",
                                    context: context,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: CustomDottedBorderContainer(
                          color: AppColors.textPrimary,
                          strokeWidth: 1,
                          dashWidth: 3,
                          dashSpace: 3,
                          borderRadius: BorderRadius.circular(8),
                          child: PickFileDialogueBox(
                            icon: Icons.camera_alt_outlined,
                            label: "Scan",
                            onTap: () async {
                              if (selectedDocTypeId == null) {
                                CustomScaffoldMessenger.showErrorMessage(
                                  context,
                                  "Please select document type",
                                );
                                return;
                              }

                              final picker = ImagePickerService();
                              await picker.pickImageFromCamera(context);

                              if (picker.fileList.isNotEmpty) {
                                final file = picker.fileList.first;
                                
                                final fileSize =
                                    (await file.length()).toString();
                                final fileName = file.path.split('/').last;
                                final filePath = file.path;

                                context.read<GetFileIdBloc>().add(
                                  GetFileIdEvent(
                                    filePath: filePath,
                                    caseID: "",
                                    docTypeID: selectedDocTypeId!, 
                                    filename: fileName,
                                    fileSize: fileSize,
                                    saltKey: "",
                                    context: context,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
