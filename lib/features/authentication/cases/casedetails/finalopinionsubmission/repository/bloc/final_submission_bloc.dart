import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/finalopinionsubmission/repository/bloc/final_submission_event.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/finalopinionsubmission/repository/final_submit_repo.dart';
part 'final_submission_state.dart';

class FinalSubmissionBloc
    extends Bloc<FinalSubmissionEvent, FinalSubmissionState> {
  SubmitCaseRepo repository;
  FinalSubmissionBloc({required this.repository})
    : super(FinalSubmissionInitial()) {
    on<SubmitCaseEvent>((event, emit) async {
      emit(FinalSubmissionLoading());
      try {
        final response = await repository.submitCase(event.saltID);
        if (response["Status"] == 1) {
          emit(
            FinalSubmissionSuccess(
              response["Data"][0][0]["msg"] ?? "Case submitted successfully.",
            ),
          );
        } else {
          emit(FinalSubmissionFailed(response["Info"] ?? "Unknown error"));
        }
      } on Exception catch (e) {
        emit(FinalSubmissionFailed(e.toString()));
      }
    });
  }
}
