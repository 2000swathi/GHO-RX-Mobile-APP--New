import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/accreditationtype_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/certified_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/education_typemodel.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/issueing_authority.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/license_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/specialty%20type_response_model.dart';
import 'package:ghorx_mobile_app_new/features/account/lists/repository/model/specialty_response_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class ListRepository {
  final DioHandler _dioHandler = DioHandler();
  final String action = "lists";
  //countrylist
  Future<CountryResponseModel> fetchCountryList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
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
      ...ApiUtils.getCommonParams(action: action, token: ""),
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

  // accreditation_type
  Future<AccreditationTypeModel> fetchAccreditationTypeList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
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
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "dk1", "V": "LICENSETYPE"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return LicenseListResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch license: $e");
    }
  }

  //Certified
  Future<CertifiedResponseModel> fetchCertifiedList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
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
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "c10", "V": "88"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return SpecialtyTypeResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch specialties type: $e");
    }
  }

  //Issueing Authority
  Future<IssueingAuthorityResponseModel> fetchIssueingAuthorityList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "dk1", "V": "ISSUINGAUTHORITY"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return IssueingAuthorityResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to fetch issueing authority: $e");
    }
  }

  Future<Map<String, dynamic>> fetchLangList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "dk1", "V": "LANGUAGE"},
        {"T": "c10", "V": "3"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch language list: $e");
    }
  }
  //fetch questions

  Future<Map<String, dynamic>> fetchQuestionsList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "c10", "V": "85"},
      ],
    };

    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch questions list: $e");
    }
  }

  //degree type
  Future<EducationTypeModel> fetchDegreeList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "dk1", "V": "DEGREE"},
        {"T": "c10", "V": "3"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return EducationTypeModel.fromJson(response); 
    } catch (e) {
      throw Exception("Failed to fetch degree list: $e");
    }
  }

  // doctype lists
  Future<Map<String, dynamic>> fetchDocTypeList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "dk1", "V": "REVIEWERFILE"},
        {"T": "c10", "V": "3"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch doc type list: $e");
    }
  }

  //reference list
  Future<Map<String, dynamic>> fetchReferenceList() async {
    final data = {
      ...ApiUtils.getCommonParams(action: action, token: ""),
      "Tags": [
        {"T": "dk1", "V": "REFERENCERELATION"},
        {"T": "c10", "V": "3"},
      ],
    };
    try {
      final response = await _dioHandler.post('', data: data);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch reference type list: $e");
    }
  }
}
