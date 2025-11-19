// ignore_for_file: non_constant_identifier_names

class IssueingAuthorityResponseModel {
  final int status;
  final String error;
  final String info;
  final List<List<IssueingList>> data;

  IssueingAuthorityResponseModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory IssueingAuthorityResponseModel.fromJson(Map<String, dynamic> json) {
    return IssueingAuthorityResponseModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data:
          (json['Data'] as List<dynamic>? ?? [])
              .map(
                (innerList) =>
                    (innerList as List<dynamic>)
                        .map((item) => IssueingList.fromJson(item))
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

class IssueingList {
  final String IssueingTypeID;
  final String IssueingTypeName;

  IssueingList({required this.IssueingTypeID, required this.IssueingTypeName});

  factory IssueingList.fromJson(Map<String, dynamic> json) {
    return IssueingList(
      IssueingTypeID: json['DataValue'] ?? '',
      IssueingTypeName: json['DisplyText'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'DataValue': IssueingTypeID,
     'DisplyText': IssueingTypeName};
  }
}
