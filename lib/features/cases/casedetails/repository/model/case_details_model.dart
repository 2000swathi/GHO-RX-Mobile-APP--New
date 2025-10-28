class CaseDetailsModel {
  final int status;
  final String error;
  final String info;
  final CaseInfo? caseInfo;
  final MedicalSummary? medicalSummary;
  final List<Medication> medications;
  final List<QuestionAnswer> questions;

  CaseDetailsModel({
    required this.status,
    required this.error,
    required this.info,
    this.caseInfo,
    this.medicalSummary,
    required this.medications,
    required this.questions,
  });

  factory CaseDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['Data'] as List?;

    return CaseDetailsModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      caseInfo: (data != null && data.isNotEmpty && data[0] is List && (data[0] as List).isNotEmpty)
          ? CaseInfo.fromJson((data[0] as List)[0])
          : null,
      medicalSummary: (data != null && data.length > 1 && data[1] is List && (data[1] as List).isNotEmpty)
          ? MedicalSummary.fromJson((data[1] as List)[0])
          : null,
      medications: (data != null && data.length > 2 && data[2] is List)
          ? (data[2] as List)
              .map((e) => Medication.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      questions: (data != null && data.length > 3 && data[3] is List)
          ? (data[3] as List)
              .map((e) => QuestionAnswer.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data': [
        caseInfo != null ? [caseInfo!.toJson()] : [],
        medicalSummary != null ? [medicalSummary!.toJson()] : [],
        medications.map((m) => m.toJson()).toList(),
        questions.map((q) => q.toJson()).toList(),
        [],
        [],
      ],
    };
  }
}

// --- Sub Models ---

class CaseInfo {
  final int id;
  final String patientName;
  final String saltKey;
  final String gender;
  final String dateAssigned;
  final String dueDate;
  final String summaryOfRecords;
  final String timeAllowed;
  final String? dateSubmitted;

  CaseInfo({
    required this.id,
    required this.patientName,
    required this.saltKey,
    required this.gender,
    required this.dateAssigned,
    required this.dueDate,
    required this.summaryOfRecords,
    required this.timeAllowed,
    this.dateSubmitted,
  });

  factory CaseInfo.fromJson(Map<String, dynamic> json) => CaseInfo(
        id: json['id'] ?? 0,
        patientName: json['PatientName'] ?? '',
        saltKey: json['SaltKey'] ?? '',
        gender: json['Gender'] ?? '',
        dateAssigned: json['DateAssigned'] ?? '',
        dueDate: json['DueDate'] ?? '',
        summaryOfRecords: json['SummaryOfRecords'] ?? '',
        timeAllowed: json['TimeAllowd'] ?? '',
        dateSubmitted: json['DateSubmitted'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'PatientName': patientName,
        'SaltKey': saltKey,
        'Gender': gender,
        'DateAssigned': dateAssigned,
        'DueDate': dueDate,
        'SummaryOfRecords': summaryOfRecords,
        'TimeAllowd': timeAllowed,
        'DateSubmitted': dateSubmitted,
      };
}

class MedicalSummary {
  final String medicalSummary;

  MedicalSummary({required this.medicalSummary});

  factory MedicalSummary.fromJson(Map<String, dynamic> json) => MedicalSummary(
        medicalSummary: json['MedicalSummary'] ?? '',
      );

  Map<String, dynamic> toJson() => {'MedicalSummary': medicalSummary};
}

class Medication {
  final String? name;

  Medication({this.name});

  factory Medication.fromJson(Map<String, dynamic> json) =>
      Medication(name: json['Name']);

  Map<String, dynamic> toJson() => {'Name': name};
}

class QuestionAnswer {
  final int id;
  final String question;
  final String? answer;
  final String? support;

  QuestionAnswer({
    required this.id,
    required this.question,
    this.answer,
    this.support,
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
        id: json['id'] ?? 0,
        question: json['Question'] ?? '',
        answer: json['Answer'],
        support: json['Support'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'Question': question,
        'Answer': answer,
        'Support': support,
      };
}
