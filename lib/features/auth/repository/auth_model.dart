class OtpData {
  final String email;
  final int otp;

  OtpData({
    required this.email,
    required this.otp,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      email: json['eml'] ?? '',
      otp: json['Otp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eml': email,
      'Otp': otp,
    };
  }
}

class OtpResponse {
  final int status;
  final String error;
  final String info;
  final List<List<OtpData>> data;

  OtpResponse({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    var outerList = json['Data'] as List<dynamic>? ?? [];
    List<List<OtpData>> dataList = outerList.map<List<OtpData>>((inner) {
      var innerList = inner as List<dynamic>? ?? [];
      return innerList.map<OtpData>((item) => OtpData.fromJson(item)).toList();
    }).toList();

    return OtpResponse(
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
      'Data': data.map((inner) => inner.map((e) => e.toJson()).toList()).toList(),
    };
  }
}
