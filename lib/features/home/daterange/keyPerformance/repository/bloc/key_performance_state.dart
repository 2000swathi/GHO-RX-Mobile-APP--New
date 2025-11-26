part of 'key_performance_bloc.dart';

sealed class KeyPerformanceState extends Equatable {
  const KeyPerformanceState();

  @override
  List<Object> get props => [];
}

final class KeyPerformanceInitial extends KeyPerformanceState {}

final class KeyPerformanceLoading extends KeyPerformanceState {}

final class KeyPerformanceSuccess extends KeyPerformanceState {
  final Map<String, dynamic> response;

  const KeyPerformanceSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class KeyPerformanceFailure extends KeyPerformanceState {
  final String message;

  const KeyPerformanceFailure({required this.message});

  @override
  List<Object> get props => [message];
}
