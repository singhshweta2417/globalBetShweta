import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:game_on/view/home/rummy/spin_to_win/model/spin_history_model.dart';
import 'package:game_on/view/home/rummy/spin_to_win/res/api_url.dart';

class SpinHistoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<SpinHistoryModel> spinHistoryApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(SpinApiUrl.spinHistoryUrl + data);
      return SpinHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during spinHistoryApi: $e');
      }
      rethrow;
    }
  }
}