import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class DateRangeRepo {
  final DioHandler _dioHandler = DioHandler();

   Future<Map<String, dynamic>> fetchDateRange() async {
    final token = await SharedPreference.getToken();

    if (token!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: token),
      "Tags": [
        {"T": "dk1", "V": "DATERANGE"},
        {"T": "c10", "V": "87"},
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