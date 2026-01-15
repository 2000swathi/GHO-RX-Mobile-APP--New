import 'package:ghorx_mobile_app_new/features/account/bank_Info/repo/model/bankinfo_model.dart';
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
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return BankInfoResponseModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
   //add banking
  Future addBankInfo({
    required String accountType,
    required String routingNumber,
    required String accountNumber,
    required String holderName,
    required String bankName,
  }) async {
    final token = await SharedPreference.getToken();
    final userId = await SharedPreference.getUserId();

    if (token!.isEmpty || userId!.isEmpty) {
      throw Exception('Token or UserID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "revieweracc", token: token),
      "Tags": [
        {"T": "dk1", "V": userId},
        {"T": "c1", "V": accountType},
        {"T": "c2", "V": routingNumber},
        {"T": "c3", "V": accountNumber},
        {"T": "c4", "V": holderName},
        {"T": "c5", "V": bankName},
        {"T": "c10", "V": "1"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return response;
    } catch (e) {
      throw Exception("Failed to add Bank Info: $e");
    }
  }
  // edit Bank information
  Future editBankInfo({
    required String accountType,
    required String routingNumber,
    required String accountNumber,
    required String holderName,
    required String id,
    required String bankName,
  }) async {
    final token = await SharedPreference.getToken();
    final userID = await SharedPreference.getUserId();
    if (token!.isEmpty || userID!.isEmpty) {
      throw Exception('Token or userID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "revieweracc", token: token),
      "Tags": [
        {"T": "dk1", "V": userID},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": accountType},
        {"T": "c2", "V": routingNumber},
        {"T": "c3", "V": accountNumber},
        {"T": "c4", "V": holderName},
        {"T": "c5", "V": bankName},
        {"T": "c10", "V": "2"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return response;
    } catch (e) {
      throw Exception("Failed to edit Bank Info: $e");
    }
  }
}
