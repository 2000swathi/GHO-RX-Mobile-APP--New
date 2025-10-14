import 'dart:convert';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class EditprofileRepository {
  final DioHandler _dioHandler = DioHandler();

//edit profile
Future<Map<String, dynamic>> editPersonalInfo(Map<String, dynamic> data) async {
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
}