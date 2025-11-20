part of 'license_bloc.dart';

sealed class LicenseEvent extends Equatable {
  const LicenseEvent();

  @override
  List<Object> get props => [];
}

class FetchLicense extends LicenseEvent {}
//license
class AddLicenseEvent extends LicenseEvent {
  final String licenseNumber;
  final String licenseType; 
  final String issueDate;
  final String expiryDate;
  final String issuingAuthority;
  AddLicenseEvent({
    required this.licenseNumber,
    required this.licenseType,
    required this.issueDate,
    required this.expiryDate,
    required this.issuingAuthority,
  });
}

//Edit License Event
class EditLicenseEvent extends LicenseEvent {
  final String licenseNumber;
  final String licenseType;
  final String issueDate;
  final String expiryDate;
  final String id;
  final String issuingAuthority;

  const EditLicenseEvent({
    required this.licenseNumber,
    required this.licenseType,
    required this.issueDate,
    required this.expiryDate,
    required this.id,
    required this.issuingAuthority,
  });

  @override
  List<Object> get props => [
    licenseNumber,
    licenseType,
    issueDate,
    expiryDate,
    id,
    issuingAuthority,
  ];
}
