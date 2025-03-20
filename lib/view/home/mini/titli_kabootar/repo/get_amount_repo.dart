import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/get_amount_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/api_url.dart';


class GetAmountRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<GetAmountModel> getAmountApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.getAmountApi,data);
      return GetAmountModel.fromJson(response);
    } catch (e) {
      if (kDebugMode){
        print('Error occurred during get amount api: $e');
      }
      rethrow;
    }
  }

}