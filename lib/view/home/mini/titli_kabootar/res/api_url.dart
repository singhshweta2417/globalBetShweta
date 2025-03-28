import 'package:game_on/res/api_urls.dart';

class TitliKabootarApiUrl {
  static const baseUrl = ApiUrl.configModel;
  static const loginUrl = "${baseUrl}register";
  static const String sendOtp = 'https://otp.fctechteam.org/send_otp.php?';
  static const String verifyOtp =
      'https://otp.fctechteam.org/verifyotp.php?mobile=';
  static const String profile = '${baseUrl}get_profile/';

  //titli kabootar
  static const String betApi = '${baseUrl}titli-bet';
  static const String resultApi = '${baseUrl}titli_result';
  static const String betHistoryApi = '${baseUrl}titli-bet-history';
  static const String getAmountApi = '${baseUrl}getamount';

  //socket api 60s timer
  static const String socketUrl = "https://aviatorudaan.com/";
  static const String eventName = 'titlikabootar';
}
