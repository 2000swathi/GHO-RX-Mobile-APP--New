class OtpVerifyData {
  final String id;
  final String token;
  final String msg;

  OtpVerifyData({
    required this.id,
    required this.token,
    required this.msg,
  });

  factory OtpVerifyData.fromJson(Map<String, dynamic> json) {
    return OtpVerifyData(
      id: json['id'] ?? '',
      token: json['Token'] ?? '',
      msg: json['Msg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Token': token,
      'Msg': msg,
    };
  }
}

class OtpVerifyResponse {
  final int status;
  final String error;
  final String info;
  final List<List<OtpVerifyData>> data;

  OtpVerifyResponse({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    var outerList = json['Data'] as List<dynamic>? ?? [];
    List<List<OtpVerifyData>> dataList = outerList.map<List<OtpVerifyData>>((inner) {
      var innerList = inner as List<dynamic>? ?? [];
      return innerList.map<OtpVerifyData>((item) => OtpVerifyData.fromJson(item)).toList();
    }).toList();

    return OtpVerifyResponse(
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
