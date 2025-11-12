import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/accreditation_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/bankinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/insurance_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/language_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/personalinfo_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/specialty_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class ProfileRepository {
  final DioHandler _dioHandler = DioHandler();

  // personal info

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

  // specialty

  Future<SpecialtyModel> fetchSpecialtyInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerspl", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return SpecialtyModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  // insurance
  Future<InsuranceModel> fetchInsuranceInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerins", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return InsuranceModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  // license
  Future<LicenseModel> fetchLicenseInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlic", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);

      return LicenseModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  // Language
  Future<LanguageModel> fetchLanguageInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "reviewerlang", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return LanguageModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

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
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      print(response);
      return AccreditationModel.fromJson(response);
    } catch (e) {
      throw (e.toString());
    }
  }

  // Bank Info
  Future<BankInfoResponseModel> fetchBankInfo() async {
    final token = await SharedPreference.getToken();
    final reviewerId = await SharedPreference.getUserId();
    if (token!.isEmpty || reviewerId!.isEmpty) {
      throw Exception('Token or ReviewerId not found in SharedPreferences');
    }

    final data = {
      ...ApiUtils.getCommonParams(action: "revieweracc", token: token),
      "Tags": [
        {"T": "dk1", "V": reviewerId},
        {"T": "dk2", "V": "0"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return BankInfoResponseModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
