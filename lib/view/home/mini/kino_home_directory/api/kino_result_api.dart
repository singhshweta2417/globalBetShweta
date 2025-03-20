import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_url.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/model/kino_result_model.dart';
import 'package:http/http.dart' as http;


class KinoResultApi  with ChangeNotifier {
  List<KinoResultModel > _response = [];

  List<KinoResultModel > get response => _response;

  Future<void> resultFetch() async {
    try {
      const apiUrl = KinoUrl.kinoResult;
      final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "game_id" : "16",
          "limit" : "10"
        }),);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        print('API Response: $data');

        _response = data.map((item) => KinoResultModel .fromJson(item)).toList();
        print('Game result data: $_response');
        notifyListeners();
      } else {
        print('Failed to fetch game result: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching game result: $error');
    }
  }
}
