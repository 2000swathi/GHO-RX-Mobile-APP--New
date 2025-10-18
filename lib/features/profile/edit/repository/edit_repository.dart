import 'dart:convert';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class EditprofileRepository {
  final DioHandler _dioHandler = DioHandler();

  //edit profile
  Future<Map<String, dynamic>> editPersonalInfo(
    Map<String, dynamic> data,
  ) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c1", "V": jsonEncode(data)},
        {"T": "c10", "V": "1"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: requestData);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  //edit license
  Future editLicense({
    required String licenseNumber,
    required String issuingAuthority,
    required String licenseType,
    required String issueDate,
    required String expiryDate,
    required String id,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }
    final c1Editdata = jsonEncode({
      "LicenseNumber": licenseNumber,
      "IssuingAuthority": issuingAuthority,
      "LicenseType": licenseType,
      "IssueDate": issueDate,
      "ExpiryDate": expiryDate,
      "Id": id,
    });
    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewerlic", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": c1Editdata},
        {"T": "c10", "V": "2"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: requestData);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  //edit language
  Future editLanguage({
    required String language,
    required String proficiency,
    required String id,
  }) async {
    final token = await SharedPreference.getToken();
    final userID = await SharedPreference.getUserId();
    if (token!.isEmpty || userID!.isEmpty) {
      throw Exception('Token or userID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlang", token: token),
      "Tags": [
        {"T": "dk1", "V": token}, //ReviewerIDAlt
        {"T": "dk2", "V": id}, //Reviewer language id
        {"T": "c1", "V": language}, //language
        {"T": "c2", "V": proficiency}, //proficiency
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

  // edit Bank information
  Future editBankInfo({
    required String accountType,
    required String routingNumber,
    required String accountNumber,
    required String holderName,
    required String id,
  }) async {
    final token = await SharedPreference.getToken();
    final userID = await SharedPreference.getUserId();
    if (token!.isEmpty || userID!.isEmpty) {
      throw Exception('Token or userID not found in SharedPreferences');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "revieweracc", token: token),
      "Tags": [
        {"T": "dk1", "V": token},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": accountType}, //account type
        {"T": "c2", "V": routingNumber}, //routing number
        {"T": "c3", "V": accountNumber}, //account number
        {"T": "c4", "V": holderName}, //holder name
        {"T": "c10", "V": "2"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to edit Bank Info: $e");
    }
  }
}
