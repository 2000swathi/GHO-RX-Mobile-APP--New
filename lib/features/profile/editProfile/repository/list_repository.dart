import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/licence_authority_model.dart';
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

  // license list model
  Future<List<LicenseListModel>> fetchLicenseList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "97"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      final List licensesJson = response['Data'][0];
      return licensesJson
          .map((json) => LicenseListModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("$e");
    }
  }

  //issuing authority list
  Future<LicenseAuthorityModel> fetchIssuingAuthority() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "91"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return LicenseAuthorityModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch issuing authority: $e");
    }
  }
}
