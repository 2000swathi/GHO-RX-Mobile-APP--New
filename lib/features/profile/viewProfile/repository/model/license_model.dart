class LicenseModel {
  final int status;
  final String? error;
  final String? info;
  final List<LicenseData> data; 

  LicenseModel({
    required this.status,
    this.error,
    this.info,
    required this.data,
  });

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    final nestedList = json['Data'] as List<dynamic>;
    final flatList = nestedList.expand((inner) => inner as List<dynamic>).toList();

    return LicenseModel(
      status: json['Status'] ?? 0,
      error: json['Error'],
      info: json['Info'],
      data: flatList.map((item) => LicenseData.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'Status': status,
        'Error': error,
        'Info': info,
        'Data': [data.map((item) => item.toJson()).toList()],
      };
}

class LicenseData {
  final int id;
  final String licenseNumber;
  final String issuingAuthority;
  final String specialtyID;
  final String licenseExpertiseType;
  final String licenseTypeID;
  final String licenseType;
  final String duration;
  final String issueDate;
  final String expiryDate;

  LicenseData({
    required this.id,
    required this.licenseNumber,
    required this.issuingAuthority,
    required this.specialtyID,
    required this.licenseExpertiseType,
    required this.licenseTypeID,
    required this.licenseType,
    required this.duration,
    required this.issueDate,
    required this.expiryDate,
  });

  factory LicenseData.fromJson(Map<String, dynamic> json) => LicenseData(
        id: json['id'] ?? 0,
        licenseNumber: json['LicenseNumber'] ?? '',
        issuingAuthority: json['IssuingAuthority'] ?? '',
        specialtyID: json['SpecialtyID'] ?? '',
        licenseExpertiseType: json['LicenseExpertiseType'] ?? '',
        licenseTypeID: json['LicenseTypeID'] ?? '',
        licenseType: json['LicenseType'] ?? '',
        duration: json['Duration'] ?? '',
        issueDate: json['IssueDate'] ?? '',
        expiryDate: json['ExpiryDate'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'LicenseNumber': licenseNumber,
        'IssuingAuthority': issuingAuthority,
        'SpecialtyID': specialtyID,
        'LicenseExpertiseType': licenseExpertiseType,
        'LicenseTypeID': licenseTypeID,
        'LicenseType': licenseType,
        'Duration': duration,
        'IssueDate': issueDate,
        'ExpiryDate': expiryDate,
      };
}
