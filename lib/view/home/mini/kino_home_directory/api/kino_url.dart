import 'package:globalbet/res/api_urls.dart';
class KinoUrl{

  static const String  baseUrl= ApiUrl.configModel;
  static const String  kinoBetPlaced = '${baseUrl}keno-bet';
  static const String  kinoBetHistory = '${baseUrl}keno-bet-history';
  static const String  kinoResult = '${baseUrl}keno_result';
  static const String  kinoWinResult = '${baseUrl}keno-win-amount';

  static const String  kinoSocket = 'https://aviatorudaan.com/';
  static const String  kinoSocketEvent = 'gameonkino';


}