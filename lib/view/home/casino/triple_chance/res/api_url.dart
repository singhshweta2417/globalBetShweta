import 'package:game_on/res/api_urls.dart';

class TripleChanceApiUrl {
  static const baseUrl = '${ApiUrl.configModel}triple_chance/';
  static const tripleChanceBet = "${baseUrl}bet";
  static const tripleChanceResult = "${baseUrl}result?user_id=";
  static const tripleChanceHistory = "${baseUrl}bet_history?limit=5&user_id=";
 // socket api
  static const timerTripleChanceUrl = "https://aviatorudaan.com/";
  static const timerEvent = 'gameontriple';

}