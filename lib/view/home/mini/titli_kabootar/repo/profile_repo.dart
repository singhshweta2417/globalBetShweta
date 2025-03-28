// import 'package:flutter/foundation.dart';
// import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
// import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
// import 'package:game_on/view/home/mini/titli_kabootar/model/profile_model.dart';
// import 'package:game_on/view/home/mini/titli_kabootar/res/api_url.dart';
//
//
// class ProfileRepository {
//   final BaseApiServices _apiServices = NetworkApiServices();
//
//   Future<ProfileModel> userProfileApi(dynamic data) async {
//     try {
//       dynamic response = await _apiServices.getGetApiResponse(ApiUrl.profile + data);
//       return ProfileModel.fromJson(response);
//     } catch (e) {
//       if (kDebugMode){
//         print('Error occurred during userProfileApi: $e');
//       }
//       rethrow;
//     }
//   }
//
// }