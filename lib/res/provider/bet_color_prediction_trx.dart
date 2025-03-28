// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/view/home/mini/Aviator/widget/image_toast.dart';


class BetColorResultProviderTRX with ChangeNotifier {

  UserViewModel userProvider = UserViewModel();

  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future colorBetTrx(context, String amount, String number,int gameid) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    setRegLoading(true);
    final response = await http.post(Uri.parse(ApiUrl.profileUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userid":token,
        "amount":amount,
        "gameid":gameid.toString(),
        "number": number

      }),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      setRegLoading(false);
      Navigator.pop(context);
      return  ImageToast.show(imagePath: Assets.imagesBetSucessfull, context: context,heights: 200,widths: 200);
    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }
}