import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/earnings_repo.dart';

part 'earnings_event.dart';
part 'earnings_state.dart';

class EarningsBloc extends Bloc<EarningsEvent, EarningsState> {
  final EarningsRepo repository;
  EarningsBloc({required this.repository}) : super(EarningsInitial()) {
    on<FetchEarningsInfo>((event, emit) async {
      emit(EarningsLoading());
      try {
        final response = await repository.fetchEarnings(event.dateValue);
        if (response["Status"] == 1) {
          emit(EarningsSuccess(response: response));
        } else {
          emit(EarningsFailure(message: response["Info"]));
        }
      } catch (e) {
        emit(EarningsFailure(message: e.toString()));
      }
    });
  }
}
