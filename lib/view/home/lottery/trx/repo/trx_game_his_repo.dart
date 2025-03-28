import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/trx/model/trx_game_his_model.dart';
import 'package:game_on/view/home/lottery/trx/res/trx_api_url.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';

class TrxGameHisRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<TrxGameHisModel> trxGameHisApi(context, dynamic gameId,dynamic offset) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("${TrxApiUrl.trxGameHis}$gameId&offset=$offset");
      return TrxGameHisModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during trxGameHisApi: $e');
      }
      rethrow;
    }
  }
}