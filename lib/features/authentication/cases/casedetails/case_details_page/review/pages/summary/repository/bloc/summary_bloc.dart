import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/case_details_page/review/pages/summary/repository/bloc/summary_event.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/casedetails/case_details_page/review/pages/summary/repository/summary_reo.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final SummaryReo repository;

  SummaryBloc({required this.repository}) : super(SummaryInitial()) {
    on<summarycaseEvent>((event, emit) async {
      emit(SummaryLoading());
      try {
        final response = await repository.saveSummary(
          event.saltID,
          event.summary,
        );
        if (response["Status"] == 1) {
          emit(SummarySuccess(response: response));
        } else {
          emit(SummaryFailure(message: response["Info"]));
        }
      } on Exception catch (e) {
        emit(SummaryFailure(message: e.toString()));
      }
    });
  }
}
