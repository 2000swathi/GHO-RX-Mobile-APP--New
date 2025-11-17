import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class AttestationRepo {
  final DioHandler _dioHandler = DioHandler();

  Future<Map<String, dynamic>> getAttestation(String saltKey) async {
    final token = await SharedPreference.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token  not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewercase", token: token),
      "Tags": [
        {"T": "dk1", "V": saltKey},
        {"T": "c10", "V": "15"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
