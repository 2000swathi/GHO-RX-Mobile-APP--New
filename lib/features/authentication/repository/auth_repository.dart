import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/model/login_model.dart';
import 'package:ghorx_mobile_app_new/features/authentication/repository/model/otp_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class AuthRepository {
  final DioHandler _dioHandler = DioHandler();

  // login
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
      throw Exception("${e.message}");
    } catch (e) {
      rethrow;
    }
  }

  //otp validate
  Future<OtpVerifyResponse> otp({
    required String email,
    required String otp,
  }) async {
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: ""),
      "Tags": [
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": otp},
        {"T": "c10", "V": "93"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return OtpVerifyResponse.fromJson(response);
    } on DioException catch (e) {
      throw Exception("${e.message}");
    } catch (e) {
      rethrow;
    }
  }
  //otp resend
  Future<OtpResponse> otpResend({
    required String email,
  }) async {
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: ""),
      "Tags": [
        {"T": "dk1", "V": email},
        {"T": "c10", "V": "92"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return OtpResponse.fromJson(response);
    } on DioException catch (e) {
      throw Exception("${e.message}");
    } catch (e) {
      rethrow;
    }
  }
}
