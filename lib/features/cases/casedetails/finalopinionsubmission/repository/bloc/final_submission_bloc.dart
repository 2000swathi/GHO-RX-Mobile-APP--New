import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'final_submission_event.dart';
part 'final_submission_state.dart';

class FinalSubmissionBloc extends Bloc<FinalSubmissionEvent, FinalSubmissionState> {
  FinalSubmissionBloc() : super(FinalSubmissionInitial()) {
    on<FinalSubmissionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
