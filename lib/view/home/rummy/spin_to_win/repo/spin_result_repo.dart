import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/model/spin_result_model.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/res/api_url.dart';

class SpinResultRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<SpinResultModel> spinResultApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(SpinApiUrl.spinResultUrl + data);
      return SpinResultModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during spinResultApi: $e');
      }
      rethrow;
    }
  }
}
