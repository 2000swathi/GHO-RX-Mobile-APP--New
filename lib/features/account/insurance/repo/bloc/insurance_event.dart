part of 'insurance_bloc.dart';

sealed class InsuranceEvent extends Equatable {
  const InsuranceEvent();

  @override
  List<Object> get props => [];
}

class FetchInsurance extends InsuranceEvent {}
