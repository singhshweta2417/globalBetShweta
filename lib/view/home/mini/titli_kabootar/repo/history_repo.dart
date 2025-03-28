import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:game_on/view/home/mini/titli_kabootar/model/history_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/api_url.dart';

class HistoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<HistoryModel> historyApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(TitliKabootarApiUrl.betHistoryApi,data);
      return HistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during historyApi: $e');
      }
      rethrow;
    }
  }
}