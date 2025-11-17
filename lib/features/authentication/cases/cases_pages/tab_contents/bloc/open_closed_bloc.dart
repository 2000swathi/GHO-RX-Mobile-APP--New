import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/cases_pages/tab_contents/repository/model/closed_case_model.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/cases_pages/tab_contents/repository/model/open_case_model.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/cases_pages/tab_contents/repository/open_closed_repo.dart';

part 'open_closed_event.dart';
part 'open_closed_state.dart';

class OpenClosedBloc extends Bloc<OpenClosedEvent, OpenClosedState> {
  final OpenClosedRepository repository;
  OpenClosedBloc({required this.repository}) : super(OpenClosedInitial()) {
    on<FetchOpenCases>(_onFetchOpenCases);
    on<FetchClosedCases>(_onFetchClosedCases);
  }
  //open cases
  Future<void> _onFetchOpenCases(
    FetchOpenCases event,
    Emitter<OpenClosedState> emit,
  ) async {
    emit(OpenClosedLoading());

    try {
      final openCases = await repository.fetchOpenCases();
      emit(OpenCaseLoaded(openCases: openCases));
    } catch (e) {
      emit(OpenCloseError(message: e.toString()));
    }
  }

  //closed cases
  Future<void> _onFetchClosedCases(
    FetchClosedCases event,
    Emitter<OpenClosedState> emit,
  ) async {
    emit(OpenClosedLoading());

    try {
      final closedCases = await repository.fetchClosedCases();
      emit(ClosedCaseLoaded(closedcases: closedCases));
    } catch (e) {
      emit(OpenCloseError(message: e.toString()));
    }
  }
}
