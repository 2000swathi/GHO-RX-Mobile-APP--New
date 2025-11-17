import 'package:ghorx_mobile_app_new/features/authentication/cases/cases_pages/tab_contents/repository/model/closed_case_model.dart';
import 'package:ghorx_mobile_app_new/features/authentication/cases/cases_pages/tab_contents/repository/model/open_case_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class OpenClosedRepository {
  final DioHandler _dioHandler = DioHandler();

  //opencases
  Future<List<OpenCaseModel>> fetchOpenCases() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewercase", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "6"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return (response['Data'][0] as List)
          .map((caseJson) => OpenCaseModel.fromJson(caseJson))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch Open cases: $e");
    }
  }

  //closedcases
  Future<List<ClosedCaseModel>> fetchClosedCases() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found');
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewercase", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "7"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return (response['Data'][0] as List)
          .map((caseJson) => ClosedCaseModel.fromJson(caseJson))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch closed cases: $e");
    }
  }
}
