part of 'payment_graph_bloc.dart';

sealed class PaymentGraphState extends Equatable {
  const PaymentGraphState();

  @override
  List<Object> get props => [];
}

final class PaymentGraphInitial extends PaymentGraphState {}

final class PaymentGraphLoading extends PaymentGraphState {}

final class PaymentGraphSuccess extends PaymentGraphState {
  final Map<String, dynamic> response;
  const PaymentGraphSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class PaymentGraphFailure extends PaymentGraphState {
  final String error;
  const PaymentGraphFailure({required this.error});
  @override
  List<Object> get props => [error];
}
