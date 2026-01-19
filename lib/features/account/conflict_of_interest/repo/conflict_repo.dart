import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class ConflictOfInterestRepo {
  final DioHandler _dioHandler = DioHandler();

    // fetch 
    Future<Map<String, dynamic>> fetchConflictInterest() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerque", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId}, 
        {"T": "c1", "V": "2"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> addConflictInterest(String id, String value) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerque", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": int.parse(id)},
        {"T": "c4", "V": value},
        {"T": "c10", "V": "5"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}