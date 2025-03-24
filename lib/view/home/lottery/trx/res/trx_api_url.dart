import 'package:globalbet/res/api_urls.dart';

class TrxApiUrl {
  // base url
  static const String baseUrl = ApiUrl.configModel;
  static const String trxBet = "${baseUrl}bets";
  static const String trxMyBetHis = "${baseUrl}bet_history";
  static const String trxGameHis = "${baseUrl}results?limit=10&game_id=";
  static const String trxResult = "${baseUrl}last_result?game_id=";
  static const String trxWinAmount = "${baseUrl}win-amount?userid=";
  // static const String allRules = "${baseUrl}all_rules?type=";

  //wingo socket url
  static const String trxSocketUrl = "https://aviatorudaan.com";
  static const String trxEvent1 = "gameontrx1";
  static const String trxEvent3 = "gameontrx3";
  static const String trxEvent5 = "gameontrx5";
  static const String trxEvent10 = "gameontrx10";
}
