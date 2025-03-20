class ApiUrl {

  // static const baseUrl = "https://titlikabootar.motug.com/api/";
  static const baseUrl = "https://admin.titlikabootarking.com/api/";
  static const loginUrl = "${baseUrl}register";
  static const String sendOtp =  'https://otp.fctechteam.org/send_otp.php?';
  static const String verifyOtp = 'https://otp.fctechteam.org/verifyotp.php?mobile=';
  static const String profile = '${baseUrl}get_profile/';

  //titli kabootar
  static const String betApi = '${baseUrl}titli-bet';
  static const String resultApi = '${baseUrl}titli_result';
  static const String betHistoryApi = '${baseUrl}titli-bet-history';
  static const String getAmountApi = '${baseUrl}getamount';

  //payment section
  static const String userPayin = '${baseUrl}user_payin';
  static const String addAccount = '${baseUrl}addAccount';
  static const String accountView = '${baseUrl}accountView';
  static const String withdrawApi = '${baseUrl}withdraw';
  static const String depositHistoryApi = '${baseUrl}deposit-history';
  static const String withdrawHistoryApi = '${baseUrl}withdraw_history';

  //socket api 60s timer
  static const String socketUrl="https://aviatorudaan.com/";
  static const String eventName='titlikabootar';
}