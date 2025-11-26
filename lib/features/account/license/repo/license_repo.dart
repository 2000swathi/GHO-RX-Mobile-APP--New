import 'dart:convert';

import 'package:ghorx_mobile_app_new/features/account/license/repo/model/license_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class LicenseRepo {
  final DioHandler _dioHandler = DioHandler();
  // license
  Future<LicenseModel> fetchLicenseInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlic", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);

      return LicenseModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  //add License
  Future addLicense({
    required String licenseNumber,
    required String licenseType,
    required String issueDate,
    required String expiryDate,
    required String issuingAuthority,
  }) async {
    final reviewerId = await SharedPreference.getUserId();
    final token = await SharedPreference.getToken();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final c1data = jsonEncode({
      "LicenseNumber": licenseNumber,
      "LicenseType": licenseType,
      "IssueDate": issueDate,
      "ExpiryDate": expiryDate,
      "IssuingAuthority": issuingAuthority,
    });
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlic", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c1", "V": c1data},
        {"T": "c10", "V": "1"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to add License: $e");
    }
  }

   //edit license
  Future editLicense({
    required String licenseNumber,
    required String issuingAuthority,
    required String licenseType,
    required String issueDate,
    required String expiryDate,
    required String id,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final c1Editdata = jsonEncode({
      "LicenseNumber": licenseNumber,
      "IssuingAuthority": issuingAuthority,
      "LicenseType": licenseType,
      "IssueDate": issueDate,
      "ExpiryDate": expiryDate,
      "Id": id,
    });
    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewerlic", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": c1Editdata},
        {"T": "c10", "V": "2"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: requestData);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

}
