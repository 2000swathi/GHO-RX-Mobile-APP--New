import 'package:dio/dio.dart';
import 'package:ghorx_mobile_app_new/utilities/network/api_utils.dart';
import 'package:ghorx_mobile_app_new/utilities/network/dio_handler.dart';

class CountryRepository {
  final DioHandler _dioHandler = DioHandler();

  Future<List<Map<String, dynamic>>> getCountries() async {
    final data = {
      ...ApiUtils.getCommonParams(action: "lists", token: ""),
      "Tags": [
        {"T": "c10", "V": "99"}
      ]
    };

    try {
      final response = await _dioHandler.post('', data: data);

      if (response['Status'] == 1 && response['Data'] != null && response['Data'].isNotEmpty) {
        final countriesList = List<Map<String, dynamic>>.from(response['Data'][0]);
        return countriesList;
      } else {
        throw Exception(response['Error'] ?? "Failed to fetch countries");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}
