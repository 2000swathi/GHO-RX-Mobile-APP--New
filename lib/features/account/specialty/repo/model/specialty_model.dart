class SpecialtyModel {
  int status;
  String error;
  String info;
  final List<Specialtym> data; // flattened list of specialties

  SpecialtyModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    List outerList = json['Data'] as List? ?? [];
    List<Specialtym> specialties = [];

    if (outerList.isNotEmpty && outerList.first is List) {
      specialties =
          (outerList.first as List)
              .map((item) => Specialtym.fromJson(item))
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

class Specialtym {
  final int id;
  final int reviewerId;
  final int specialtyId;
  final String specialtyType;
  final String certifiedBoard;
  final String specialty;
  final int certificationBodyID;

  Specialtym({
    required this.id,
    required this.reviewerId,
    required this.specialtyId,
    required this.specialtyType,
    required this.certifiedBoard,
    required this.specialty,
    required this.certificationBodyID,
  });

  factory Specialtym.fromJson(Map<String, dynamic> json) {
    return Specialtym(
      id: json['id'] ?? 0,
      reviewerId: json['ReviewerID'] ?? 0,
      specialtyId: json['SpecialtyID'] ?? 0,
      specialtyType: json['SpecialtyType'] ?? '',
      certifiedBoard: json['CertifiedBoard'] ?? '',
      specialty: json['Specialty'] ?? '',
      certificationBodyID: json['CertificationBodyID'] ?? 0,
    );
  }
}
