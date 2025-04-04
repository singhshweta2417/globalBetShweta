import 'package:game_on/res/api_urls.dart';

class MineApiUrl {
  static const String baseUrl = ApiUrl.configModel;
  static const String mineMultiplier = '${baseUrl}mine_multiplier';
  static const String mineBet = '${baseUrl}mine_bet';
  static const String mineCashOut = '${baseUrl}mine_cashout';
  static const String mineBetHistory =
      '${baseUrl}mine_result?limit=10&offset=0&userid=';
}
