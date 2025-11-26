class ProfessionalExperienceModel {
  final int status;
  final String error;
  final String info;
  final List<List<ProfessionalExperience>> data;

  ProfessionalExperienceModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory ProfessionalExperienceModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalExperienceModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: (json['Data'] as List<dynamic>)
          .map((innerList) => (innerList as List<dynamic>)
              .map((e) => ProfessionalExperience.fromJson(e))
              .toList())
          .toList(),
    );
  }
}

class ProfessionalExperience {
  final int id;
  final String institution;
  final String designation;
  final String dateFrom;
  final String dateTo;
  final String comments;

  ProfessionalExperience({
    required this.id,
    required this.institution,
    required this.designation,
    required this.dateFrom,
    required this.dateTo,
    required this.comments,
  });

  factory ProfessionalExperience.fromJson(Map<String, dynamic> json) {
    return ProfessionalExperience(
      id: json['id'] ?? 0,
      institution: json['Institution'] ?? '',
      designation: json['Designation'] ?? '',
      dateFrom: json['DateFrom'] ?? '',
      dateTo: json['DateTo'] ?? '',
      comments: json['Comments'] ?? '',
    );
  }
}
