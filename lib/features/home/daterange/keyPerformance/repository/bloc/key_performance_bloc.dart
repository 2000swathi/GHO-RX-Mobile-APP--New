import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/bloc/key_performance_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/keyPerformance/repository/key_perfomance_repo.dart';

part 'key_performance_state.dart';

class KeyPerformanceBloc
    extends Bloc<KeyPerformanceEvent, KeyPerformanceState> {
  final KeyPerRepo repository;
  KeyPerformanceBloc({required this.repository})
    : super(KeyPerformanceInitial()) {
    on<KeyPerEvent>((event, emit) async {
      emit(KeyPerformanceLoading());
      try {
        final response = await repository.fetchPerformance(event.dateValue);
        if (response["Status"] == 1) {
          emit(KeyPerformanceSuccess(response: response));
        } else {
          emit(KeyPerformanceFailure(message: response["Info"]));
        }
      } catch (e) {
        emit(KeyPerformanceFailure(message: e.toString()));
      }
    });
  }
}
