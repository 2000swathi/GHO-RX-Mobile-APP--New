import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/account/questionnaire/repo/ques_repo.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionnaireRepo repository;

  QuestionsBloc({required this.repository}) : super(QuestionsInitial()) {
    on<FetchQuestionsEvent>(_onFetchQuestions);
  }

  Future<void> _onFetchQuestions(
    FetchQuestionsEvent event,
    Emitter<QuestionsState> emit,
  ) async {
    emit(QuestionsLoading(event.qID));

    try {
      final response = await repository.AnswerCheck(
        event.qID,
        event.answer,
        event.comments,
      );

      emit(
        QuestionsLoaded(
          message: response["Data"]?[0]?[0]?["msg"] ?? "",
          questionId: event.qID,
        ),
      );
    } catch (e) {
      emit(QuestionsError(message: e.toString(), questionId: event.qID));
    }
  }
}
