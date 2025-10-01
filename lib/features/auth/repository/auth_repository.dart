import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class AuthRepository {
  final DioHandler _dioHandler = DioHandler();
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final data = {
      ...ApiUtils.getCommonParams(
        action: "reviewer",
        token: "8f78e9b615c14cfaa28dda35fdbd721e",
      ),
      "Tags": [
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": password},
        {"T": "c10", "V": "91"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      if (response["Status"] == 1) {
        print("success");
      }
      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final apiMessage =
            e.response?.data['msg'] ?? e.response?.data.toString();
        throw Exception(apiMessage);
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
