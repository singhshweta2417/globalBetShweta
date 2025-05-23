import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_bool_provider.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_result_api.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_url.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class KinoBetApi with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  Future<void> kinoBetPlacedApi({
    required context,
    required String riskLevel,
    required List<int> selectedNumber,
    required String betAmount,
  }) async {
    _setLoading(true);

    try {
      UserViewModel userProvider = UserViewModel();
      UserModel user = await userProvider.getUser();
      String userId = user.id.toString();

      final response = await http.post(
        Uri.parse(KinoUrl.kinoBetPlaced),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userid": userId,
          "game_id": "16",
          "risk_level": riskLevel,
          "selected_numbers": selectedNumber,
          "bet_amount": betAmount
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Utils.flushBarSuccessMessage(data['message'], context, Colors.green);
        Provider.of<KiNoBoolProvider>(context, listen: false)
            .setBetPlaced(false);
        Provider.of<KinoResultApi>(context, listen: false).resultFetch();
      } else {
        Utils.flushBarErrorMessage(data['message'], context, Colors.red);
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
