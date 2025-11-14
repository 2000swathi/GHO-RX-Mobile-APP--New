import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ghorx_mobile_app_new/features/payment/repository/graph/payment_graph_repo.dart';

part 'payment_graph_event.dart';
part 'payment_graph_state.dart';

class PaymentGraphBloc extends Bloc<PaymentGraphEvent, PaymentGraphState> {
  final PaymentGraphRepo repository;
  PaymentGraphBloc({required this.repository}) : super(PaymentGraphInitial()) {
    on<FetchPaymentGraphInfo>((event, emit) async {
      emit(PaymentGraphLoading());
      try {
        final response = await repository.fetchPaymentslist(event.monthId);
        if (response["Status"] == 1) {
          emit(PaymentGraphSuccess(response: response));
        } else {
          emit(PaymentGraphFailure(error: response["Info"]));
        }
      } catch (e) {
        emit(PaymentGraphFailure(error: e.toString()));
      }
    });
  }
}
