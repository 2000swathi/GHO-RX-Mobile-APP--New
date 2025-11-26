import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/deleteBloc/bloc/delete_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/repo/bloc/questions_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final List<Map<String, dynamic>> selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListBloc>().add(FetchQuestList());
      context.read<QuestionsBloc>().add(FetchQuestionsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(title: "Questionnaire"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MultiBlocListener(
          listeners: [
            BlocListener<QuestionsBloc, QuestionsState>(
              listener: (context, state) {
                if (state is Questionsgetting) {
                  selectedQuestions
                    ..clear()
                    ..addAll(
                      state.response["Data"][0]
                          .map<Map<String, dynamic>>(
                            (e) => {
                              "QuestionnaireID": e["QuestionnaireID"],
                              "Question": e["Question"],
                              "Answer": e["Answer"],
                            },
                          )
                          .toList(),
                    );
                  setState(() {});
                }
              },
            ),
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
          child: BlocBuilder<ListBloc, ListState>(
            builder: (context, state) {
              if (state is ListLoading) {
                return const Center(child: LoadingAnimation());
              } else if (state is ListFailure) {
                return Center(child: Text(state.error));
              } else if (state is QuestionsLIstState) {
                final info = state.response["Data"]?[0];
                final List questions = info ?? [];

                // Separate selected and unselected
                final List selected =
                    questions
                        .where(
                          (q) => selectedQuestions.any(
                            (sel) =>
                                sel["QuestionnaireID"].toString() ==
                                q["ID"].toString(),
                          ),
                        )
                        .toList();

                final List unselected =
                    questions
                        .where(
                          (q) =>
                              !selectedQuestions.any(
                                (sel) =>
                                    sel["QuestionnaireID"].toString() ==
                                    q["ID"].toString(),
                              ),
                        )
                        .toList();

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

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
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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

                      // Selected Questions
                      if (selected.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Submitted Questions",
                              style: AppFonts.textprimary.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children:
                                  selected.map((q) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 14,
                                      ),
                                      child: questionItem(q, true),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),

                      const SizedBox(height: 20),

                      // Available Questions
                      if (unselected.isNotEmpty) ...[
                        Text(
                          "Available Questions",
                          style: AppFonts.textprimary.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children:
                              unselected.map((q) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: questionItem(q, false),
                                );
                              }).toList(),
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

  Widget questionItem(Map q, bool isSelected) {
    void toggleSelection() {
      setState(() {
        if (isSelected) {
          selectedQuestions.removeWhere(
            (sel) => sel["QuestionnaireID"].toString() == q["ID"].toString(),
          );

          context.read<DeleteBloc>().add(
            DeleteProfileItem(
              id: q["ID"].toString(),
              action: "reviewerque",
              isLang: false,
            ),
          );
        } else {
          selectedQuestions.add({
            "QuestionnaireID": q["ID"],
            "Question": q["Question"],
            "Answer": q["Answer"] ?? "",
          });

          context.read<QuestionsBloc>().add(
            CheckQuestionsEvent(
              qID: q["ID"].toString(),
              answer: true,
              comments: "",
            ),
          );

          CustomScaffoldMessenger.showCommonMessage(context, "Submitted");
        }
      });
    }

    return InkWell(
      onTap: toggleSelection,
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
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
