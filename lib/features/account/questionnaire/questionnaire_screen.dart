import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_fonts.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/bloc/list_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/widget/questions_card.dart';
import 'package:ghorx_mobile_app_new/features/account/widget/custom_profile_appbar.dart';

class QuestionnaireScreen extends StatefulWidget {
  QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ListBloc>().add(FetchQuestList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAccountAppBar(title: "Questionnaire"),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 22, right: 22, bottom: 30),
      //   child: CustomButton(text: "Submit Questionnaire", onPressed: () {}),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<ListBloc, ListState>(
          builder: (context, state) {
            if (state is ListLoading) {
              return Center(child: LoadingAnimation());
            } else if (state is ListFailure) {
              return Center(child: Text(state.error));
            } else if (state is QuestionsLIstState) {
              final info = state.response["Data"]?[0];
              final List questions = info ?? [];

              return Column(
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
                        Icon(Icons.info_outline, color: AppColors.primarycolor),
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

                  Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final q = questions[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: QuestionCard(
                            questionText: q["Question"] ?? "",
                            questionId: q["ID"].toString(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(child: Text("Invalid State"));
          },
        ),
      ),
    );
  }
}
