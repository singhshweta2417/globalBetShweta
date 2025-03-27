
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static String getUserId() {
    return _prefs?.getString('userId') ?? '';
  }
  static void setUserId(String userId) {
    _prefs?.setString('userId', userId);
  }

  static void clearUserId() {
    _prefs?.remove('userId');
  }

  // Chips setting
  static void setChipsValue(int chip) {
    _prefs?.setInt('chipsValue', chip);
  }

  static int getChipsValue(){
    return _prefs?.getInt("chipsValue")??0;
  }

  static void clearChipsValue() {
    _prefs?.remove('chipsValue');
  }

  static void setLastResult(int resultValue) {
    _prefs?.setInt('lastResult', resultValue);
  }

  static int getLastResult(){
    return _prefs?.getInt("lastResult")??0;
  }

  static void clearLastResult() {
    _prefs?.remove('lastResult');
  }



}


