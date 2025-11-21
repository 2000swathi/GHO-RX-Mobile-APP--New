class ProfessionalerefModel {
  final int status;
  final String error;
  final String info;
  final List<List<dynamic>> data; // because it's a list containing another list

  ProfessionalerefModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory ProfessionalerefModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalerefModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: (json['Data'] as List).map((e) => List<dynamic>.from(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Status': status, 'Error': error, 'Info': info, 'Data': data};
  }
}
