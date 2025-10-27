import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/accreditationtype_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/certified_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/licence_authority_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty%20type_response_model.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/specialty_response_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class ListRepository {
  final DioHandler _dioHandler = DioHandler();
  //countrylist
  //countrylist
  Future<CountryResponseModel> fetchCountryList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "99"},
      ],
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


  // accreditation_type
  Future<AccreditationTypeModel> fetchAccreditationTypeList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "90"},
      ],
        {"T": "c10", "V": "90"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return AccreditationTypeModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch accreditation types: $e");
    }
  }

  // license
  Future<LicenseListResponseModel> fetchLicenseList() async {

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
        {"T": "c10", "V": "97"},
      ],
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

  //Certified
  Future<CertifiedResponseModel> fetchCertifiedList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "89"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return CertifiedResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch certified: $e");
    }
  }

  //Specility Type

  Future<SpecialtyTypeResponseModel> fetchSpecialtyTypeList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "88"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return SpecialtyTypeResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch specialtiestype: $e");
    }
  }
}

}
