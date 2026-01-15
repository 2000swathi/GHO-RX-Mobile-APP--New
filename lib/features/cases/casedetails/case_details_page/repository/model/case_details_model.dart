class CaseDetailsModel {
  final int status;
  final String error;
  final String info;

  final CaseInfo? caseInfo;
  final List<MedicationModel> medications;
  final List<QuestionAnswerModel> questions;
  final List<CaseDocumentModel> clientDocuments;
  final List<DeclarationModel> declarations;
  final List<CaseDocumentModel> reviewerDocuments;

  CaseDetailsModel({
    required this.status,
    required this.error,
    required this.info,
    this.caseInfo,
    required this.medications,
    required this.questions,
    required this.clientDocuments,
    required this.declarations,
    required this.reviewerDocuments,
  });

  factory CaseDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['Data'] as List? ?? [];

    return CaseDetailsModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',

      /// 0️⃣ Case Info
      caseInfo: data.isNotEmpty && data[0] is List && data[0].isNotEmpty
          ? CaseInfo.fromJson(data[0][0])
          : null,

      /// 1️⃣ Medications
      medications: data.length > 1
          ? (data[1] as List)
              .map((e) => MedicationModel.fromJson(e))
              .toList()
          : [],

      /// 2️⃣ Questions
      questions: data.length > 2
          ? (data[2] as List)
              .map((e) => QuestionAnswerModel.fromJson(e))
              .toList()
          : [],

      /// 3️⃣ Client Documents
      clientDocuments: data.length > 3
          ? (data[3] as List)
              .map((e) => CaseDocumentModel.fromJson(e))
              .toList()
          : [],

      /// 4️⃣ Declarations
      declarations: data.length > 4
          ? (data[4] as List)
              .map((e) => DeclarationModel.fromJson(e))
              .toList()
          : [],

      /// 5️⃣ Reviewer Documents (PDF + Image + Audio)
      reviewerDocuments: data.length > 5
          ? (data[5] as List)
              .map((e) => CaseDocumentModel.fromJson(e))
              .toList()
          : [],
    );
  }
}
class CaseInfo {
  final String caseId;
  final String patient;
  final String dateAssigned;
  final String dueDate;
  final String timeAllowed;
  final String medicalSummary;
  final String occupation;
  final String ethnicity;
  final String specialty;
  final String summaryOfRecords;
  final String submittedDate;

  CaseInfo({
    required this.caseId,
    required this.patient,
    required this.dateAssigned,
    required this.dueDate,
    required this.timeAllowed,
    required this.medicalSummary,
    required this.occupation,
    required this.ethnicity,
    required this.specialty,
    required this.summaryOfRecords,
    required this.submittedDate,
  });

  factory CaseInfo.fromJson(Map<String, dynamic> json) => CaseInfo(
        caseId: json['ID'] ?? '',
        patient: json['Patient'] ?? '',
        dateAssigned: json['DateAssigned'] ?? '',
        dueDate: json['DueDate'] ?? '',
        timeAllowed: json['TimeAllowed'] ?? '',
        medicalSummary: json['MedicalSummary'] ?? '',
        occupation: json['Occupation'] ?? '',
        ethnicity: json['Ethnicity'] ?? '',
        specialty: json['Specialty'] ?? '',
        summaryOfRecords: json['SummaryOfRecords'] ?? '',
        submittedDate: json['SubmittedDate'] ?? '',
      );
}
class MedicationModel {
  final String name;
  final String startPeriod;
  final String endPeriod;

  MedicationModel({
    required this.name,
    required this.startPeriod,
    required this.endPeriod,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) =>
      MedicationModel(
        name: json['MedicationName'] ?? '',
        startPeriod: json['StartPeriod'] ?? '',
        endPeriod: json['EndPeriod'] ?? '',
      );
}
class QuestionAnswerModel {
  final int id;
  final String question;
  final String answer;
  final String support;

  QuestionAnswerModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.support,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
        id: json['id'] ?? 0,
        question: json['Question'] ?? '',
        answer: json['Answer'] ?? '',
        support: json['Support'] ?? '',
      );
}
class CaseDocumentModel {
  final int id;
  final String fileName;
  final int documentTypeId;
  final String? fd;
  final String fl;
  final String fileType;
  final DateTime uploadedDate;
  final String url;
  final String userType;

  CaseDocumentModel({
    required this.id,
    required this.fileName,
    required this.documentTypeId,
    this.fd,
    required this.fl,
    required this.fileType,
    required this.uploadedDate,
    required this.url,
    required this.userType,
  });

  factory CaseDocumentModel.fromJson(Map<String, dynamic> json) =>
      CaseDocumentModel(
        id: json['id'] ?? 0,
        fileName: json['FileName'] ?? '',
        documentTypeId: json['DocumentTypeid'] ?? 0,
        fd: json['fd'],
        fl: json['fl'] ?? '',
        fileType: json['Filetype'] ?? '',
        uploadedDate:
            DateTime.tryParse(json['UploadedDate'] ?? '') ?? DateTime.now(),
        url: json['_url'] ?? '',
        userType: json['UserType'] ?? '',
      );

  /// 🔥 Helpers for UI
  bool get isAudio => documentTypeId == 6;
  bool get isDocument => documentTypeId == 1;
}
class DeclarationModel {
  final int id;
  final String title;
  final String description;
  final int status;

  DeclarationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      DeclarationModel(
        id: json['id'] ?? 0,
        title: json['t'] ?? '',
        description: json['d'] ?? '',
        status: json['s'] ?? 0,
      );
}
