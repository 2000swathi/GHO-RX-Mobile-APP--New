class ProfessionalerefModel {
  final int status;
  final String error;
  final String info;
  final List<ReferenceModel> data;

  ProfessionalerefModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory ProfessionalerefModel.fromJson(Map<String, dynamic> json) {
    List<ReferenceModel> dataList = [];

    if (json['Data'] is List) {
      final nestedList = json['Data'] as List;

      dataList =
          nestedList
              .expand((inner) => (inner is List) ? inner : <dynamic>[])
              .whereType<Map<String, dynamic>>()
              .map((item) => ReferenceModel.fromJson(item))
              .toList();
    }

    return ProfessionalerefModel(
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

class ReferenceModel {
  final int id;
  final String fullName;
  final String designation;
  // final String designation1;
  final String relationship;
  final String phone;

  ReferenceModel({
    required this.id,
    required this.fullName,
    required this.designation,
    // required this.designation1,
    required this.relationship,
    required this.phone,
  });

  factory ReferenceModel.fromJson(Map<String, dynamic> json) {
    return ReferenceModel(
      id: json['id'] ?? 0,
      fullName: json['FullName'] ?? '',
      designation: json['Designation'] ?? '',
      // designation1: json['Designation1'] ?? '',
      relationship: json['Relationship'] ?? '',
      phone: json['Phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FullName': fullName,
      'Designation': designation,
      // 'Designation1': designation1,
      'Relationship': relationship,
      'Phone': phone,
    };
  }
}
