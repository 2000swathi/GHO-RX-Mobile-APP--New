import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/features/cases/casedetails/case_details_page/repository/model/case_details_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class CaseDetRepository {
  final DioHandler _dioHandler = DioHandler();


  // case details
  Future<CaseDetailsModel> getcaseDetails({required String saltID}) async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    final data = {
      ...ApiUtils.getCommonParams(action: "reviewercase", token: token.toString()),
      "Tags": [
        {"T": "dk1", "V": saltID},
        {"T": "dk2", "V": reviewerId},
        {"T": "c10", "V": "13"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return CaseDetailsModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception("${e.message}");
    } catch (e) {
      rethrow;
    }
  }
}
