import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/account_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/api_url.dart';

class DepositRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> userPayin(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiUrl.userPayin, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during userPayin: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> addAccountApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiUrl.addAccount, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during addAccountApi: $e');
      }
      rethrow;
    }
  }

  Future<AccountViewModel> viewAccountApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiUrl.accountView, data);
      return AccountViewModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during viewAccountApi: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> withdrawApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiUrl.withdrawApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during withdrawApi: $e');
      }
      rethrow;
    }
  }
}
