class ApiUrl7Up {

  // static const String baseUrl = 'https://root.jupitergames.app/api/';
  static const String baseUrl = 'https://magicwinner.motug.com/api/';
  static const String register = '${baseUrl}register';
  static const String sendOtp =  'https://otp.fctechteam.org/send_otp.php?';
  static const String verifyOtp = 'https://otp.fctechteam.org/verifyotp.php?mobile=';
  static const String checkExistNumber = '${baseUrl}check_number';
  static const String login = '${baseUrl}login';
  static const String profile = '${baseUrl}profile/';


  ///dragon
  static const String dragonBet = "${baseUrl}dragon_bet";
  static const String gameHistory = '${baseUrl}bet_history';
  static const String resultList = "${baseUrl}results?game_id=";
  static const String game_win = "${baseUrl}win_amount?userid=";

  ///plinko
  static const String plinkoBet = "${baseUrl}plinko_bet";
  static const String plinkoList = "${baseUrl}plinko_index_list?type=";
  static const String plinkoMultiplier = "${baseUrl}plinko_multiplier";
  static const String plinkoBetHistory = "${baseUrl}plinko_result?userid=";


  ///red black
  static const String gameRules = '${baseUrl}rules?game_id=';
  static const String result = '${baseUrl}results?game_id=';
  static const String winAmount = '${baseUrl}win_amount?userid=';
  static const String betPlaced = '${baseUrl}bet';


  ///jackpot api
  static const String betPlacedJackpot = '${baseUrl}jackpot-bet';
  static const String lastResultJackpot = '${baseUrl}jack_five_result';
  static const String gameHistoryJackpot = '${baseUrl}jackpot_history';
  static const String winPopupJackpot = '${baseUrl}win_amount';

  static const String jackpotSocketUrl = 'https://aviatorudaan.com/';
  static const String jackpotSocketEventName = 'magicJackpot';

  // ///head n tail
  static const String betPlacedHeadTail = '${baseUrl}headtail-bet';
  static const String resultHeadTail = '${baseUrl}headtail_results';
  static const String lastResultHeadTail = '${baseUrl}headtail_five_result';
  static const String winPopupHeadTail = '${baseUrl}headtail_win_amount';
  static const String gameHistoryHeadTail = '${baseUrl}headtail_history';

}
