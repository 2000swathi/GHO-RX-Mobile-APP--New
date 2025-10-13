import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class AddProfileRepository {
  final DioHandler _dioHandler = DioHandler();

//add specialty
  Future addSpecialty() async {
     final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: token),
      "Tags": [
        {"T": "dk1", "V":reviewerId},
        {"T": "c10", "V": "1"}
      ]
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to add specialty: $e");
    }
  }
}
