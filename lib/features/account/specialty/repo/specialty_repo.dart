import 'dart:convert';
import 'package:ghorx_mobile_app_new/features/account/specialty/repo/model/specialty_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class SpecialtyRepo {
  final DioHandler _dioHandler = DioHandler();
  //get
  Future<SpecialtyModel> fetchSpecialtyInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerspl", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return SpecialtyModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  //add
  Future addSpecialty({
    required String specialtyID,
    required String certifiedBoardId,
    required String specialtyTypeID,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    final c1data = jsonEncode({
      "SpecialtyID": specialtyID,
      "CertifiedBoard": certifiedBoardId,
      "SpecialtyType": specialtyTypeID,
    });
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerspl", token: token),
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
      throw Exception("Failed to add specialty: $e");
    }
  }

  //edit
  Future<Map<String, dynamic>> editSpecialty({
    required String specialtyId,
    required String id,
    required String certifiedBoardName,
    required String specialtyTypeId,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final c1data = jsonEncode({
      "SpecialtyID": specialtyId,
      "CertifiedBoard": certifiedBoardName,
      "SpecialtyType": specialtyTypeId,
    });

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewerspl", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": id},
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
