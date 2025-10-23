import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/viewProfile/repository/model/license_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';
import 'package:ghorx_mobile_app_new/utilities/shared_preference.dart';

class ListRepository {
  final DioHandler _dioHandler = DioHandler();
  //countrylist
  Future<CountryResponseModel> fetchCountryList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "99"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return CountryResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch countries: $e");
    }
  }

  // specialty
  Future<SpecialtyResponseModel> fetchSpecialtyList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "98"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return SpecialtyResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch specialties: $e");
    }
  }

  // license
  Future<LicenseListResponseModel> fetchLicenseList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "97"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return LicenseListResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch license: $e");
    }
  }

  //issuing authority list
  Future<LicenseModel> fetchIssuingAuthority() async {
    final token = await SharedPreference.getToken();

    if (token == null || token.isEmpty) {
      throw Exception("Token not found. Please log in again.");
    }
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: token),
      "Tags": [
        {"T": "c10", "V": "91"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return LicenseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch issuing authority: $e");
    }
  }
}
