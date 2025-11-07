part of 'open_closed_bloc.dart';

sealed class OpenClosedState extends Equatable {
  const OpenClosedState();

  @override
  List<Object> get props => [];
}

final class OpenClosedInitial extends OpenClosedState {}

final class OpenClosedLoading extends OpenClosedState {}

//open cases
final class OpenCaseLoaded extends OpenClosedState {
  final List<OpenCaseModel> openCases;
  const OpenCaseLoaded({required this.openCases});
  @override
  List<Object> get props => [openCases];
}

//closed cases
final class ClosedCaseLoaded extends OpenClosedState {
  final List<ClosedCaseModel> closedcases;
  const ClosedCaseLoaded({required this.closedcases});
  @override
  List<Object> get props => [closedcases];
}

final class OpenCloseError extends OpenClosedState {
  final String message;
  const OpenCloseError({required this.message});
  @override
  List<Object> get props => [message];
}
