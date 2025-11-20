part of 'insurance_bloc.dart';

sealed class InsuranceState extends Equatable {
  const InsuranceState();

  @override
  List<Object> get props => [];
}

final class InsuranceInitial extends InsuranceState {}

// Loading state
class InsuranceLoading extends InsuranceState {}
class InsuranceAddLoading extends InsuranceState {}
class InsuranceEditLoading extends InsuranceState {}

//   insurance get list
class InsuranceGetState extends InsuranceState {
  final InsuranceModel insuranceModel;

  const InsuranceGetState({required this.insuranceModel});

  @override
  List<Object> get props => [insuranceModel];
}
final class InsuranceSuccess extends InsuranceState {
  final String message;

  const InsuranceSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class InsuranceError extends InsuranceState {
  final String message;

  const InsuranceError({required this.message});

  @override
  List<Object> get props => [message];
}
