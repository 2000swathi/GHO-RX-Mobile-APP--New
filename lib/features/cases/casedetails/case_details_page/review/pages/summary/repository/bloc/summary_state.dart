part of 'summary_bloc.dart';

sealed class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

final class SummaryInitial extends SummaryState {}

final class SummaryLoading extends SummaryState {}
// successs
final class SummarySuccess extends SummaryState {
  final Map<String, dynamic> response;
  const SummarySuccess({required this.response});

  @override
  List<Object> get props => [response];
}
// failure
final class SummaryFailure extends SummaryState {
  final String message;

  const SummaryFailure({required this.message});

  @override
  List<Object> get props => [message];
}
