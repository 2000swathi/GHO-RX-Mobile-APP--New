part of 'insurance_bloc.dart';

sealed class InsuranceState extends Equatable {
  const InsuranceState();

  @override
  List<Object> get props => [];
}

final class InsuranceInitial extends InsuranceState {}

// Loading state
class InsuranceLoading extends InsuranceState {}

//   insurance list
class Insurance extends InsuranceState {
  final InsuranceModel insuranceModel;

  const Insurance({required this.insuranceModel});

  @override
  List<Object> get props => [insuranceModel];
}

class InsuranceError extends InsuranceState {
  final String message;

  const InsuranceError({required this.message});

  @override
  List<Object> get props => [message];
}
