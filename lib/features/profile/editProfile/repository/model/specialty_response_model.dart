class SpecialtyResponseModel {
  final int status;
  final String error;
  final String info;
  final List<List<SpecialtyList>> data;

  SpecialtyResponseModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory SpecialtyResponseModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyResponseModel(
      status: json['Status'],
      error: json['Error'],
      info: json['Info'],
      data:(json['Data'] as List<dynamic>? ?? [])
        .map((innerList) => (innerList as List<dynamic>)
            .map((item) => SpecialtyList.fromJson(item))
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

class SpecialtyList {
  final int specialtyID;
  final String specialtyName;

  SpecialtyList({
    required this.specialtyID,
    required this.specialtyName,
  });

  factory SpecialtyList.fromJson(Map<String, dynamic> json) {
    return SpecialtyList(
      specialtyID: json['SpecialtyID'],
      specialtyName: json['SpecialtyName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SpecialtyID': specialtyID,
      'SpecialtyName': specialtyName,
    };
  }
}
