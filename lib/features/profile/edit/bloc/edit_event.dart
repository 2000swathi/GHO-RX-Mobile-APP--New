part of 'edit_bloc.dart';

sealed class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object> get props => [];
}

// class EditInfoEvent extends EditEvent {
//   final Map<String, dynamic> data;

//   const EditInfoEvent({required this.data});

//   @override
//   List<Object> get props => [data];
// }

//specialty
class EditSpecialtyEvent extends EditEvent {
  final String id;
  final String specialtyId;
  final String certifiedBoard;
  final String specialtyType;
  const EditSpecialtyEvent({
    required this.id,
    required this.specialtyId,
    required this.certifiedBoard,
    required this.specialtyType,
  });

  @override
  List<Object> get props => [
        id,
        specialtyId,
        certifiedBoard,
        specialtyType,
      ];
}

// // accreditation
// class EditAcreditationEvent extends EditEvent {
//   final String accreditationId;
//   final String accreditationtype;
//   final String accreditationbody;
//   final String accreditationnumber;

//   const EditAcreditationEvent({
//     required this.accreditationId,
//     required this.accreditationtype,
//     required this.accreditationbody,
//     required this.accreditationnumber,
//   });

//   @override
//   List<Object> get props => [
//     accreditationId,
//     accreditationtype,
//     accreditationbody,
//     accreditationnumber,
//   ];
// }

// //insurance
// class EditInsuranceEvent extends EditEvent {
//   final String insuranceId;
//   final String providerID;
//   final String providerName;
//   final String issueDate;
//   final String expiryDate;

//   const EditInsuranceEvent({
//     required this.insuranceId,
//     required this.providerID,
//     required this.providerName,
//     required this.issueDate,
//     required this.expiryDate,
//   });

//   @override
//   List<Object> get props => [
//     insuranceId,
//     providerID,
//     providerName,
//     issueDate,
//     expiryDate,
//   ];
// }

// //Edit License Event
// class EditLicenseEvent extends EditEvent {
//   final String licenseNumber;
//   final String licenseType;
//   final String issueDate;
//   final String expiryDate;
//   final String id;
//   final String issuingAuthority;


//   const EditLicenseEvent({
//     required this.licenseNumber,
//     required this.licenseType,
//     required this.issueDate,
//     required this.expiryDate,
//     required this.id,
//     required this.issuingAuthority,
//   });

//   @override
//   List<Object> get props => [
//         licenseNumber,
//         licenseType,
//         issueDate,
//         expiryDate,
//         id,
//         issuingAuthority,
//       ];
// }

// Edit language event

// class EditLanguageEvent extends EditEvent {
//   final String language;
//   final String proficiency;
//   final String id;

//   const EditLanguageEvent({
//     required this.language,
//     required this.id,
//     required this.proficiency,
//   });

//   @override
//   List<Object> get props => [language, proficiency, id];
// }

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
