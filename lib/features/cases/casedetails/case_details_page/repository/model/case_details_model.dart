class CaseDetailsModel {
  final int status;
  final String error;
  final String info;
  final CaseInfo? caseInfo;
  final MedicalSummary? medicalSummary;
  final List<MedicationModel>? medications;
  final List<QuestionAnswerModel>? questions;
  final List<AudioSummaryModel>? audiosummery;
  final List<AudioSummaryModel>? draudiosummery;

  CaseDetailsModel({
    required this.status,
    required this.error,
    required this.info,
    this.caseInfo,
    this.medicalSummary,
    this.medications,
    this.questions,
    this.audiosummery,
    this.draudiosummery,
  });

  factory CaseDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['Data'] as List?;

    return CaseDetailsModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      caseInfo:
          (data != null &&
                  data.isNotEmpty &&
                  data[0] is List &&
                  (data[0] as List).isNotEmpty)
              ? CaseInfo.fromJson((data[0] as List)[0])
              : null,
      medicalSummary:
          (data != null &&
                  data.length > 1 &&
                  data[1] is List &&
                  (data[1] as List).isNotEmpty)
              ? MedicalSummary.fromJson((data[1] as List)[0])
              : null,
      medications:
          (data != null && data.length > 2 && data[2] is List)
              ? (data[2] as List)
                  .map(
                    (e) => MedicationModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
              : [],
      questions:
          (data != null && data.length > 3 && data[3] is List)
              ? (data[3] as List)
                  .map(
                    (e) =>
                        QuestionAnswerModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
              : [],
      audiosummery:
          (data != null && data.length > 4 && data[4] is List)
              ? (data[4] as List)
                  .map(
                    (e) =>
                        AudioSummaryModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
              : [],
      draudiosummery:
          (data != null && data.length > 5 && data[5] is List)
              ? (data[5] as List)
                  .map(
                    (e) =>
                        AudioSummaryModel.fromJson(e as Map<String, dynamic>),
                  )
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
        medications!.map((m) => m.toJson()).toList(),
        questions!.map((q) => q.toJson()).toList(),
        audiosummery!.map((r) => r.toJson()).toList(),
        draudiosummery!.map((s) => s.toJson()).toList(),

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
  final String? dob;
  final String caseID;

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
    this.dob,
    required this.caseID,
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
    dateSubmitted: json['DateSubmitted'] ?? "",
    dob: json["DOB"] ?? "",
    caseID: json["CaseID"] ?? "",
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
    "DOB": dob,
    "CaseID": caseID,
  };
}

class MedicalSummary {
  final String medicalSummary;

  MedicalSummary({required this.medicalSummary});

  factory MedicalSummary.fromJson(Map<String, dynamic> json) =>
      MedicalSummary(medicalSummary: json['MedicalSummary'] ?? '');

  Map<String, dynamic> toJson() => {'MedicalSummary': medicalSummary};
}

class MedicationModel {
  final String name;
  final String startPd;
  final String endpd;

  MedicationModel({
    required this.name,
    required this.startPd,
    required this.endpd,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) =>
      MedicationModel(
        name: json['MedicationName'] ?? "",
        startPd: json['StartPeriod'] ?? '',
        endpd: json['EndPeriod'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'MedicationName': name,
    "EndMonth": startPd,
    "EndYear": endpd,
  };
}

class QuestionAnswerModel {
  final int id;
  final String question;
  final String? answer;
  final String? support;

  QuestionAnswerModel({
    required this.id,
    required this.question,
    this.answer,
    this.support,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
        id: json['id'] ?? 0,
        question: json['Question'] ?? '',
        answer: json['Answer'] ?? "",
        support: json['Support'] ?? "",
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'Question': question,
    'Answer': answer,
    'Support': support,
  };
}

class AudioSummaryModel {
  final int id;
  final String fileName;
  final String? fd;
  final String fl;
  final String fileType;
  final String uploadedDate;
  final String url;
  final int docTypeID;
  // final String userType;

  AudioSummaryModel({
    required this.id,
    required this.fileName,
    this.fd,
    required this.fl,
    required this.fileType,
    required this.uploadedDate,
    required this.url,
    required this.docTypeID,
    // required this.userType,
  });

  factory AudioSummaryModel.fromJson(Map<String, dynamic> json) {
    return AudioSummaryModel(
      id: json['id'] ?? 0,
      fileName: json['FileName'] ?? '',
      fd: json['fd'],
      fl: json['fl'] ?? '',
      fileType: json['Filetype'] ?? '',
      uploadedDate: json['UploadedDate'] ?? '',
      url: json['_url'] ?? '',
      docTypeID: json['DocumentTypeid'] ?? 0,
      // userType: json['UserType'] ?? "P",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'FileName': fileName,
      'fd': fd,
      'fl': fl,
      'Filetype': fileType,
      'UploadedDate': uploadedDate,
      '_url': url,
      'DocumentTypeid': docTypeID,
      // 'UserType': userType,
    };
  }
}
