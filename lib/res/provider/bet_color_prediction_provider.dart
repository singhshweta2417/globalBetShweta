// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/api_urls.dart';

class BetColorResultProvider with ChangeNotifier {
  ProfileViewModel profile = ProfileViewModel();
  UserViewModel userProvider = UserViewModel();
  bool _regLoading = false;
  bool get regLoading => _regLoading;
  setRegLoading(bool value) {
    _regLoading = value;
    notifyListeners();
  }

  Future colorBet(context, String amount, String number, String gameid) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.bettingApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
        "game_id": gameid,
        "number": number,
        "amount": amount
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      setRegLoading(false);
      context.read<ProfileViewModel>().fetchProfileData();
      Navigator.pop(context);

      notifyListeners();
      return Fluttertoast.showToast(msg: responseData['message']);
      //ImageToast.show(imagePath: Assets.imagesBetSucessfull, context: context,heights: 200,widths: 200);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }
}
