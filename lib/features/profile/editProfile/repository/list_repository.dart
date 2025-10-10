import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/features/profile/editProfile/repository/model/country_response_model.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class ListRepository {
  final DioHandler _dioHandler = DioHandler();

  Future<List<CountryResponseModel>> fetchCountryList() async {
  final data = {
    ...ApiUtils.getCommonParams(action: "lists", token: ""),
    "Tags": [
      {"T": "c10", "V": "99"}
    ]
  };

  try {
    final response = await _dioHandler.post('', data: data);
    final countriesJson = (response['countries'] ??
            response['data'] ??
            response['result']) as List?; 

    if (countriesJson == null || countriesJson.isEmpty) {
      return []; 
    }

    return countriesJson
        .map((json) => CountryResponseModel.fromJson(json))
        .toList();
  } on DioException catch (e) {
    throw Exception("Failed to fetch countries: ${e.response?.data ?? e.message}");
  } catch (e) {
    throw Exception("Unexpected error: $e");
  }
}

}
