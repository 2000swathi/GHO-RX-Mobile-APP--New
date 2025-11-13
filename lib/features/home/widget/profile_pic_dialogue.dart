import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_dotted_container.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/file_picker.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/widget/pick_file_dialogue_box.dart';


class ProfileDialog extends StatelessWidget {
  final String caseID;
  final String saltID;

  const ProfileDialog({
    super.key,
    required this.caseID,
    required this.saltID,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        color: AppColors.profilepink.withAlpha(13),
        height: 250,
        width: 200,
        child: Stack(
          children: [
            // Avatar
            Center(
              child: SvgPicture.asset(
                "assets/svg/person.svg",
                width: 60,
                height: 60,
              ),
            ),

            // Edit button
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () => _showEditDialog(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    "assets/svg/edit_svg.svg",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Edit Profile",
            style: AppFonts.buttontxt.copyWith(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
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
                              final picker = ImagePickerService();
                              await picker.pickFile(context);

                              if (picker.fileList.isNotEmpty) {
                                final file = picker.fileList.first;
                                final fileSize = (await file.length()).toString();
                                final fileName = file.path.split('/').last;
                                final filePath = file.path;

                                context.read<GetFileIdBloc>().add(
                                  GetFileIdEvent(
                                    filePath: filePath,
                                    caseID: caseID,
                                    docTypeID: 1,
                                    filename: fileName,
                                    fileSize: fileSize,
                                    saltKey: saltID,
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
                              final picker = ImagePickerService();
                              await picker.pickImageFromCamera(context);

                              if (picker.fileList.isNotEmpty) {
                                final file = picker.fileList.first;
                                final fileSize = (await file.length()).toString();
                                final fileName = file.path.split('/').last;
                                final filePath = file.path;

                                context.read<GetFileIdBloc>().add(
                                  GetFileIdEvent(
                                    filePath: filePath,
                                    caseID: caseID,
                                    docTypeID: 1,
                                    filename: fileName,
                                    fileSize: fileSize,
                                    saltKey: saltID,
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
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Done",
                      style: AppFonts.buttontxt.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
