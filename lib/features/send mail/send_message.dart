// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_button.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/repository/bloc/sendmail_bloc.dart';
import 'package:ghorx_mobile_app_new/features/send%20mail/repository/bloc/sendmail_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMessage extends StatefulWidget {
  final String from;
  final String to;

  const SendMessage({super.key, required this.from, required this.to});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  final TextEditingController message = TextEditingController();
  List<String> drafts = [];

  @override
  void initState() {
    super.initState();
    _loadDrafts();
  }

  Future<void> _loadDrafts() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('draft_messages') ?? [];
    setState(() => drafts = savedList);
  }

  Future<void> _saveDraft() async {
    final text = message.text.trim();
    if (text.isEmpty) {
      CustomScaffoldMessenger.showErrorMessage(
        context,
        "Message cannot be empty",
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('draft_messages') ?? [];

    if (!savedList.contains(text)) {
      savedList.add(text);
      await prefs.setStringList('draft_messages', savedList);
      setState(() => drafts = savedList);
    }

    CustomScaffoldMessenger.showCommonMessage(context, "Draft saved");
  }

  Future<void> _discardDraft(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('draft_messages') ?? [];
    savedList.removeAt(index);
    await prefs.setStringList('draft_messages', savedList);
    setState(() => drafts = savedList);
    CustomScaffoldMessenger.showCommonMessage(context, "Draft discarded");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendmailBloc, SendmailState>(
      listener: (context, state) async {
        if (state is SendmailLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: LoadingAnimation()),
          );
        } else if (state is SendmailSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          CustomScaffoldMessenger.showSuccessMessage(context, state.message);
        } else if (state is SendmailFailure) {
          Navigator.of(context).pop();
          CustomScaffoldMessenger.showErrorMessage(context, state.error);
        }
      },
      child: Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/svg/Frame 1.svg", height: 26),
                        const SizedBox(width: 8),
                        Text(
                          "Send an Email",
                          style: AppFonts.buttontxt.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(thickness: 0.8),

                /// FROM & TO
                _buildInfoRow("From:", widget.from),
                const Divider(thickness: 0.8),
                _buildInfoRow("To:", widget.to),
                const Divider(thickness: 0.8),

                const SizedBox(height: 10),

                /// DRAFTED MESSAGES LIST
                if (drafts.isNotEmpty) ...[
                  Text(
                    "Saved Drafts:",
                    style: AppFonts.buttontxt.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: drafts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppColors.white,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(
                            drafts[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _discardDraft(index),
                          ),
                          onTap: () async {
                            // Load the tapped draft into the text field
                            setState(() => message.text = drafts[index]);

                            // Remove it from SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            final savedList =
                                prefs.getStringList('draft_messages') ?? [];
                            savedList.removeAt(index);
                            await prefs.setStringList(
                              'draft_messages',
                              savedList,
                            );

                            // Update the UI
                            setState(() => drafts = savedList);

                            CustomScaffoldMessenger.showCommonMessage(
                              context,
                              "Draft loaded and removed from list",
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(thickness: 1),
                  const SizedBox(height: 6),
                ],

                /// MESSAGE FIELD
                Text(
                  "Message:",
                  style: AppFonts.buttontxt.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),

                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundcolor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.backgroundcolor.withAlpha(80),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: message,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your message here..',
                      hintStyle: TextStyle(color: AppColors.hint2color),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                /// ACTION BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: _saveDraft,
                      icon: SvgPicture.asset(
                        "assets/svg/iconsax-archive.svg",
                        height: 16,
                        width: 16,
                      ),
                      label: Text(
                        "Save Draft",
                        style: AppFonts.buttontxt.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          message.clear();
                        });

                        CustomScaffoldMessenger.showCommonMessage(
                          context,
                          "Message discarded",
                        );
                      },
                      child: Text(
                        "Discard",
                        style: AppFonts.buttontxt.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: CustomButton(
                            color: AppColors.primarycolor,
                            colortext: AppColors.white,
                            text: "Send",
                            onPressed: () {
                              final msg = message.text.trim();
                              if (msg.isEmpty) {
                                CustomScaffoldMessenger.showErrorMessage(
                                  context,
                                  "Message cannot be empty",
                                );
                                return;
                              }
                              context.read<SendmailBloc>().add(
                                SendMail(
                                  adminEmailId: widget.from,
                                  doctorEmailid: widget.to,
                                  msg: msg,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: AppFonts.buttontxt.copyWith(
            color: AppColors.textPrimary,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: AppFonts.buttontxt.copyWith(
              color: AppColors.textPrimary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
