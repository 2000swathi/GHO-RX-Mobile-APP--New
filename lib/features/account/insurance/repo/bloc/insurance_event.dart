part of 'insurance_bloc.dart';

sealed class InsuranceEvent extends Equatable {
  const InsuranceEvent();

  @override
  List<Object> get props => [];
}

class FetchInsurance extends InsuranceEvent {}

//edit insurance
class EditInsuranceEvent extends InsuranceEvent {
  final String insuranceId;
  final String providerID;
  final String providerName;
  final String issueDate;
  final String expiryDate;

  const EditInsuranceEvent({
    required this.insuranceId,
    required this.providerID,
    required this.providerName,
    required this.issueDate,
    required this.expiryDate,
  });

  @override
  List<Object> get props => [
    insuranceId,
    providerID,
    providerName,
    issueDate,
    expiryDate,
  ];
}
