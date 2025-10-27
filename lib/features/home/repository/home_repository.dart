import 'package:ghorx_mobile_app_new/features/home/repository/model/homepage_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class HomeRepository {
  final DioHandler _dioHandler = DioHandler();

  Future<HomePageModel> fetchHomePageInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "casereviewer", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "1"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return HomePageModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
