part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent({required String dateValue});

  @override
  List<Object> get props => [];
}

class FetchPaymentInfo extends PaymentEvent {
  String dateValue;
  FetchPaymentInfo({required this.dateValue}) : super(dateValue: '');
}
