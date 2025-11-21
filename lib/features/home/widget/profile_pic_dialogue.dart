import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_dotted_container.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/core/constants/file_picker.dart';
import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/bloc/profile_info_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/prfile_pic/bloc/pic_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_bloc.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/repository/bloc/get_file_id_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/review/pages/audio_document/widget/pick_file_dialogue_box.dart';

// ignore: must_be_immutable
class ProfileDialog extends StatefulWidget {
  String url;
  ProfileDialog({super.key, required this.url});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        color: AppColors.profilepink.withAlpha(13),
        height: 250,
        width: 200,
        child: Stack(
          children: [
            Center(
              child:
                  widget.url.isNotEmpty
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          placeholder:
                              (context, url) => SvgPicture.asset(
                                "assets/svg/person.svg",
                                width: 60,
                                height: 60,
                              ),
                          errorWidget:
                              (context, url, error) => SvgPicture.asset(
                                "assets/svg/person.svg",
                                height: 24,
                                width: 24,
                              ),
                        ),
                      )
                      : SvgPicture.asset(
                        "assets/svg/person.svg",
                        width: 60,
                        height: 60,
                      ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primarycolor),
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
        return BlocListener<GetFileIdBloc, GetFileIdState>(
          listener: (context, state) async {
            if (state is SuccessAPI) {
              await CachedNetworkImage.evictFromCache(widget.url);

              context.read<PicBloc>().add(FetchPicEvent());

              Navigator.pop(context);
            } else if (state is GetFileIdFailure) {
              Navigator.pop(context);
              CustomScaffoldMessenger.showErrorMessage(
                context,
                "Upload failed ${state.message}",
              );
            }
          },
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  children: [
                    Text("Edit Profile", style: AppFonts.subheading),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: AppColors.black),
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                content: BlocBuilder<GetFileIdBloc, GetFileIdState>(
                  builder: (context, state) {
                    if (state is GetFileIdLoading) {
                      return SizedBox(
                        height: 100,
                        child: const Center(child: LoadingAnimation()),
                      );
                    }

                    return SizedBox(
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
                                      label: "Upload Image",
                                      onTap: () async {
                                        final picker = ImagePickerService();
                                        await picker.pickSingleImageFromGallery(
                                          context,
                                        );

                                        if (picker.fileList.isNotEmpty) {
                                          final file = picker.fileList.first;
                                          final fileSize =
                                              (await file.length()).toString();
                                          final fileName =
                                              file.path.split('/').last;
                                          final filePath = file.path;

                                          context.read<GetFileIdBloc>().add(
                                            GetFileIdEvent(
                                              filePath: filePath,
                                              caseID: "",
                                              docTypeID: 9,
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
                                        final picker = ImagePickerService();
                                        await picker.picksingleImageFromCamera(
                                          context,
                                        );

                                        if (picker.fileList.isNotEmpty) {
                                          final file = picker.fileList.first;
                                          final fileSize =
                                              (await file.length()).toString();
                                          final fileName =
                                              file.path.split('/').last;
                                          final filePath = file.path;

                                          context.read<GetFileIdBloc>().add(
                                            GetFileIdEvent(
                                              filePath: filePath,
                                              caseID: "",
                                              docTypeID: 9,
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
                          const SizedBox(height: 15),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
