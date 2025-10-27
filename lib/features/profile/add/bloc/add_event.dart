abstract class AddEvent {}

//specialty
class AddSpecialty extends AddEvent {
  final String specialty;
  final String certifiedBoard;
  final String specialtyType;

  AddSpecialty({
    required this.specialty,
    required this.certifiedBoard,
    required this.specialtyType,
  });
}

//Accreditation
class AddAccrediation extends AddEvent {
  final String accreditationtype;
  final String accreditationbody;
  final String accreditationnumber;

  AddAccrediation({
    required this.accreditationtype,
    required this.accreditationbody,
    required this.accreditationnumber,
  });
}

//insurance
class AddInsurance extends AddEvent {
  final String providerID;
  final String providerName;
  final String issueDate;
  final String expiryDate;

  AddInsurance({
    required this.providerID,
    required this.providerName,
    required this.issueDate,
    required this.expiryDate,
  });
}

//license
class AddLicense extends AddEvent {
  final String licenseNumber;
  final int licenseType;
  final String issueDate;
  final String expiryDate;
  AddLicense({
    required this.licenseNumber,
    required this.licenseType,
    required this.issueDate,
    required this.expiryDate,
  });
}

//language
class AddLanguage extends AddEvent {
  final String language;
  final String proficiency;
  AddLanguage({required this.language, required this.proficiency});
}

//Bank info
class AddBankInfo extends AddEvent {
  final String accountType;
  final String routingNumber;
  final String accountNumber;
  final String holderName;

  AddBankInfo({
    required this.accountNumber,
    required this.accountType,
    required this.holderName,
    required this.routingNumber,
  });
}
