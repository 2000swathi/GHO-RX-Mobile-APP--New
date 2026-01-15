class AccreditationModel {
  final int status;
  final String error;
  final String info;
  final List<AccreditationData> data;

  AccreditationModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory AccreditationModel.fromJson(Map<String, dynamic> json) {
    List<AccreditationData> dataList = [];
    if (json['Data'] is List) {
      final nestedList = json['Data'] as List;
      dataList =
          nestedList
              .expand((inner) => (inner is List) ? inner : <dynamic>[])
              .whereType<Map<String, dynamic>>()
              .map((item) => AccreditationData.fromJson(item))
              .toList();
    }

    return AccreditationModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data': [data.map((e) => e.toJson()).toList()],
    };
  }
}

class AccreditationData {
  final dynamic id;
  final String name;

  AccreditationData({required this.id, required this.name});

  factory AccreditationData.fromJson(Map<String, dynamic> json) {
    return AccreditationData(id: json['id'] ?? 0, name: json['D'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'D': name};
  }
}
