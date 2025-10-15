abstract class AddEvent {}

//license
class AddLicense extends AddEvent {
  String licenseNumber;
  String issuingAuthority;
  String licenseType;
  String issueDate;
  String expiryDate;
  AddLicense(
    this.licenseNumber,
    this.licenseType,
    this.issueDate,
    this.issuingAuthority,
    this.expiryDate,
  );
}
