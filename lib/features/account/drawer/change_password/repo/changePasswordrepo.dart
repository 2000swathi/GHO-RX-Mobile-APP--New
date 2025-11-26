import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class Changepasswordrepo {
  final DioHandler _dioHandler = DioHandler();
  Future<Map<String, dynamic>> ChangePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c1", "V": currentPassword},
        {"T": "c2", "V": newPassword},
        {"T": "c3", "V": confirmPassword},
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
}
