class InsuranceModel {
  final int status;
  final String? error;
  final String? info;
  final List<InsuranceData> data; 

  InsuranceModel({
    required this.status,
    this.error,
    this.info,
    required this.data,
  });

  factory InsuranceModel.fromJson(Map<String, dynamic> json) {
    final nestedList = json['Data'] as List<dynamic>;
    final flatList =
        nestedList
            .expand(
              (inner) => (inner as List<dynamic>).map(
                (item) => InsuranceData.fromJson(item),
              ),
            )
            .toList();

    return InsuranceModel(
      status: json['Status'],
      error: json['Error'],
      info: json['Info'],
      data: flatList,
    );
  }

  Map<String, dynamic> toJson() => {
    'Status': status,
    'Error': error,
    'Info': info,
    'Data': data.map((item) => item.toJson()).toList(),
  };
}

class InsuranceData {
  final int id;
  final String? providerID;
  final String? providerName;
  final String? issueDate;
  final String? expiryDate;

  InsuranceData({
    required this.id,
    this.providerID,
    this.providerName,
    this.issueDate,
    this.expiryDate,
  });

  factory InsuranceData.fromJson(Map<String, dynamic> json) {
    return InsuranceData(
      id: json['id'] ?? 0, 
      providerID: json['ProviderID']??"",
      providerName: json['ProviderName']??"",
      issueDate: json['Issuedate']??"",
      expiryDate: json['ExpiryDate']??"",
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ProviderID': providerID,
    'ProviderName': providerName,
    'Issuedate': issueDate,
    'ExpiryDate': expiryDate,
  };
}
