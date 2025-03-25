// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:globalbet/model/slider_model.dart';
import 'package:globalbet/model/about_us_model.dart';
import 'package:globalbet/model/beginner_model.dart';
import 'package:globalbet/model/terms_condition_model.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/model/user_profile_model.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;

class BaseApiHelper {
  /// get profile
  UserViewModel userProvider = UserViewModel();

  Future<UserProfile> fetchProfileData() async {
    // Get user ID
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    try {
      final response = await http.get(Uri.parse(ApiUrl.profileUrl + token))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);

        return UserProfile.fromJson(jsonMap);
      }
      // else if (response.statusCode == 401) {
      //  return Navigator.pushNamed(context, RoutesName.loginScreen);
      // }
      else {
        // Other error, throw an exception
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }


  ///slider
  Future<List<SliderModel>> fetchSliderData() async {
    try {
      final response = await http
          .get(Uri.parse(ApiUrl.banner))
          .timeout(const Duration(seconds: 10));

      // final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];

        List<SliderModel> sliderList =
            jsonList.map((jsonMap) => SliderModel.fromJson(jsonMap)).toList();
        return sliderList;
      } else {
        throw Exception('Failed to load slider data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///about us
  Future<AboutusModel?> fetchaboutusData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.aboutus)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'];

        return AboutusModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///termscondition

  Future<TcModel?> fetchdataTC() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.termsCon)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///privacy policy

  Future<TcModel?> fetchdataPP() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.privacyPolicy)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'];

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  ///contact us

  Future<TcModel?> fetchdataCU() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.contact)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];

        return TcModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }


  ///beginnerguide

  Future<BeginnerModel?> fetchBeginnerData() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.beginnerApi)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body)['data'][0];

        return BeginnerModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }







}

