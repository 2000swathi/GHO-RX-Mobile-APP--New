import 'dart:convert';

import 'package:ghorx_mobile_app_new/features/account/personal_info/repo/model/personalinfo_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class ProfileInfoRepo {
  final DioHandler _dioHandler = DioHandler();

  //get
  Future<PersonalInfoModel> fetchPersonalInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewer", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "7"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);

      final dataList = response['Data'];
      if (dataList == null || dataList.isEmpty) {
        throw "Data is null or empty";
      }

      final innerList = dataList[0];
      if (innerList == null || innerList.isEmpty) {
        throw "Inner data is null or empty";
      }

      final infoJson = innerList[0];
      if (infoJson == null) {
        throw "Personal info data is null";
      }

      final info = PersonalInfoModel.fromJson(infoJson);

      if (info.email.isNotEmpty) {
        await SharedPreference.setEmail(info.email);
      } else {
        print("Email is null or empty — not saving to SharedPreferences");
      }

      return info;
    } catch (e) {
      throw e.toString();
    }
  }

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
}
