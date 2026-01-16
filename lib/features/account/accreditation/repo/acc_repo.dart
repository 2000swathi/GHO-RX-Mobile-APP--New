import 'package:ghorx_mobile_app_new/features/account/accreditation/repo/model/accreditationsmodel.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class AccRepo {
  final DioHandler _dioHandler = DioHandler();

  // Accreditation
  Future<AccreditationModel> fetchAccreditationInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "revieweraccred", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "6"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return AccreditationModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  //add
  Future<Map<String, dynamic>> addAccreditation({
    required String accreditationName,
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
        {"T": "c1", "V": accreditationName},
        {"T": "c4", "V": "1"},
        {"T": "c10", "V": "5"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: requestData);
      return response;
    } catch (e) {
      throw (e.toString());
    }
  }

  // // edit
  // Future<Map<String, dynamic>> editAccreditation({
  //   required String accreditationtype,
  //   required String accreditationbody,
  // }) async {
  //   final token = await SharedPreference.getToken();
  //   final reviewerId = await SharedPreference.getUserId();

  //   if (token!.isEmpty || reviewerId!.isEmpty) {
  //     throw Exception('Token or ReviewerId not found in SharedPreferences');
  //   }

  //   final requestData = {
  //     ...ApiUtils.getCommonParams(action: "revieweraccred", token: token),
  //     "Tags": [
  //       {"T": "dk1", "V": reviewerId},
  //       {"T": "c1", "V": accreditationtype},
  //       {"T": "c4", "V": "1"},
  //       {"T": "c10", "V": "5"},
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
}
