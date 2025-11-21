class EducationResponse {
  final int status;
  final String error;
  final String info;
  final List<List<EducationData>> data;

  EducationResponse({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory EducationResponse.fromJson(Map<String, dynamic> json) {
    return EducationResponse(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data: (json['Data'] as List<dynamic>? ?? [])
          .map<List<EducationData>>((innerList) =>
              (innerList as List<dynamic>)
                  .map((item) => EducationData.fromJson(item))
                  .toList())
          .toList(),
    );
  }
}

class EducationData {
  final int id;
  final String institution;
  final String degree;
  final String duration;
  final int? completedYear;
  final String comments;

  EducationData({
    required this.id,
    required this.institution,
    required this.degree,
    required this.duration,
    required this.completedYear,
    required this.comments,
  });

  factory EducationData.fromJson(Map<String, dynamic> json) {
    return EducationData(
      id: json['id'] ?? 0,
      institution: json['Institution'] ?? '',
      degree: json['Degree'] ?? '',
      duration: json['Duration'] ?? '',
      completedYear: (json['CompletedYear'] == null ||
            json['CompletedYear'].toString().isEmpty)
        ? null
        : int.tryParse(json['CompletedYear'].toString()),
      comments: json['Comments'] ?? '',
    );
  }
}
