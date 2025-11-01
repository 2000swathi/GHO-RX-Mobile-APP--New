class MedicalRecordList {
  int status;
  String error;
  String info;
  List<MedicalRecord> data;

  MedicalRecordList.GetFilesModel({
    required this.status,
    required this.error,
    required this.info,
    required this.data,
  });

  factory MedicalRecordList.fromJson(Map<String, dynamic> json) {
    return MedicalRecordList.GetFilesModel(
      status: json["Status"] ?? 0,
      error: json["Error"] ?? "",
      info: json["Info"] ?? "",
      data: json["Data"] != null
          ? List<MedicalRecord>.from(
              json["Data"].expand((list) => list is List ? list : [list])
                  .map((x) => MedicalRecord.fromJson(x)))
          : [],
    );
  }
}

class MedicalRecord {
  int id;
  String? fileName;
  String? originalFilename;
  String? fileType;
  String? catogoryType;
  String? createdAt;


  MedicalRecord({
    required this.id,
    this.fileName,
    this.originalFilename,
    this.fileType,
    this.catogoryType,
    this.createdAt,

  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) => MedicalRecord(
        id: json["FileUploadID"] ?? 0,
        fileName: json["filename"],
        originalFilename: json["OrgFileName"],
        fileType: json["FileType"],      
        catogoryType: json["DocumentItemName"],      
        createdAt: json["UploadedAt"],      
      );
}
