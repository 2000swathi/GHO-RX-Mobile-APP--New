import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/month/month_repo.dart';

part 'month_event.dart';
part 'month_state.dart';

class MonthBloc extends Bloc<MonthEvent, MonthState> {
  final MonthRepo repository;
  MonthBloc({required this.repository}) : super(MonthInitial()) {
    on<FetchMonthEvent>((event, emit) async {
      emit(MonthLoading());
      try {
        final response = await repository.fetchMonths();
        if (response["Status"] == 1) {
          emit(MonthScuccess(response: response));
        } else {
          emit(MonthFailure(error: response["Info"]));
        }
      } catch (e) {
        emit(MonthFailure(error: e.toString()));
      }
    });
  }
}
