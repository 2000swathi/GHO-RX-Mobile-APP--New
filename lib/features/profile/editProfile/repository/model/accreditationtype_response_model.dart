class AccreditationTypeModel {
  final int status;
  final String error;
  final String info;
  final List<AccreditationTypeData> data;

  AccreditationTypeModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory AccreditationTypeModel.fromJson(Map<String, dynamic> json) {
   
    final rawData = json['Data'] as List?;
    final innerList = rawData != null && rawData.isNotEmpty ? rawData.first as List : [];

    return AccreditationTypeModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: innerList
          .map((item) => AccreditationTypeData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data': [
        data.map((item) => item.toJson()).toList(),
      ],
    };
  }
}

class AccreditationTypeData {
  final int accreditationTypeID;
  final String name;

  AccreditationTypeData({
    required this.accreditationTypeID,
    required this.name,
  });

  factory AccreditationTypeData.fromJson(Map<String, dynamic> json) {
    return AccreditationTypeData(
      accreditationTypeID: json['AccreditationTypeID'] ?? 0,
      name: json['Name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccreditationTypeID': accreditationTypeID,
      'Name': name,
    };
  }
}
