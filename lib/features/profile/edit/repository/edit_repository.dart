import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class EditprofileRepository {
  final DioHandler _dioHandler = DioHandler();

  //edit profile
  Future<Map<String, dynamic>> editPersonalInfo(
    Map<String, dynamic> data,
  ) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c1", "V": jsonEncode(data)},
        {"T": "c10", "V": "1"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: requestData);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  //Specialty
  Future<Map<String, dynamic>> editSpecialty({
    required String specialtyId,
    required String specialty,
    required String certifiedBoard,
    required String specialtyType,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final c1data = jsonEncode({
      "SpecialtyID": specialty,
      "CertifiedBoard": certifiedBoard,
      "SpecialtyType": specialtyType,
    });

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewerspl", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": specialtyId},
        {"T": "c1", "V": c1data},
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

  //Accreditation
  Future<Map<String, dynamic>> editAccreditation({
    required String accreditationId,
    required String accreditationtype,
    required String accreditationbody,
    required String accreditationnumber,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final requestData = {
      ...ApiUtils.getCommonParams(action: "revieweraccred", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": accreditationId},
        {"T": "c1", "V": accreditationtype},
        {"T": "c2", "V": accreditationbody},
        {"T": "c3", "V": accreditationnumber},
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

  //Insurance
  Future<Map<String, dynamic>> editInsurance({
    required String insuranceId,
    required String providerID,
    required String providerName,
    required String issueDate,
    required String expiryDate,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final c1data = jsonEncode({
      "ProviderID": providerID,
      "ProviderName": providerName,
      "IssueDate": issueDate,
      "ExpiryDate": expiryDate,
    });

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewerins", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": insuranceId},
        {"T": "c1", "V": c1data},
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
