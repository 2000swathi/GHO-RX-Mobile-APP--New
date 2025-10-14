part of 'open_closed_bloc.dart';

sealed class OpenClosedState extends Equatable {
  const OpenClosedState();

  @override
  List<Object> get props => [];
}

final class OpenClosedInitial extends OpenClosedState {}

final class OpenClosedLoading extends OpenClosedState {}

final class OpencaseState extends OpenClosedState {
  @override
  List<Object> get props => [];
}

final class OpenCloseError extends OpenClosedState {
  final String message;
  const OpenCloseError({required this.message});
  @override
  List<Object> get props => [message];
}
