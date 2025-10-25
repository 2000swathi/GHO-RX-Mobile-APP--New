class CertifiedResponseModel {
  final int status;
  final String error;
  final String info;
  final List<List<CertifiedList>> data;

  CertifiedResponseModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory CertifiedResponseModel.fromJson(Map<String, dynamic> json) {
    return CertifiedResponseModel(
      status: json['Status'],
      error: json['Error'],
      info: json['Info'],
      data:(json['Data'] as List<dynamic>? ?? [])
        .map((innerList) => (innerList as List<dynamic>)
            .map((item) => CertifiedList.fromJson(item))
            .toList())
        .toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data': data
          .map((innerList) => innerList.map((e) => e.toJson()).toList())
          .toList(),
    };
  }
}

class CertifiedList {
  final int certifiedID;
  final String certifiedName;

  CertifiedList({
    required this.certifiedID,
    required this.certifiedName,
  });

  factory CertifiedList.fromJson(Map<String, dynamic> json) {
    return CertifiedList(
      certifiedID: json['certificationbodyid'] ?? 0,
      certifiedName: json['CertifiedBoard'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'certificationbodyid': certifiedID,
      'CertifiedBoard': certifiedName,
    };
  }
}
