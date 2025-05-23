import 'package:flutter/foundation.dart';
import 'package:game_on/model/offer_model.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';


class OfferRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<OfferModel> offerApi() async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse(ApiUrl.offer);
      return OfferModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during offerApi: $e');
      }
      rethrow;
    }
  }
}
