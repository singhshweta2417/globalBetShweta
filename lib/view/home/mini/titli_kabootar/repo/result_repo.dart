import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:game_on/view/home/mini/titli_kabootar/model/result_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/api_url.dart';

class ResultRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ResultModel> resultApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(TitliKabootarApiUrl.resultApi,data);
      return ResultModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during resultApi: $e');
      }
      rethrow;
    }
  }
}