part of 'final_submission_bloc.dart';

sealed class FinalSubmissionState extends Equatable {
  const FinalSubmissionState();
  
  @override
  List<Object> get props => [];
}

final class FinalSubmissionInitial extends FinalSubmissionState {}
