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
      status: json['Status'],
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: (json['Data'] as List)
          .map((innerList) => (innerList as List)
              .map((country) => Country.fromJson(country))
              .toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data': data
          .map((innerList) => innerList.map((country) => country.toJson()).toList())
          .toList(),
    };
  }
}

class Country {
  final int countryID;
  final String countryName;
  final String countryCode;

  Country({
    required this.countryID,
    required this.countryName,
    required this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryID: json['CountryID'],
      countryName: json['CountryName'],
      countryCode: json['CountryCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CountryID': countryID,
      'CountryName': countryName,
      'CountryCode': countryCode,
    };
  }
}
