import 'package:flutter/foundation.dart';
import 'package:game_on/model/profile_model.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';

import 'package:game_on/res/api_urls.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ProfileModel> profileApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(ApiUrl.profileUrl + data);
      return ProfileModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during profileApi: $e');
      }
      rethrow;
    }
  }
}
