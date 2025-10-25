class LicenseListModel {
  final int licenseTypeID;
  final String licenseTypeName;

  LicenseListModel({
    required this.licenseTypeID,
    required this.licenseTypeName,
  });

  factory LicenseListModel.fromJson(Map<String, dynamic> json) {
    return LicenseListModel(
      licenseTypeID: json['LicenseTypeID'],
      licenseTypeName: json['LicenseType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'LicenseTypeID': licenseTypeID, 'LicenseType': licenseTypeName};
  }
}
