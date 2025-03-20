import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_url.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/model/kino_bet_history_model.dart';
import 'package:http/http.dart' as http;


class KinoGameHistoryApi  with ChangeNotifier {
  List<KinoBetHistoryModel> _response = [];

  List<KinoBetHistoryModel> get response => _response;

  Future<void> resultFetchGames() async {

    try {
      UserViewProvider userProvider = UserViewProvider();
      UserModel user = await userProvider.getUser();
      String userId = user.id.toString();

      const apiUrl = KinoUrl.kinoBetHistory;
      final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "userid" : userId,
          "game_id" : "16"
        }),);


      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        print('API Response: $data');

        _response = data.map((item) => KinoBetHistoryModel .fromJson(item)).toList();
        print('Game history data: $_response');
        notifyListeners();
      } else {
        print('Failed to fetch game history: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching game history: $error');
    }
  }
}
