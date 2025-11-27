class ProfessionalReferenceResponse {
  final int status;
  final String error;
  final String info;
  final List<List<ReferenceData>> data;

  ProfessionalReferenceResponse({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory ProfessionalReferenceResponse.fromJson(Map<String, dynamic> json) {
    return ProfessionalReferenceResponse(
      status: json['Status'],
      error: json['Error'],
      info: json['Info'],
      data:
          (json['Data'] as List)
              .map(
                (innerList) =>
                    (innerList as List)
                        .map((item) => ReferenceData.fromJson(item))
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
              .map((innerList) => innerList.map((e) => e.toJson()).toList())
              .toList(),
    };
  }
}

class ReferenceData {
  final String dataValue;
  final String displyText;

  ReferenceData({required this.dataValue, required this.displyText});

  factory ReferenceData.fromJson(Map<String, dynamic> json) {
    return ReferenceData(
      dataValue: json['DataValue'],
      displyText: json['DisplyText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'DataValue': dataValue, 'DisplyText': displyText};
  }
}
