// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:http/http.dart' as http;


class AddacountProvider with ChangeNotifier {

  UserViewModel userProvider = UserViewModel();

  bool _regLoading = false;
  bool get regLoading =>_regLoading;
  setRegLoading(bool value){
    _regLoading=value;
    notifyListeners();
  }
  Future Addacount(context, String name, String bankname,String accountno,String branch, String ifsc, String upiId) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    setRegLoading(true);
    final response = await http.post(
      Uri.parse(ApiUrl.addacount),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {
        "user_id": token,
        "name":name,
        "account_number":accountno,
        "ifsc_code": ifsc,
        "bank_name": bankname,
        "branch":branch,
            "upi_id": upiId
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      setRegLoading(false);

      Navigator.pushReplacementNamed(context,  RoutesName.withdrawScreen);
      Utils.flushBarSuccessMessage(
          responseData['message'], context, Colors.black);

    } else {
      setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      Utils.flushBarErrorMessage(
          responseData['message'], context, Colors.black);
    }
  }
}