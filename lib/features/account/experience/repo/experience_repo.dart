import 'dart:convert';

import 'package:ghorx_mobile_app_new/features/account/experience/repo/model/experience_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class ProfessionalExperienceRepo {
  final DioHandler _dioHandler = DioHandler();

  //list experience
  Future<ProfessionalExperienceModel> fetchExperience() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerexp", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "3"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return ProfessionalExperienceModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  //add experience
  Future addExperience({
    required String institution,
    required String designation,
    required String fromMonth,
    required String fromYear,
    required String toMonth,
    required String toYear,
    required String comments,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or reviewerId is empty');
    }

    final expJson = jsonEncode({
      "Institution": institution,
      "Designation": designation,
      "FromMonth": fromMonth,
      "FromYear": fromYear,
      "ToMonth": toMonth,
      "ToYear": toYear,
      "Comments": comments,
    });

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerexp", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c1", "V": expJson},
        {"T": "c10", "V": "1"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  //edit experience
  Future<Map<String, dynamic>> editExperience({
    required String id,
    required String institution,
    required String designation,
    required String fromMonth,
    required String fromYear,
    required String toMonth,
    required String toYear,
    required String comments,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or reviewerId is empty');
    }

    final expJson = jsonEncode({
      "Institution": institution,
      "Designation": designation,
      "FromMonth": fromMonth,
      "FromYear": fromYear,
      "ToMonth": toMonth,
      "ToYear": toYear,
      "Comments": comments,
    });
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerexp", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": expJson},
        {"T": "c10", "V": "2"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }
}
