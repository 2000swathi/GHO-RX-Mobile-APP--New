import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/repo/bloc/questions_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  List<Map<String, dynamic>> allQuestions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionsBloc>().add(FetchQuestionsEvent());
    });
  }

  bool isSelected(Map q) {
    return q["qid"] != null && q["qid"].toString() != '0';
  }

  final Set<String> updatingIds = {};

  bool hasFetchedInitially = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(title: "Questionnaire"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MultiBlocListener(
          listeners: [
            /// QUESTIONS LISTENER
            BlocListener<QuestionsBloc, QuestionsState>(
              listener: (context, state) {
                if (state is Questionsgetting && !hasFetchedInitially) {
                  setState(() {
                    allQuestions = List<Map<String, dynamic>>.from(
                      state.response["Data"]?[0] ?? [],
                    );
                    hasFetchedInitially = true;
                  });
                }
              },
            ),

            BlocListener<QuestionsBloc, QuestionsState>(
              listener: (context, state) {
                if (state is Questionsgetting || state is QuestionsError) {
                  setState(() {
                    updatingIds.clear();
                  });
                }
              },
            ),

            /// DELETE LISTENER
            BlocListener<DeleteBloc, DeleteState>(
              listener: (context, state) {
                if (state is DeleteSuccess) {
                  CustomScaffoldMessenger.showCommonMessage(
                    context,
                    state.message,
                  );
                } else if (state is DeleteFailure) {
                  CustomScaffoldMessenger.showCommonMessage(
                    context,
                    state.error,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<QuestionsBloc, QuestionsState>(
            builder: (context, state) {
              if (state is QuestionsLoading && allQuestions.isEmpty) {
                return const Center(child: LoadingAnimation());
              }

              if (state is QuestionsError && allQuestions.isEmpty) {
                return Center(child: Text(state.message));
              }

              if (allQuestions.isNotEmpty) {
                final selected =
                    allQuestions.where((q) => isSelected(q)).toList();

                final unselected =
                    allQuestions.where((q) => !isSelected(q)).toList();

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      /// INFO BOX
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primarycolor.withAlpha(13),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primarycolor.withAlpha(50),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.primarycolor,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Please answer all questions honestly and completely",
                                style: AppFonts.textprogressbar.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// SUBMITTED
                      if (selected.isNotEmpty) ...[
                        Text(
                          "Submitted Questions",
                          style: AppFonts.textprimary.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...selected.map(
                          (q) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: questionItem(q),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      /// AVAILABLE
                      if (unselected.isNotEmpty) ...[
                        Text(
                          "Available Questions",
                          style: AppFonts.textprimary.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...unselected.map(
                          (q) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: questionItem(q),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }

              return const Center(child: Text("Invalid State"));
            },
          ),
        ),
      ),
    );
  }

  Widget questionItem(Map q) {
    final selected = isSelected(q);

    void toggleSelection() {
      final id = q["id"].toString();

      if (updatingIds.contains(id)) return; // 🔒 prevent double tap

      setState(() {
        updatingIds.add(id);

        final index = allQuestions.indexWhere((e) => e["id"] == q["id"]);
        if (index != -1) {
          allQuestions[index] = {
            ...allQuestions[index],
            "qid": selected ? "0" : "1",
          };
        }
      });

      context.read<QuestionsBloc>().add(
        AddQuestionsEvent(id: id, value: selected ? "0" : "1"),
      );
    }

    return InkWell(
      onTap: toggleSelection,
      child: Row(
        children: [
          Checkbox(
            value: selected,
            onChanged: (_) => toggleSelection(),
            activeColor: AppColors.primarycolor,
          ),
          Expanded(
            child: Text(
              q["Question"] ?? "",
              style: AppFonts.textprimary.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
