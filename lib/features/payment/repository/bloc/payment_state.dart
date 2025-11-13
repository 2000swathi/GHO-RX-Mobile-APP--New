part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentSuccess extends PaymentState {
  final Map<String, dynamic> response;
  const PaymentSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class PaymentFailure extends PaymentState {
  final String error;
  const PaymentFailure({required this.error});
  @override
  List<Object> get props => [error];
}
