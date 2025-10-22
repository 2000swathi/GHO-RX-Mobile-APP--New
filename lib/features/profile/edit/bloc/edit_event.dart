part of 'edit_bloc.dart';

sealed class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object> get props => [];
}

class EditInfoEvent extends EditEvent {
  final Map<String, dynamic> data;

  const EditInfoEvent({required this.data});

  @override
  List<Object> get props => [data];
}

class EditSpecialtyEvent extends EditEvent {
  final String specialtyId;
  final String specialty;
  final String certifiedBoard;
  final String specialtyType;
  const EditSpecialtyEvent({
    required this.specialtyId,
    required this.specialty,
    required this.certifiedBoard,
    required this.specialtyType,
  });

  @override
  List<Object> get props => [
    specialtyId,
    specialty,
    certifiedBoard,
    specialtyType,
  ];
}
// accreditation
class EditAcreditationEvent extends EditEvent {
  final String accreditationId;
  final String accreditationtype;
  final String accreditationbody;
  final String accreditationnumber;

  const EditAcreditationEvent({
    required this.accreditationId,
    required this.accreditationtype,
    required this.accreditationbody,
    required this.accreditationnumber,
  });

  @override
  List<Object> get props => [
    accreditationId,
    accreditationtype,
    accreditationbody,
    accreditationnumber,
  ];
}

//insurance
class EditInsuranceEvent extends EditEvent {
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
    required this.expiryDate
  });

  @override
  List<Object> get props => [
    insuranceId,
    providerID,
    providerName,
    issueDate,
    expiryDate
  ];
}

