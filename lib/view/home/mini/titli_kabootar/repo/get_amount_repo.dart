import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:game_on/view/home/mini/titli_kabootar/model/get_amount_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/api_url.dart';


class GetAmountRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GetAmountModel> getAmountApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(TitliKabootarApiUrl.getAmountApi,data);
      return GetAmountModel.fromJson(response);
    } catch (e) {
      if (kDebugMode){
        print('Error occurred during get amount api: $e');
      }
      rethrow;
    }
  }

}