import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class QAndASaveRepo {
  final DioHandler _dioHandler = DioHandler();

  // save questions
  Future<Map<String, dynamic>> saveAnswersSpport({
    required String saltID,
    required String questID,
    required String answer,
    required String support,
  }) async {
    final token = await SharedPreference.getToken();
    final data = {
      ...ApiUtils.getCommonParams(
        action: "reviewercase",
        token: token.toString(),
      ),
      "Tags": [
        {"T": "dk1", "V": saltID},
        {"T": "dk2", "V": questID},
        {"T": "c1", "V": answer},
        {"T": "c2", "V": support},
        {"T": "c10", "V": "16"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } on DioException catch (e) {
      throw Exception("${e.message}");
    } catch (e) {
      rethrow;
    }
  }
}
