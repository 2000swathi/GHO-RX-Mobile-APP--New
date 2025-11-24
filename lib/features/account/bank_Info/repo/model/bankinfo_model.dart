class BankInfoResponseModel {
  final int status;
  final String? error;
  final String? info;
  final List<BankInfoModel> data; 

  BankInfoResponseModel({
    required this.status,
    this.error,
    this.info,
    required this.data,
  });

  factory BankInfoResponseModel.fromJson(Map<String, dynamic> json) {
    final nestedList = json['Data'] as List<dynamic>;
    final flatList =
        nestedList
            .expand(
              (inner) => (inner as List<dynamic>).map(
                (item) => BankInfoModel.fromJson(item),
              ),
            )
            .toList();

    return BankInfoResponseModel(
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


class BankInfoModel {
  final int id;
  final String reviewerId;
  final String accountType;
  final String routingNumber;
  final String accountNumber;
  final String accountHolderName;
  final String bankName;

  BankInfoModel({
    required this.id,
    required this.reviewerId,
    required this.accountType,
    required this.routingNumber,
    required this.accountNumber,
    required this.accountHolderName,
    required this.bankName,
  });

  factory BankInfoModel.fromJson(Map<String, dynamic> json) {
    return BankInfoModel(
      id: json['id'] ?? 0,
      reviewerId: json['ReviewerID'] ?? '',
      accountType: json['AccountType'] ?? '',
      routingNumber: json['RoutingNumber'] ?? '',
      accountNumber: json['AccountNumber'] ?? '',
      accountHolderName: json['AccountHolderName'] ?? '',
      bankName: json['BankName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ReviewerID': reviewerId,
      'AccountType': accountType,
      'RoutingNumber': routingNumber,
      'AccountNumber': accountNumber,
      'AccountHolderName': accountHolderName,
      'BankName': bankName,
    };
  }

  static List<BankInfoModel> listFromResponse(Map<String, dynamic> json) {
    final data = json['Data'] as List?;
    if (data == null || data.isEmpty) return [];
    final innerList = data.first as List?;
    if (innerList == null || innerList.isEmpty) return [];
    return innerList.map((e) => BankInfoModel.fromJson(e)).toList();
  }
}
