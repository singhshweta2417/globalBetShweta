import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/api_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.loginUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during loginApi: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> sendOtp(dynamic phoneNumber) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse("${ApiUrl.sendOtp}mode=live&digit=6&mobile=$phoneNumber");
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during sendOtp: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> verifyOtp(dynamic phone , dynamic myControllers) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse("${ApiUrl.verifyOtp}$phone&otp=$myControllers");
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during verifyOtp: $e');
      }
      rethrow;
    }
  }


}
