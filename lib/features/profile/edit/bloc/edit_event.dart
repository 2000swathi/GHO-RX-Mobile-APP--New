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

//Edit License Event
class EditLicenseEvent extends EditEvent {
  final String licenseNumber;
  final String issuingAuthority;
  final String licenseType;
  final String issueDate;
  final String expiryDate;
  final String id;

  const EditLicenseEvent({
    required this.licenseNumber,
    required this.issuingAuthority,
    required this.licenseType,
    required this.issueDate,
    required this.expiryDate,
    required this.id,
  });

  @override
  List<Object> get props => [
    licenseNumber,
    issuingAuthority,
    licenseType,
    issueDate,
    expiryDate,
    id,
  ];
}

// Edit language event

class EditLanguageEvent extends EditEvent {
  final String language;
  final String proficiency;
  final String id;

  const EditLanguageEvent({
    required this.language,
    required this.id,
    required this.proficiency,
  });

  @override
  List<Object> get props => [language, proficiency, id];
}

//Edit Bank Event
class EditBankInfoEvent extends EditEvent {
  final String accountType;
  final String routingNumber;
  final String id;
  final String accountNumber;
  final String holderName;

  const EditBankInfoEvent({
    required this.accountType,
    required this.id,
    required this.routingNumber,
    required this.accountNumber,
    required this.holderName,
  });

  @override
  List<Object> get props => [
    accountType,
    routingNumber,
    id,
    accountNumber,
    holderName,
  ];
}
