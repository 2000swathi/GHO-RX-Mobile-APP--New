import 'package:ghorx_mobile_app_new/features/account/languages/repo/model/language_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class LanguageRepo {
  final DioHandler _dioHandler = DioHandler();
  // Language
  Future<LanguageModel> fetchLanguageInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlang", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return LanguageModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  //add language
  Future addLanguage({required String language}) async {
    final token = await SharedPreference.getToken();
    final userId = await SharedPreference.getUserId();

    if (token!.isEmpty || userId!.isEmpty) {
      throw Exception('Token or UserID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlang", token: token),
      "Tags": [
        {"T": "dk1", "V": userId},
        {"T": "c1", "V": language},
        // {"T": "c2", "V": proficiency},
        {"T": "c10", "V": "1"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);

      return response;
    } catch (e) {
      throw Exception("Failed to add Language: $e");
    }
  }

  //edit language
  Future editLanguage({required String language, required String id}) async {
    final token = await SharedPreference.getToken();
    final userID = await SharedPreference.getUserId();
    if (token!.isEmpty || userID!.isEmpty) {
      throw Exception('Token or userID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlang", token: token),
      "Tags": [
        {"T": "dk1", "V": token},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": language},
        // {"T": "c2", "V": proficiency},
        {"T": "c10", "V": "4"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to add Language: $e");
    }
  }
}
