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
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
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
  final String licenseTypeID;
  final String licenseTypeID;
  final String licenseTypeName;

  LicenseList({required this.licenseTypeID, required this.licenseTypeName});

  factory LicenseList.fromJson(Map<String, dynamic> json) {
    return LicenseList(
      licenseTypeID: json['DataValue'] ?? '',
      licenseTypeName: json['DisplyText'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DataValue': licenseTypeID, 
    'DisplyText': licenseTypeName};
  }
}
