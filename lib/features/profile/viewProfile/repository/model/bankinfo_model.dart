class BankInfoModel {
  final int id;
  final int reviewerId;
  final String accountType;
  final String routingNumber;
  final String accountNumber;
  final String accountHolderName;

  BankInfoModel({
    required this.id,
    required this.reviewerId,
    required this.accountType,
    required this.routingNumber,
    required this.accountNumber,
    required this.accountHolderName,
  });

  factory BankInfoModel.fromJson(Map<String, dynamic> json) {
    return BankInfoModel(
      id: json['id'] ?? 0,
      reviewerId: json['ReviewerID'] ?? 0,
      accountType: json['AccountType'] ?? '',
      routingNumber: json['RoutingNumber'] ?? '',
      accountNumber: json['AccountNumber'] ?? '',
      accountHolderName: json['AccountHolderName'] ?? '',
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
