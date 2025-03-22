import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/model/lucky_16_history_model.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';

import '../res/api_url.dart';


class Lucky16HistoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<Lucky16HistoryModel> lucky16HistoryApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.lucky16history+ data);
      return Lucky16HistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during lucky16HistoryApi: $e');
      }
      rethrow;
    }
  }
}