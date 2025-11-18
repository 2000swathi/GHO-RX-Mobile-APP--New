import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/repository/bloc/q_and_a_event.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/questions/repository/q_and_a_save_repo.dart';

part 'q_and_a_state.dart';

class QAndABloc extends Bloc<QAndAEvent, QAndAState> {
  final QAndASaveRepo repository;
  QAndABloc({required this.repository}) : super(QAndAInitial()) {
    on<saveQandAEvent>((event, emit) async {
      emit(QAndALoading());
      try {
        final response = await repository.saveAnswersSpport(
          saltID: event.saltID,
          questID: event.questID,
          answer: event.answer,
          support: event.support,
        );
        if (response["Status"] == 1) {
          emit(QAndASuccess(response: response));
        } else {
          emit(QAndAFailure(message: response["Info"]));
        }
      } on Exception catch (e) {
        emit(QAndAFailure(message: e.toString()));
      }
    });
  }
}
