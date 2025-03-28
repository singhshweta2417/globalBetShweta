import 'package:game_on/res/api_urls.dart';

class AppUrls {
  static const baseUrl = ApiUrl.configModel;
  static const insertBetApiUrl = "${baseUrl}bets";
  static const resultHistoryApiUrl = "${baseUrl}result_history";
  static const resultApiUrl = "${baseUrl}result";
  static const insertWinningAmount = "${baseUrl}winging_amount";
}
