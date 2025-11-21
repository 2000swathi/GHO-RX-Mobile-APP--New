class EducationTypeModel {
  final int status;
  final String error;
  final String info;
  final List<List<EducationTypeItem>> data;

  EducationTypeModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory EducationTypeModel.fromJson(Map<String, dynamic> json) {
    return EducationTypeModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: (json['Data'] as List<dynamic>)
          .map((list) => (list as List<dynamic>)
              .map((item) => EducationTypeItem.fromJson(item))
              .toList())
          .toList(),
    );
  }
}

class EducationTypeItem {
  final String dataValue;
  final String? displayText;

  EducationTypeItem({
    required this.dataValue,
    required this.displayText,
  });

  factory EducationTypeItem.fromJson(Map<String, dynamic> json) {
    return EducationTypeItem(
      dataValue: json['DataValue'] ?? '',
      displayText: json['DisplyText'],
    );
  }
}
