import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/loading_animation.dart';
import 'package:ghorx_mobile_app_new/core/constants/app_colors.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/repo/bloc/questions_bloc.dart';

class QuestionCard extends StatefulWidget {
  final String questionText;
  final String questionId;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.questionId,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsBloc, QuestionsState>(
      listenWhen: (previous, current) {
        if (current is QuestionsLoaded) {
          return current.questionId == widget.questionId;
        }
        if (current is QuestionsError) {
          return current.questionId == widget.questionId;
        }
        return false;
      },
      listener: (context, state) {
        if (state is QuestionsLoaded) {
          CustomScaffoldMessenger.showSuccessMessage(context, state.message);
        } else if (state is QuestionsError) {
          CustomScaffoldMessenger.showErrorMessage(context, state.message);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Text
              Expanded(
                child: Text(
                  widget.questionText,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),

              //  Checkbox
              BlocBuilder<QuestionsBloc, QuestionsState>(
                builder: (context, state) {
                  if (state is QuestionsLoading &&
                      state.questionId == widget.questionId) {
                    return const LoadingAnimation();
                  }

                  if (state is QuestionsLoaded &&
                      state.questionId == widget.questionId) {
                    isChecked = true;
                  }

                  if (state is QuestionsError &&
                      state.questionId == widget.questionId) {
                    return Icon(Icons.error, color: Colors.red[400]);
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });

                      if (!isChecked) return;

                      context.read<QuestionsBloc>().add(
                        CheckQuestionsEvent(
                          qID: widget.questionId,
                          answer: true,
                          comments: "",
                        ),
                      );
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color:
                            isChecked ? AppColors.primarycolor : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color:
                              isChecked ? AppColors.primarycolor : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child:
                          isChecked
                              ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              )
                              : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
