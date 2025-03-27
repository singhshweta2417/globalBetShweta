// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/utils/utils.dart';

class UserAuthProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserModel? _loginResponse;

  UserModel? get loginResponse => _loginResponse;
  userLogin(context, String phoneNumber, String password) async {
    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "identity": phoneNumber,
        "password": password,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == '200') {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
      setRegLoading(false);
      final userPref = Provider.of<UserViewModel>(context, listen: false);
      userPref.saveUser(UserModel(id: data['id'].toString()));
      Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
      return Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else if (data["status"] == "401") {
      setRegLoading(false);
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      setRegLoading(false);
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }

  bool _regLoading = false;
  bool get regLoading => _regLoading;
  setRegLoading(bool value) {
    _regLoading = value;
    notifyListeners();
  }

  userRegister(context, String identity, String password,
      String referralCode, String email, String countryCode) async {
    final response = await http.post(
      // Uri.parse("https://root.globalbet.com/api/register"),
      Uri.parse(ApiUrl.register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "mobile": identity,
        "password": password,
        "email": email,
        "referral_code": referralCode,
        "country_code": countryCode
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      setRegLoading(false);
      final userPref = Provider.of<UserViewModel>(context, listen: false);
      userPref.saveUser(UserModel(id: data['id'].toString()));
      Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
      Utils.flushBarSuccessMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }
}
