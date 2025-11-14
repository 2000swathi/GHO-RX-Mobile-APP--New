import 'dart:convert';

import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/personalinfo_model.dart';
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

      final info = PersonalInfoModel.fromJson(response['Data'][0][0]);
      await SharedPreference.setEmail(info.email);
      return info;
    } catch (e) {
      throw (e.toString());
    }
  }
}
