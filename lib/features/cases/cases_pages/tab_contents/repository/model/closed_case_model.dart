class ClosedCaseModel {
  final int id;
  final String patientName;
  final String gender;
  final int age;
  final int timeUsed;
  final String completedDate;
  final String summaryOfRecords;
  final String saltID;
  final String caseID;

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
  });

  factory ClosedCaseModel.fromJson(Map<String, dynamic> json) {
    return ClosedCaseModel(
      id: json['id'] ?? 0,
      patientName: json['PatientName'] ?? '',
      gender: json['Gender'] ?? '',
      age: json['Age'] ?? 0,
      timeUsed: json['TimeUsed'] ?? 0,
      completedDate: json['CompletedDate'] ?? '',
      summaryOfRecords: json['SummaryOfRecords'] ?? '',
      saltID: json['SaltKey']??"",
      caseID: json['CaseID']??""
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
      'SaltKey': saltID,
      'CaseID':caseID
    };
  }
}
