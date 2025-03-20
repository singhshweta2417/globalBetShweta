class WinGoApiUrl{
  // base url
  static const String baseUrl = 'https://root.globalbet24.live/api/';
  //wingo api url
  static const String wingoBet = "${baseUrl}bets_new";
  static const String winGoMyBetHis = "${baseUrl}bet_history";
  static const String wingoWinAmount = "${baseUrl}win-amount?userid=";
  static const String winGoGameHis = "${baseUrl}results?limit=10&game_id=";
  static const String winGoLastResult = "${baseUrl}last_five_result?limit=5&game_id=";
  //wingo socket url
  static const String wingoSocketUrl = "https://aviatorudaan.com/";
  static const String wingoEventOne = "globalbet1";
  static const String wingoEventThree = "globalbet3";
  static const String wingoEventFive = "globalbet5";
  static const String wingoEventTen = "globalbet10";
}