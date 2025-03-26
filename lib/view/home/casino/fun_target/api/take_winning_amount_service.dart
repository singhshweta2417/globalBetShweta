import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/url.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/utils.dart';

class WinningAmountService with ChangeNotifier {
  WinningAmountService();

  Future<void> insertWinningAmount(context, winningAmount) async {
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();

    final response = await http.post(
      Uri.parse(AppUrls.insertWinningAmount),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userid': userId, 'amount': winningAmount}),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 200) {
        return Utils.flushBarSuccessMessage(
            responseData['message'], context, Colors.green);
      } else {
        return Utils.flushBarErrorMessage(
            responseData['message'], context, Colors.red);
      }
    } else {
      if (kDebugMode) {
        print('Something went wrong: ${response.statusCode}');
      }
      return;
    }
  }
}
