import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';

import '../model/triple_chance_history_model.dart';
import '../res/api_url.dart';



class TripleChanceHistoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<TripleChanceHistoryModel> tripleChanceHistoryApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(TripleChanceApiUrl.tripleChanceHistory+ data);
      return TripleChanceHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during tripleChanceHistoryApi: $e');
      }
      rethrow;
    }
  }
}