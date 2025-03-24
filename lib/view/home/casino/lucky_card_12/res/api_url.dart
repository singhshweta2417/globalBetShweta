import 'package:globalbet/res/api_urls.dart';

class Lucky12ApiUrl {
  static const baseUrl = '${ApiUrl.configModel}lucky12/';
  static const lucky12Bet = "${baseUrl}bet";
  static const lucky12Result = "${baseUrl}result?user_id=";
  static const lucky12history = "${baseUrl}bet_history?limit=5&user_id=";
  // socket name
  static const timerLucky12Url = "https://aviatorudaan.com/";
  static const timerEvent = "gameon12card";
}
