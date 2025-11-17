import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class SummaryReo {
  final DioHandler _dioHandler = DioHandler();

  Future<Map<String, dynamic>> saveSummary(
    String saltID,
    String summary,
  ) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewercase", token: token),
      "Tags": [
        {"T": "dk1", "V": saltID},
        {"T": "c1", "V": summary},
        {"T": "c10", "V": "14"},
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
