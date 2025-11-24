import 'dart:convert';

import 'package:ghorx_mobile_app_new/features/account/professional%20references/repo/model/professionaleref_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class ProfessionalrefRepo {
  final DioHandler _dioHandler = DioHandler();

  //professional ref list

  Future<ProfessionalerefModel> fetchProfessionalinfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerref", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId}, //required to update
        {"T": "dk2", "V": "0"}, // Reviewer ReferenceId (0 to list all)
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return ProfessionalerefModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  //Add professional reference
  Future addProRef({
    required String fullName,
    required String designation,
    // required this.designation1,
    required String relationship,
    required String phone,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final c1Value = jsonEncode({
      "FullName": fullName,
      "Designation": designation,
      "Relationship": relationship,
      "Phone": phone,
    });
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerref", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId}, //required to add
        {"T": "c1", "V": c1Value},
        {"T": "c10", "V": "1"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);

      return response;
    } catch (e) {
      throw Exception("Failed to add professional reference: $e");
    }
  }

  //Edit professional reference
  Future<Map<String, dynamic>> editProRef({
    required String refId,
    required String fullName,
    required String designation,
    required String relationship,
    required String phone,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final c1Value = jsonEncode({
      "FullName": fullName,
      "Designation": designation,
      "Relationship": relationship,
      "Phone": phone,
    });
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerref", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId}, //required to update
        {"T": "dk2", "V": refId},
        {"T": "c1", "V": c1Value},
        {"T": "c10", "V": "2"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  //delete
}
