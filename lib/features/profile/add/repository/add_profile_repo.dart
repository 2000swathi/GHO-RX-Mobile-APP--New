import 'dart:convert';

import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class AddProfileRepository {
  final DioHandler _dioHandler = DioHandler();

  //add specialty
  Future addSpecialty() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "1"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to add specialty: $e");
    }
  }

  //add License
  Future addLicense({
    required String licenseNumber,
    // required String issuingAuthority,
    required String licenseType,
    required String issueDate,
    required String expiryDate,
  }) async {
    final reviewerId = await SharedPreference.getUserId();
    final token = await SharedPreference.getToken();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final c1data = jsonEncode({
      "LicenseNumber": licenseNumber,
      // "IssuingAuthority": issuingAuthority,
      "LicenseType": licenseType,
      "IssueDate": issueDate,
      "ExpiryDate": expiryDate,
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
      print(response);
      // return LicenseModel.fromJson(response['Data'][0][0]);
      return LicenseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to add License: $e");
    }
  }

  //add language
  Future addLanguage({
    required String language,
    required String proficiency,
  }) async {
    final token = await SharedPreference.getToken();
    final userId = await SharedPreference.getUserId();

    if (token!.isEmpty || userId!.isEmpty) {
      throw Exception('Token or UserID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlang", token: token),
      "Tags": [
        {"T": "dk1", "V": userId},
        {"T": "c1", "V": language}, //language
        {"T": "c2", "V": proficiency},
        {"T": "c10", "V": "1"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);

      return response;
    } catch (e) {
      throw Exception("Failed to add Language: $e");
    }
  }

  //add banking
  Future addBankInfo({
    required String accountType,
    required String routingNumber,
    required String accountNumber,
    required String holderName,
  }) async {
    final token = await SharedPreference.getToken();
    final userId = await SharedPreference.getUserId();

    if (token!.isEmpty || userId!.isEmpty) {
      throw Exception('Token or UserID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "revieweracc", token: token),
      "Tags": [
        {"T": "dk1", "V": userId},
        {"T": "c1", "V": accountType},
        {"T": "c2", "V": routingNumber},
        {"T": "c3", "V": accountNumber},
        {"T": "c4", "V": holderName},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return response;
    } catch (e) {
      throw Exception("Failed to add Bank Info: $e");
    }
  }
}
