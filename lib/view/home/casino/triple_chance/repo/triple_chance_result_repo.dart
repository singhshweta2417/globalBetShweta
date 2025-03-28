import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
import '../model/triple_chance_result_model.dart';
import '../res/api_url.dart';


class TripleChanceResultRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<TripleChanceResultModel> tripleChanceResultApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(TripleChanceApiUrl.tripleChanceResult+data);
      return TripleChanceResultModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during tripleChanceResultApi: $e');
      }
      rethrow;
    }
  }
}
