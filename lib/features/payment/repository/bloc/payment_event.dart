part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class FetchPaymentInfo extends PaymentEvent {
  String? dateValue;
  FetchPaymentInfo({this.dateValue});
}
