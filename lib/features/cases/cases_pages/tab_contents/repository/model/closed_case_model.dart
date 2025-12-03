class ClosedCaseModel {
  final String id;
  final String patientName;
  final String gender;
  final int age;
  final int timeUsed;
  final String completedDate;
  final String summaryOfRecords;
  final String saltID;
  final String caseID;
  final double amount;

  ClosedCaseModel({
    required this.id,
    required this.patientName,
    required this.gender,
    required this.age,
    required this.timeUsed,
    required this.completedDate,
    required this.summaryOfRecords,
    required this.saltID,
    required this.caseID,
    required this.amount,
  });

  factory ClosedCaseModel.fromJson(Map<String, dynamic> json) {
    return ClosedCaseModel(
      id: json['id'] ?? '0',
      patientName: json['PatientName'] ?? '',
      gender: json['Gender'] ?? '',
      age: json['Age'] ?? 0,
      timeUsed: json['TimeUsed'] ?? 0,
      completedDate: json['CompletedDate'] ?? '',
      summaryOfRecords: json['SummaryOfRecords'] ?? '',
      saltID: json['CaseReviewerID']??"",
      caseID: json['CaseID']??"",
      amount: json["Amount"]??0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientName': patientName,
      'Gender': gender,
      'Age': age,
      'TimeUsed': timeUsed,
      'CompletedDate': completedDate,
      'SummaryOfRecords': summaryOfRecords,
      'CaseReviewerID': saltID,
      'CaseID':caseID,
      'Amount':amount,
    };
  }
}
