import 'package:flutter/foundation.dart';
import 'package:globalbet/model/country_model.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';


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
