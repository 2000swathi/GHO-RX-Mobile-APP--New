import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class ListRepository {
  final DioHandler _dioHandler = DioHandler();
//countrylist
  Future<CountryResponseModel> fetchCountryList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "99"}
      ]
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return CountryResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch countries: $e");
    }
  }
  //specialty
  Future<SpecialtyResponseModel> fetchSpecialtyList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "98"}
      ]
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
        {"T": "c10", "V": "97"}
      ]
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return LicenseListResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch license: $e");
    }
  }
}
