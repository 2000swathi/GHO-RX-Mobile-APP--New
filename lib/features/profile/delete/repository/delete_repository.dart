import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class DeleteProfileRepository {
  final DioHandler _dioHandler = DioHandler();

  Future deleteInfo({
    required String id,
    bool isLang = false,
    required String action,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": id},

        {"T": "c10", "V": isLang == true ? "2" : "4"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
