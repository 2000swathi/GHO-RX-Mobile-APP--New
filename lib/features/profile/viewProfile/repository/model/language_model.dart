class LanguageModel {
  final int status;
  final String error;
  final String info;
  final List<ReviewerLanguage> data; // flattened list

  LanguageModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      status: json['Status'] ?? 0,
      error: json['Error'] ?? '',
      info: json['Info'] ?? '',
      data:
          (json['Data'] as List)
              .expand((outerList) => (outerList as List))
              .map((item) => ReviewerLanguage.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Error': error,
      'Info': info,
      'Data': [data.map((e) => e.toJson()).toList()], // wrap again if needed
    };
  }
}

class ReviewerLanguage {
  final int id;
  final String reviewerId;
  final String language;
  final String proficiency;

  ReviewerLanguage({
    required this.id,
    required this.reviewerId,
    required this.language,
    required this.proficiency,
  });

  factory ReviewerLanguage.fromJson(Map<String, dynamic> json) {
    return ReviewerLanguage(
      id: json['ID'] ?? 0,
      reviewerId: json['ReviewerID'] ?? '',
      language: json['Language'] ?? '',
      proficiency: json['Proficiency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ReviewerID': reviewerId,
      'Language': language,
      'Proficiency': proficiency,
    };
  }
}
