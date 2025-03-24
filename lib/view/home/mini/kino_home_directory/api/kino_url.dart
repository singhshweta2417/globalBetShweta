import 'package:globalbet/res/api_urls.dart';
class KinoUrl{

  static const String  baseUrl= ApiUrl.configModel;
  static const String  config= '$baseUrl/api/';

  static const String  kinoBetPlaced = '${config}keno-bet';
  static const String  kinoBetHistory = '${config}keno-bet-history';
  static const String  kinoResult = '${config}keno_result';
  static const String  kinoWinResult = '${config}keno-win-amount';

  static const String  kinoSocket = 'https://aviatorudaan.com/';
  static const String  kinoSocketEvent = 'root';


}