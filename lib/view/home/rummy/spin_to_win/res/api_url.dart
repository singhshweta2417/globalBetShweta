import 'package:globalbet/res/api_urls.dart';

class SpinApiUrl {
  static const baseUrl = ApiUrl.configModel;
  static const spinBetUrl = "${baseUrl}spin/bet";
  static const spinResultUrl = "${baseUrl}spin/result?user_id=";
  static const spinHistoryUrl = "${baseUrl}spin/bet_history?limit=5&user_id=";
  // socket api
  static const timerSpinUrl = "https://aviatorudaan.com/";
  static const timerEvent = "gameon_spin";
}