import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/result_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/api_url.dart';

class ResultRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ResultModel> resultApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.resultApi,data);
      print(response);
      return ResultModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during resultApi: $e');
      }
      rethrow;
    }
  }
}