abstract class AddEvent {}

//license
class AddLicense extends AddEvent {
 AddLicense();
}

//specialty
class AddSpecialty extends AddEvent {
  final String specialty;
  final String certifiedBoard;
  final String specialtyType;

 AddSpecialty(
  {
    required this.specialty,
    required this.certifiedBoard,
    required this.specialtyType,
  }
 );
}

//Accreditation
class AddAccrediation extends AddEvent{
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
    required this.expiryDate
  });
}
