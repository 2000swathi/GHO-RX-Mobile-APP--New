part of 'payment_graph_bloc.dart';

sealed class PaymentGraphEvent extends Equatable {
  const PaymentGraphEvent();

  @override
  List<Object> get props => [];
}

class FetchPaymentGraphInfo extends PaymentGraphEvent {
  int monthId;
  FetchPaymentGraphInfo({required this.monthId});
}
