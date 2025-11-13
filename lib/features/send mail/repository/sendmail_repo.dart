import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class SendEmailRepository {
  final DioHandler _dioHandler = DioHandler();

  // Send Mail
  Future<Map<String, dynamic>> sendEmail(
    String adminEmailId,
    String doctorEmailid,
    String msg,
  ) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewercase", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": msg},
        {"T": "c1", "V": doctorEmailid},
        {"T": "c2", "V": adminEmailId},
        {"T": "c10", "V": "12"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: requestData);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  // Save Draft
  Future<void> saveDraft(String from, String to, String msg) async {
    // Local save logic (using SharedPreferences for example)
    await SharedPreference.setString('draft_from', from);
    await SharedPreference.setString('draft_to', to);
    await SharedPreference.setString('draft_msg', msg);
  }
}
