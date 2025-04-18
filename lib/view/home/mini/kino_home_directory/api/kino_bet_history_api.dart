import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_url.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/model/kino_bet_history_model.dart';
import 'package:http/http.dart' as http;

class KinoGameHistoryApi with ChangeNotifier {
  List<KinoBetHistoryModel> _response = [];

  List<KinoBetHistoryModel> get response => _response;

  Future<void> resultFetchGames() async {
    try {
      UserViewModel userProvider = UserViewModel();
      UserModel user = await userProvider.getUser();
      String userId = user.id.toString();

      const apiUrl = KinoUrl.kinoBetHistory;
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"userid": userId, "game_id": "16"}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        _response =
            data.map((item) => KinoBetHistoryModel.fromJson(item)).toList();
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('Failed to fetch game history: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching game history: $error');
      }
    }
  }
}
