class LicenseAuthorityModel {
  final int status;
  final String error;
  final String info;
  final List<List<Authority>> data;

  LicenseAuthorityModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory LicenseAuthorityModel.fromJson(Map<String, dynamic> json) {
    return LicenseAuthorityModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data:
          (json['Data'] as List<dynamic>? ?? [])
              .map(
                (innerList) =>
                    (innerList as List<dynamic>)
                        .map((e) => Authority.fromJson(e))
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Status': status,
    'Error': error,
    'Info': info,
    'Data':
        data
            .map((innerList) => innerList.map((e) => e.toJson()).toList())
            .toList(),
  };
}

class Authority {
  final int issuingAuthorityID;
  final String issuingAuthority;

  Authority({required this.issuingAuthorityID, required this.issuingAuthority});

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
      issuingAuthorityID: json['IssuingAuthorityID'] ?? 0,
      issuingAuthority: json['IssuingAuthority'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'IssuingAuthorityID': issuingAuthorityID,
    'IssuingAuthority': issuingAuthority,
  };
}
