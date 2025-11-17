part of 'earnings_bloc.dart';

sealed class EarningsState extends Equatable {
  const EarningsState();

  @override
  List<Object> get props => [];
}

final class EarningsInitial extends EarningsState {}

final class EarningsLoading extends EarningsState {}

final class EarningsSuccess extends EarningsState {
  final Map<String, dynamic> response;

  const EarningsSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

final class EarningsFailure extends EarningsState {
  final String message;

  const EarningsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
