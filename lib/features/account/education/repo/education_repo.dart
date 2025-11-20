import 'package:ghorx_mobile_app_new/features/account/education/repo/model/educationmodel.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class EducationRepo {
  final DioHandler _dioHandler = DioHandler();

  // fetch education
  Future<EducationResponse> fetchEducationInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "revieweredu", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return EducationResponse.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }
}
