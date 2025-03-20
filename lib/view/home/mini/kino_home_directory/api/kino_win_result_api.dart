import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_url.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/kino_winpopup.dart';
import 'package:http/http.dart' as http;

class KinoWinApi with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  dynamic result;
  dynamic gamesno;
  dynamic numberList;
  dynamic amount;
  Future<void> kinoWinLossApi(
      {required BuildContext context, required String gameNo}) async {
    _setLoading(true);
    try {
      UserViewProvider userProvider = UserViewProvider();
      UserModel user = await userProvider.getUser();
      String userId = user.id.toString();

      final response = await http.post(
        Uri.parse(KinoUrl.kinoWinResult),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode({"userid": userId, "game_id": "16", "games_no": gameNo}),
      );
      print({"userid": userId.toString(), "game_id": "16", "games_no": gameNo});
      print("response");
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        result = data['result'];
        gamesno = data['games_no'];
        numberList = (data['number'] as Map<String, dynamic>).values.toList();
        amount = data['amount'];
        Utils.flushBarSuccessMessage(data['message'], context, Colors.green);
        showDialog(
            context: context,
            builder: (context) => WinPopUpPage(
                  winNumber: numberList.join(", "),
                  gameSrNo: gamesno,
                  winAmount: amount,
                ));
        print('api chli');
      } else {
        Utils.flushBarErrorMessage(data['message'], context, Colors.red);
        print("api nhi chli");
      }
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
