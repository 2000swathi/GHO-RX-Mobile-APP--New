class CountryResponseModel {
  final int status;
  final String error;
  final String info;
  final List<List<Country>> data;

  CountryResponseModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) {
    return CountryResponseModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data:
          (json['Data'] as List<dynamic>? ?? [])
              .map(
                (innerList) =>
                    (innerList as List<dynamic>)
                        .map((item) => Country.fromJson(item))
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data':
          data
              .map((innerList) => innerList.map((c) => c.toJson()).toList())
              .toList(),
    };
  }
}

class Country {
  final int countryID;
  final String countryName;
  final String countryCode;
  final int minLength;
  final int maxLength;

  Country({
    required this.countryID,
    required this.countryName,
    required this.countryCode,
    required this.minLength,
    required this.maxLength,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryID: json['CountryID'] ?? 0,
      countryName: json['CountryName'] ?? '',
      countryCode: json['CountryCode'] ?? '',
      minLength: (json['MinLength'] ?? 6) as int,
      maxLength: (json['MaxLength'] ?? 12) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CountryID': countryID,
      'CountryName': countryName,
      'CountryCode': countryCode,
      'MinLength': minLength,
      'MaxLength': maxLength,
    };
  }
}
