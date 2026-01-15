import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class AttestationRepo {
  final DioHandler _dioHandler = DioHandler();

  Future<Map<String, dynamic>> addAttestation(
    String caseReviewerID,
    int attestationID,
  ) async {
    final token = await SharedPreference.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token  not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "caseattestation", token: token),
      "Tags": [
        {"T": "dk1", "V": caseReviewerID},
        {"T": "dk2", "V": attestationID.toString()},
        {"T": "c1", "V": "1"},
        {"T": "c10", "V": "5"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } on DioException catch (e) {
      throw Exception("Failed to add attestation: ${e.message}");
    } catch (e) {
      rethrow;
    }
  }
}
