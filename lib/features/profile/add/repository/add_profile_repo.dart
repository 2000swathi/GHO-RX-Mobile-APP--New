import 'dart:convert';

import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class AddProfileRepository {
  final DioHandler _dioHandler = DioHandler();

//add specialty
  Future addSpecialty({
    required String specialty,
    required String certifiedBoard,
    required String specialtyType,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    final c1data = jsonEncode({
      "SpecialtyID": specialty,
      "CertifiedBoard": certifiedBoard,
      "SpecialtyType": specialtyType,
    });
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: token),
      "Tags": [
        {"T": "dk1", "V":reviewerId},
        {"T": "c1", "V": c1data},
        {"T": "c10", "V": "1"}
      ]
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to add specialty: $e");
    }
  }

//add accreditation
Future addaccrediation({
  required String accreditationtype,
  required String accreditationbody,
  required String accreditationnumber,
}) async {
  final token = await SharedPreference.getToken();
  final reviewerId = await SharedPreference.getUserId();

  if(token!.isEmpty || reviewerId!.isEmpty) {
    throw Exception('Token or ReviewerId not found in SharedPreferences');
  }
  final data = {
    ...ApiUtils.getCommonParams(action: "revieweraccred", token: token),
    "Tags": [
      {"T": "dk1", "V":reviewerId},
      {"T": "c1", "V": accreditationtype},
      {"T": "c2", "V": accreditationbody},
      {"T": "c3", "V": accreditationnumber},
      {"T": "c10", "V": "1"} 
     ] 
  };
  try {
    final response = await _dioHandler.post('', data: data);
    print(response);
    return response;
  } catch (e) {
    throw Exception("Failed to add accreditation: $e");
  }
}

//add insurance
Future addInsurance({
  required String providerID,
  required String providerName,
  required String issueDate,
  required String expiryDate,
}) async {
  final token = await SharedPreference.getToken();
  final reviewerId = await SharedPreference.getUserId();

  final c1data = jsonEncode({
      "ProviderID": providerID,
      "ProviderName": providerName,
      "IssueDate": issueDate,
      "ExpiryDate": expiryDate,
    });

  if(token!.isEmpty || reviewerId!.isEmpty) {
    throw Exception('Token or ReviewerId not found in SharedPreferences');
  }
  final data = {
    ...ApiUtils.getCommonParams(action: "reviewerins", token: token),
  "Tags": [
        {"T": "dk1", "V":reviewerId},
        {"T": "c1", "V": c1data},
        {"T": "c10", "V": "1"}
      ]
  }; 
  try {
    final response = await _dioHandler.post('' ,data: data);
    print(response);
    return response;
  } catch (e) {
    throw Exception("Failed to add insurance: $e");
  }
}
}
