import 'dart:convert';

import 'package:ghorx_mobile_app_new/features/account/education/repo/model/educationmodel.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class EducationRepo {
  final DioHandler _dioHandler = DioHandler();

  // fetch education
  Future<EducationResponse> fetchEducationInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "revieweredu", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "3"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return EducationResponse.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  //add education
  Future addeducation({
    required String institution,
    required String degree,
    required String duration,
    required String year,
    required String comments,
  }) async {
  final token = await SharedPreference.getToken();
  final reviewerId = await SharedPreference.getUserId();

  if (token!.isEmpty || reviewerId!.isEmpty) {
    throw Exception('Token or ReviewerId not found in SharedPreferences');
  }

  final educationJson = jsonEncode({
    "Institution": institution,
    "Degree": degree,
    "Duration": duration,
    "CompletedYear": year,
    "Comments": comments,
  });
  final data = {
      ...ApiUtils.getCommonParams(action: "revieweredu", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c1", "V": educationJson},
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

  //edit education
  Future<Map<String, dynamic>> editEducation({
    required String id,
    required String institution,
    required String degree,
    required String duration,
    required String year,
    required String comments,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if(token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or reviewerId is empty');
    }

    final editEduJson = jsonEncode({
    "Institution": institution,
    "Degree": degree,
    "Duration": duration,
    "CompletedYear": year,
    "Comments": comments,
    });

    final requestData = {
      ...ApiUtils.getCommonParams(action: "revieweredu", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": editEduJson},
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
