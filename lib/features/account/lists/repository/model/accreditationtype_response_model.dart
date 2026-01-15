// Main Response Model
class AccreditationTypeList {
  final int status;
  final String error;
  final String info;
  final List<List<AccreditationType>> data;

  AccreditationTypeList({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory AccreditationTypeList.fromJson(Map<String, dynamic> json) {
  final rawData = json['Data'];

  List<List<AccreditationType>> parsedData;

  if (rawData is List && rawData.isNotEmpty) {
    parsedData = rawData.map<List<AccreditationType>>((list) {
      if (list is List) {
        return list
            .whereType<Map<String, dynamic>>()
            .map((item) => AccreditationType.fromJson(item))
            .toList();
      }
      return <AccreditationType>[];
    }).toList();
  } else {
    parsedData = [[]];
  }

  return AccreditationTypeList(
    status: json['Status'] ?? 0,
    error: json['Error'] ?? '',
    info: json['Info'] ?? '',
    data: parsedData,
  );
}

}

// Individual Accreditation Type Model
class AccreditationType {
  final int id;
  final String degree;

  AccreditationType({
    required this.id,
    required this.degree,
  });

  factory AccreditationType.fromJson(Map<String, dynamic> json) {
    return AccreditationType(
      id: json['id'] ?? 0,
      degree: json['D'] ?? '',
    );
  }
}
