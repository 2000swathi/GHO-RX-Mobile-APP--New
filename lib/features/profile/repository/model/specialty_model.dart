class SpecialtyModel {
  int status;
  String error;
  String info;
  final List<Specialty> data; // flattened list of specialties

  SpecialtyModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    List outerList = json['Data'] as List? ?? [];
    List<Specialty> specialties = [];

    if (outerList.isNotEmpty && outerList.first is List) {
      specialties = (outerList.first as List)
          .map((item) => Specialty.fromJson(item))
          .toList();
    }

    return SpecialtyModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? "",
      info: json['Info'] ?? "",
      data: specialties,
    );
  }
}

class Specialty {
  final int id;
  final int reviewerId;
  final int specialtyId;
  final int? specialtyIdOld;
  final String specialtyType;
  final bool isCertified;
  final DateTime expDate;
  final bool credentialStatus;
  final String? code;
  final String? docCode;
  final bool? isMain;
  final bool? isExpertise;
  final bool? isSub;
  final String certifiedBoard;
  final String specialty;

  Specialty({
    required this.id,
    required this.reviewerId,
    required this.specialtyId,
    this.specialtyIdOld,
    required this.specialtyType,
    required this.isCertified,
    required this.expDate,
    required this.credentialStatus,
    this.code,
    this.docCode,
    this.isMain,
    this.isExpertise,
    this.isSub,
    required this.certifiedBoard,
    required this.specialty,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return Specialty(
      id: json['ID'] ?? 0,
      reviewerId: json['ReviewerID'] ?? 0,
      specialtyId: json['SpecialtyID'] ?? 0,
      specialtyIdOld: json['SpecialtyID_Old'],
      specialtyType: json['SpecialtyType'] ?? '',
      isCertified: json['IsCertified'] ?? false,
      expDate: json['ExpDate'] != null
          ? DateTime.parse(json['ExpDate'])
          : DateTime(1970),
      credentialStatus: json['CredentialStatus'] ?? false,
      code: json['Code'],
      docCode: json['DocCode'],
      isMain: json['IsMain'],
      isExpertise: json['IsExpertise'],
      isSub: json['IsSub'],
      certifiedBoard: json['CertifiedBoard'] ?? '',
      specialty: json['Specialty'] ?? '',
    );
  }
}
