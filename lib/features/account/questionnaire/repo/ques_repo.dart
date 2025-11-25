import 'dart:convert';

import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class QuestionnaireRepo {
  final DioHandler _dioHandler = DioHandler();

  Future<Map<String, dynamic>> AnswerCheck(
    String qID,
    bool answer,
    String comments,
  ) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerque", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {
          "T": "c1",
          "V": jsonEncode({
            "QuestionnaireID": qID,
            "Answer": answer ? "yes" : "no",
            "Comments": comments,
          }),
        },
        {"T": "c10", "V": "1"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
