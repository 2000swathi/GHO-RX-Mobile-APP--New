class IsuuingAuthResponseModel {
  final int status;
  final String error;
  final String info;
  final List<List<LAuthorityList>> data;

  IsuuingAuthResponseModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory IsuuingAuthResponseModel.fromJson(Map<String, dynamic> json) {
    return IsuuingAuthResponseModel(
      status: json['Status'],
      error: json['Error'],
      info: json['Info'],
      data:(json['Data'] as List<dynamic>? ?? [])
        .map((innerList) => (innerList as List<dynamic>)
            .map((item) => LAuthorityList.fromJson(item))
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

class LAuthorityList {
  final String authorityID;
  final String authorityName;

  LAuthorityList({
    required this.authorityID,
    required this.authorityName,
  });

  factory LAuthorityList.fromJson(Map<String, dynamic> json) {
    return LAuthorityList(
      authorityID: json['DataValue']??"",
      authorityName: json['DisplyText']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DataValue': authorityID,
      'DisplyText': authorityName,
    };
  }
}
