import 'package:flutter/foundation.dart';
import 'package:game_on/model/country_model.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';


class CountryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<CountryCodeModel> countryApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.country, data);
      return CountryCodeModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during countryApi: $e');
      }
      rethrow;
    }
  }
}
