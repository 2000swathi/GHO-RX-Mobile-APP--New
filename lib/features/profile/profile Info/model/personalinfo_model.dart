
class PersonalInfoModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final int countryID;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String zipCode;
  final String birthDate;
  final String countryName;
  final String imageUrl;

  PersonalInfoModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.countryID,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.birthDate,
    required this.countryName,
    required this.imageUrl,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    return PersonalInfoModel(
      firstName: json['FirstName'] ?? "",
      lastName: json['LastName'] ?? "",
      phone: json['Phone'] ?? "",
      email: json['eMail'] ?? "",
      countryID: json['CountryID'] ?? 0,
      address1: json['Address1'] ?? "",
      address2: json['Address2'] ?? "",
      city: json['City'] ?? "",
      state: json['State'] ?? "",
      zipCode: json['ZipCode'] ?? "",
      birthDate: json['BirthDate'] ?? "",
      countryName: json['CountryName'] ?? "",
      imageUrl: json['_Url'] ?? "",
    );
  }
}
