part of 'final_submission_bloc.dart';

sealed class FinalSubmissionState extends Equatable {
  const FinalSubmissionState();

  @override
  List<Object> get props => [];
}

final class FinalSubmissionInitial extends FinalSubmissionState {}

final class FinalSubmissionLoading extends FinalSubmissionState {}

final class FinalSubmissionSuccess extends FinalSubmissionState {
  final String message;
  const FinalSubmissionSuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class FinalSubmissionFailed extends FinalSubmissionState {
  final String error;

  const FinalSubmissionFailed(this.error);

  @override
  List<Object> get props => [error];
}
