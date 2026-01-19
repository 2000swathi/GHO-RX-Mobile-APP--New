import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/repo/ques_repo.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionnaireRepo repository;

  QuestionsBloc({required this.repository}) : super(QuestionsInitial()) {
    on<AddQuestionsEvent>(_onAddQuestions);
    on<FetchQuestionsEvent>(_onFetchQuestions);
  }

  Future<void> _onAddQuestions(
    AddQuestionsEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    emit(QuestionsLoading(event.id));

    try {
      final response = await repository.answerCheck(event.id,event.value);
      if (response['Status'] == 1) {
        add(FetchQuestionsEvent());
      } else {
        emit(
          QuestionsError(
            message: response['Info'] ?? "Failed to add question",
            questionId: event.id,
          ),
        );
      }
    } catch (e) {
      emit(QuestionsError(message: e.toString(), questionId: event.id));
    }
  }

  Future<void> _onFetchQuestions(
    FetchQuestionsEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    emit(QuestionsLoading(""));

    try {
      final response = await repository.fetchQuestionnaire();
      emit(Questionsgetting(response));
    } catch (e) {
      emit(QuestionsError(message: e.toString(), questionId: ""));
    }
  }
}
