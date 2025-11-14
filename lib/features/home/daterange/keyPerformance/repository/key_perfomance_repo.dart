import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class KeyPerRepo {
  final DioHandler _dioHandler = DioHandler();

  Future<Map<String, dynamic>> fetchPerformance(String dateValue) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": dateValue},
        {"T": "c10", "V": "9"},
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
