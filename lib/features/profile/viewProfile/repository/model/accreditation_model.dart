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
      dataList = nestedList
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
  final int id;
  final int reviewerId;
  final String accreditationType;
  final String accreditationBody;
  final String accreditationNumber;

  AccreditationData({
    required this.id,
    required this.reviewerId,
    required this.accreditationType,
    required this.accreditationBody,
    required this.accreditationNumber,
  });

  factory AccreditationData.fromJson(Map<String, dynamic> json) {
    return AccreditationData(
      id: json['ID'] ?? 0,
      reviewerId: json['ReviewerId'] ?? 0,
      accreditationType: json['AccreditationType'] ?? '',
      accreditationBody: json['AccreditationBody'] ?? '',
      accreditationNumber: json['AccreditationNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ReviewerId': reviewerId,
      'AccreditationType': accreditationType,
      'AccreditationBody': accreditationBody,
      'AccreditationNumber': accreditationNumber,
    };
  }
}
