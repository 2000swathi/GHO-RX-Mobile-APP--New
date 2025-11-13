import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/home/repository/bloc/date_range_event.dart';
import 'package:ghorx_mobile_app_new/features/home/daterange/repository/date_range_repo.dart';

part 'date_range_state.dart';

class DateRangeBloc extends Bloc<DateRangeEvent, DateRangeState> {
  final DateRangeRepo repository;
  DateRangeBloc({required this.repository}) : super(DateRangeInitial()) {
    on<FetchDateRangeInfo>(_onFetchDateRangePage);
  }

  Future<void> _onFetchDateRangePage(
    FetchDateRangeInfo event,
    Emitter<DateRangeState> emit,
  ) async {
    emit(DateListPageLoading());

    try {
      final response = await repository.fetchDateRange();
      if (response["Status"] == 1) {
        emit(DateRangeInfoState(response: response));
      } else {
        emit(ListPageError(message: response["Info"]));
      }
    } catch (e) {
      emit(ListPageError(message: e.toString()));
    }
  }
}
