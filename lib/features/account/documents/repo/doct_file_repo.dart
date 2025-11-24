import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class DoctFileRepo {
  final DioHandler _dioHandler = DioHandler();
  // Repository code here
  Future<Map<String, dynamic>> fetchDoctFile() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "15"},
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
