part of 'month_bloc.dart';

sealed class MonthState extends Equatable {
  const MonthState();

  @override
  List<Object> get props => [];
}

final class MonthInitial extends MonthState {}

final class MonthLoading extends MonthState {}

final class MonthScuccess extends MonthState {
  final Map<String, dynamic> response;
  const MonthScuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class MonthFailure extends MonthState {
  final String error;
  const MonthFailure({required this.error});
  @override
  List<Object> get props => [error];
}
