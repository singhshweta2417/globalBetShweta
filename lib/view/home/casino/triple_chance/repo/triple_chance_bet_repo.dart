import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import '../res/api_url.dart';


class TripleChanceBetRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> tripleChanceBetApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(TripleChanceApiUrl.tripleChanceBet, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during tripleChanceBetApi: $e');
      }
      rethrow;
    }
  }
}