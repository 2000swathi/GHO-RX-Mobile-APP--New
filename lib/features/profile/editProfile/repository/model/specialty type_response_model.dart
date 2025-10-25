class SpecialtyTypeResponseModel {
  final int status;
  final String error;
  final String info;
  final List<List<SpecialtytypeList>> data;

  SpecialtyTypeResponseModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory SpecialtyTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyTypeResponseModel(
      status: json['Status'],
      error: json['Error'],
      info: json['Info'],
      data:(json['Data'] as List<dynamic>? ?? [])
        .map((innerList) => (innerList as List<dynamic>)
            .map((item) => SpecialtytypeList.fromJson(item))
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

class SpecialtytypeList {
  final int specialtytypeID;
  final String specialtytypeName;

  SpecialtytypeList({
    required this.specialtytypeID,
    required this.specialtytypeName,
  });

  factory SpecialtytypeList.fromJson(Map<String, dynamic> json) {
    return SpecialtytypeList(
      specialtytypeID: json['specialtytypeid'] ?? 0,
      specialtytypeName: json['Name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'specialtytypeid': specialtytypeID,
      'Name': specialtytypeName,
    };
  }
}
