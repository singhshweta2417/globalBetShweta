import 'package:game_on/res/api_urls.dart';

class ApiUrl7Up {
  static const String baseUrl = ApiUrl.configModel;

  ///jackpot api
  static const String betPlacedJackpot = '${baseUrl}jackpot-bet';
  static const String lastResultJackpot = '${baseUrl}jack_five_result';
  static const String gameHistoryJackpot = '${baseUrl}jackpot_history';
  static const String winPopupJackpot = '${baseUrl}win_amount';

  static const String jackpotSocketUrl = 'https://aviatorudaan.com/';
  static const String jackpotSocketEventName = 'magicJackpot';
}
