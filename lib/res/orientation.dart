
import 'package:flutter/services.dart';

class OrientationPortraitUtil {
  static Future<bool?> setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return true;
  }
}

class OrientationLandscapeUtil {
  static Future<bool?> setLandscapeOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return true;
  }
}
