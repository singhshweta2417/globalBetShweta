import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/mini/mines/model/mine_bet_his_model.dart';
import 'package:globalbet/view/home/mini/mines/res/mine_api_url.dart';

class MineBetHisRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MineBetHisModel> mineBetHisApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(MineApiUrl.mineBetHistory+data);
      return MineBetHisModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during mineBetHisApi: $e');
      }
      rethrow;
    }
  }
}