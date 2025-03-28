import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/fun_target/Constant/url.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/utils.dart';

class BetService with ChangeNotifier {
  BetService();

  Future<void> insertBetApi(context, betJsonData) async {
    UserViewModel userViewModel = UserViewModel();
    UserModel user = await userViewModel.getUser();
    String userId = user.id.toString();
    final response = await http.post(
      Uri.parse(AppUrls.insertBetApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userid': userId, 'bets': betJsonData}),
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
