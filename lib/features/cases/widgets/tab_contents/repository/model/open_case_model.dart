class OpenCaseModel {
  final int id;
  final String patientName;
  final String gender;
  final int age;
  final int timeAllowed;
  final String dueDate;
  final String medicalSummary;

  OpenCaseModel({
    required this.id,
    required this.patientName,
    required this.gender,
    required this.age,
    required this.timeAllowed,
    required this.dueDate,
    required this.medicalSummary,
  });

  factory OpenCaseModel.fromJson(Map<String, dynamic> json) {
    return OpenCaseModel(
      id: json['id'] ?? 0,
      patientName: json['Patient Name'] ?? '',
      gender: json['Gender'] ?? '',
      age: json['Age'] ?? 0,
      timeAllowed: json['TimeAllowed'] ?? 0,
      dueDate: json['DueDate'] ?? '',
      medicalSummary: json['MedicalSummary'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Patient Name': patientName,
      'Gender': gender,
      'Age': age,
      'TimeAllowed': timeAllowed,
      'DueDate': dueDate,
      'MedicalSummary': medicalSummary,
    };
  }
}
