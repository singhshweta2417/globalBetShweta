import 'package:globalbet/res/api_urls.dart';

class AppUrls {
  static const baseUrl = ApiUrl.configModel;

  static const loginApiUrl = "${baseUrl}user_login";
  static const insertBetApiUrl = "${baseUrl}bets";
  static const resultHistoryApiUrl = "${baseUrl}result_history";
  static const resultApiUrl = "${baseUrl}result";
  static const profileViewApiUrl = "${baseUrl}profile?userid=";
  static const insertWinningAmount = "${baseUrl}winging_amount";
}
