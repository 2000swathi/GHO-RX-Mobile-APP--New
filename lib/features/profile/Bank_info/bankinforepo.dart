import 'package:ghorx_mobile_app_new/features/profile/Bank_info/model/bankinfo_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class Bankinforepo {
  final DioHandler _dioHandler = DioHandler();

  // Bank Info
  Future<BankInfoResponseModel> fetchBankInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "revieweracc", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return BankInfoResponseModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
