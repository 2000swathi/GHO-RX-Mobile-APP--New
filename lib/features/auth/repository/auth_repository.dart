import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/features/auth/repository/auth_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class AuthRepository {
  final DioHandler _dioHandler = DioHandler();
  Future<OtpResponse> login({
    required String email,
    required String password,
  }) async {
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: ""),
      "Tags": [
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": password},
        {"T": "c10", "V": "91"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return OtpResponse.fromJson(response);
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      rethrow;
    }
  }
}
