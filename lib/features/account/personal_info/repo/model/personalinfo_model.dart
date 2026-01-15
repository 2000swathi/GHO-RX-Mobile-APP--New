class PersonalInfoModel {
  final String id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String gender;
  final String phone;
  final String workPhone;
  final String email;
  final String npi;
  final String nationality;

  final String address1;
  final String address2;
  final String countryName;
  final int countryID;
  final String state;
  final String city;
  final String zipCode;

  final bool approved;
  final String boardCertified;
  final String activePractice;
  final String activeTeaching;
  final String activePublishing;
  final String activeResearch;
  final String activeSurgeon;

  final String imageUrl;
  final int fileID;

  PersonalInfoModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.workPhone,
    required this.email,
    required this.npi,
    required this.nationality,
    required this.address1,
    required this.address2,
    required this.countryName,
    required this.countryID,
    required this.state,
    required this.city,
    required this.zipCode,
    required this.approved,
    required this.boardCertified,
    required this.activePractice,
    required this.activeTeaching,
    required this.activePublishing,
    required this.activeResearch,
    required this.activeSurgeon,
    required this.imageUrl,
    required this.fileID,
  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) {
    final fullName = (json['FullName'] ?? '').toString().trim().split(' ');

    return PersonalInfoModel(
      id: json['id'] ?? '',
      firstName: fullName.isNotEmpty ? fullName.first : '',
      lastName: fullName.length > 1 ? fullName.sublist(1).join(' ') : '',
      birthDate: json['DOB'] ?? '',
      gender: json['Gender'] ?? '',
      phone: json['Phone'] ?? '',
      workPhone: json['WorkPhone'] ?? '',
      email: json['eMail'] ?? '',
      npi: json['NPI'] ?? '',
      nationality: json['Nationality'] ?? '',
      address1: _cleanAddress(json['FullAddress'] ?? ''),
      address2: '',
      countryName: json['Nationality'] ?? '',
      countryID:
          json['CountryID'] is int
              ? json['CountryID']
              : int.tryParse(json['CountryID']?.toString() ?? '0') ?? 0,
      state: '',
      city: '',
      zipCode: '',

      approved: json['Approved'] == 1,
      boardCertified: json['BoardCertified'] ?? '',
      activePractice: json['ActivePractice'] ?? '',
      activeTeaching: json['ActiveTeaching'] ?? '',
      activePublishing: json['ActivePublishing'] ?? '',
      activeResearch: json['ActiveResearch'] ?? '',
      activeSurgeon: json['ActiveSurgon'] ?? '',

      imageUrl: json['ImageUrl'] ?? '',
      fileID:
          json['FileID'] is int
              ? json['FileID']
              : int.tryParse(json['FileID']?.toString() ?? '0') ?? 0,
    );
  }

  /// Cleans up address by removing trailing commas and extra whitespace
  static String _cleanAddress(String address) {
    // Remove trailing commas and whitespace
    return address
        .split(',')
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .join(', ')
        .trim();
  }
}
