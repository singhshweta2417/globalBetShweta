import 'package:game_on/res/api_urls.dart';

class ApiUrl7Up {
  static const String baseUrl = ApiUrl.configModel;

  ///7up api
  static const String betPlacedJackpot = '${baseUrl}bets';
  static const String lastResultJackpot = '${baseUrl}last_five_result?game_id=';
  static const String gameHistoryJackpot = '${baseUrl}bet_history';
  static const String winPopupJackpot = '${baseUrl}win-amount';

  static const String jackpotSocketUrl = 'https://aviatorudaan.com/';
  static const String jackpotSocketEventName = 'gameon7up';
  // static const String jackpotSocketEventName = 'gameon7up';
}
