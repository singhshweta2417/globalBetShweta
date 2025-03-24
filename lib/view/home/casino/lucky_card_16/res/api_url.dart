import 'package:globalbet/res/api_urls.dart';

class Lucky16ApiUrl {
  static const baseUrl = '${ApiUrl.configModel}lucky16/';
  static const lucky16Bet = "${baseUrl}bet";
  static const lucky16Result = "${baseUrl}result?user_id=";
  static const lucky16history = "${baseUrl}bet_history?limit=5&user_id=";
  // socket api
  static const timerLucky16Url = "https://aviatorudaan.com/";
  static const timerEvent = "gameon16card";
}
