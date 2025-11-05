part of 'attest_bloc.dart';

sealed class AttestState extends Equatable {
  const AttestState();

  @override
  List<Object> get props => [];
}

final class AttestInitial extends AttestState {}

final class AttestLoading extends AttestState {}
//success
final class AttestSuccessState extends AttestState {
  final Map<String, dynamic> response;
  const AttestSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
//failure
final class AttestFailedState extends AttestState {
  final String error;

  const AttestFailedState(this.error);

  @override
  List<Object> get props => [error];
}
