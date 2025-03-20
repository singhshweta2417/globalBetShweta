import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/deposit_history_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/history_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/withdraw_history_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/api_url.dart';

class HistoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<HistoryModel> historyApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.betHistoryApi,data);
      return HistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during historyApi: $e');
      }
      rethrow;
    }
  }

  Future<DepositHistoryModel> depositHistoryApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.depositHistoryApi,data);
      return DepositHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during depositHistoryApi: $e');
      }
      rethrow;
    }
  }

  Future<WithdrawHistoryModel> withdrawHistoryApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl.withdrawHistoryApi,data);
      return WithdrawHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during withdrawHistoryApi: $e');
      }
      rethrow;
    }
  }



}