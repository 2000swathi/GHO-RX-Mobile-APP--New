import 'dart:convert';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class EditprofileRepository {
  final DioHandler _dioHandler = DioHandler();

  // //edit profile
  // Future<Map<String, dynamic>> editPersonalInfo(
  //   Map<String, dynamic> data,
  // ) async {
  //   final token = await SharedPreference.getToken();
  //   final reviewerId = await SharedPreference.getUserId();
  //   if (token!.isEmpty || reviewerId!.isEmpty) {
  //     throw Exception('Token or ReviewerId not found in SharedPreferences');
  //   }

  //   final requestData = {
  //     ...ApiUtils.getCommonParams(action: "reviewer", token: token),
  //     "Tags": [
  //       {"T": "dk1", "V": reviewerId},
  //       {"T": "c1", "V": jsonEncode(data)},
  //       {"T": "c10", "V": "1"},
  //     ],
  //   };
  //   try {
  //     final response = await _dioHandler.post('', data: requestData);
  //     return response;
  //   } catch (e) {
  //     throw (e.toString());
  //   }
  // }

  // //edit license
  // Future editLicense({
  //   required String licenseNumber,
  //   required String issuingAuthority,
  //   required String licenseType,
  //   required String issueDate,
  //   required String expiryDate,
  //   required String id,
  // }) async {
  //   final token = await SharedPreference.getToken();
  //   final reviewerId = await SharedPreference.getUserId();
  //   if (token!.isEmpty || reviewerId!.isEmpty) {
  //     throw Exception('Token or ReviewerId not found in SharedPreferences');
  //   }
  //   final c1Editdata = jsonEncode({
  //     "LicenseNumber": licenseNumber,
  //     "IssuingAuthority": issuingAuthority,
  //     "LicenseType": licenseType,
  //     "IssueDate": issueDate,
  //     "ExpiryDate": expiryDate,
  //     "Id": id,
  //   });
  //   final requestData = {
  //     ...ApiUtils.getCommonParams(action: "reviewerlic", token: token),
  //     "Tags": [
  //       {"T": "dk1", "V": reviewerId},
  //       {"T": "dk2", "V": id},
  //       {"T": "c1", "V": c1Editdata},
  //       {"T": "c10", "V": "2"},
  //     ],
  //   };
  //   try {
  //     final response = await _dioHandler.post('', data: requestData);
  //     print(response);
  //     return response;
  //   } catch (e) {
  //     throw (e.toString());
  //   }
  // }

  // //edit language
  // Future editLanguage({
  //   required String language,
  //   required String proficiency,
  //   required String id,
  // }) async {
  //   final token = await SharedPreference.getToken();
  //   final userID = await SharedPreference.getUserId();
  //   if (token!.isEmpty || userID!.isEmpty) {
  //     throw Exception('Token or userID not found in SharedPreferences');
  //   }
  //   final data = {
  //     ...ApiUtils.getCommonParams(action: "reviewerlang", token: token),
  //     "Tags": [
  //       {"T": "dk1", "V": token}, //ReviewerIDAlt
  //       {"T": "dk2", "V": id}, //Reviewer language id
  //       {"T": "c1", "V": language}, //language
  //       {"T": "c2", "V": proficiency}, //proficiency
  //       {"T": "c10", "V": "4"},
  //     ],
  //   };

  //   try {
  //     final response = await _dioHandler.post('', data: data);
  //     return response;
  //   } catch (e) {
  //     throw Exception("Failed to add Language: $e");
  //   }
  // }

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
        {"T": "dk1", "V": userID},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": accountType},
        {"T": "c2", "V": routingNumber},
        {"T": "c3", "V": accountNumber},
        {"T": "c4", "V": holderName},
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

  //Specialty
  Future<Map<String, dynamic>> editSpecialty({
    required String specialtyId,
    required String id,
    required String certifiedBoard,
    required String specialtyType,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final c1data = jsonEncode({
      "SpecialtyID": specialtyId,
      "CertifiedBoard": certifiedBoard,
      "SpecialtyType": specialtyType,
    });

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewerspl", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": id},
        {"T": "c1", "V": c1data},
        {"T": "c2", "V": certifiedBoard},
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

  //Accreditation
  Future<Map<String, dynamic>> editAccreditation({
    required String accreditationId,
    required String accreditationtype,
    required String accreditationbody,
    required String accreditationnumber,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final requestData = {
      ...ApiUtils.getCommonParams(action: "revieweraccred", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": accreditationId},
        {"T": "c1", "V": accreditationtype},
        {"T": "c2", "V": accreditationbody},
        {"T": "c3", "V": accreditationnumber},
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

  //Insurance
  Future<Map<String, dynamic>> editInsurance({
    required String insuranceId,
    required String providerID,
    required String providerName,
    required String issueDate,
    required String expiryDate,
  }) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();

    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final c1data = jsonEncode({
      "ProviderID": providerID,
      "ProviderName": providerName,
      "IssueDate": issueDate,
      "ExpiryDate": expiryDate,
    });

    final requestData = {
      ...ApiUtils.getCommonParams(action: "reviewerins", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": insuranceId},
        {"T": "c1", "V": c1data},
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
}
