class OpenCaseModel {
  final String id;
  final String patientName;
  final String gender;
  final int age;
  final dynamic timeAllowed;
  final String dueDate;
  final String medicalSummary;
  final String caseReviewerID;
  final String caseID;

  OpenCaseModel({
    required this.id,
    required this.patientName,
    required this.gender,
    required this.age,
    required this.timeAllowed,
    required this.dueDate,
    required this.medicalSummary,
    required this.caseReviewerID,
    required this.caseID,
  });

  factory OpenCaseModel.fromJson(Map<String, dynamic> json) {
    return OpenCaseModel(
      id: json['id'] ?? '0',
      patientName: json['PatientName'] ?? '',
      gender: json['Gender'] ?? '',
      age: json['Age'] ?? 0,
      timeAllowed: json['TimeAllowed'] ?? '0',
      dueDate: json['DueDate'] ?? '',
      medicalSummary: json['MedicalSummary'] ?? '',
      caseReviewerID: json['CaseReviewerID'] ?? '',
      caseID: json['CaseID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientName': patientName,
      'Gender': gender,
      'Age': age,
      'TimeAllowed': timeAllowed,
      'DueDate': dueDate,
      'MedicalSummary': medicalSummary,
      'CaseReviewerID':caseReviewerID
    };
  }
}
