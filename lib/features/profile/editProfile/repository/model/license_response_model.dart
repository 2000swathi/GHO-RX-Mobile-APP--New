class LicenseListResponseModel {
  final int status;
  final String error;
  final String info;
  final List<List<LicenseList>> data;

  LicenseListResponseModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory LicenseListResponseModel.fromJson(Map<String, dynamic> json) {
    return LicenseListResponseModel(
      status: json['Status'],
      error: json['Error'],
      info: json['Info'],
      data:
          (json['Data'] as List<dynamic>? ?? [])
              .map(
                (innerList) =>
                    (innerList as List<dynamic>)
                        .map((item) => LicenseList.fromJson(item))
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data':
          data
              .map((innerList) => innerList.map((e) => e.toJson()).toList())
              .toList(),
    };
  }
}

class LicenseList {
  final int licenseTypeID;
  final String licenseTypeName;
  final int issuingAuthorityId;
  final String issuingAuthority;

  LicenseList({
    required this.licenseTypeID,
    required this.licenseTypeName,
    required this.issuingAuthorityId,
    required this.issuingAuthority,
  });

  factory LicenseList.fromJson(Map<String, dynamic> json) {
    return LicenseList(
      licenseTypeID: json['LicenseTypeID'],
      licenseTypeName: json['LicenseType'],
      issuingAuthorityId: json['IssuingAuthorityID'],
      issuingAuthority: json['IssuingAuthority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SpecialtyID': licenseTypeID,
      'SpecialtyName': licenseTypeName,
      'IssuingAuthorityID': issuingAuthorityId,
      'IssuingAuthority': issuingAuthority,
    };
  }
}
