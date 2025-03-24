import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

Future<void> playTTSMessage(String message) async {
  FlutterTts flutterTts = FlutterTts();

  await flutterTts.setLanguage("en-US");
  await flutterTts.setSpeechRate(0.5);
  //
  var result = await flutterTts.speak(message);
  //
  if (result == 1) {
    if (kDebugMode) {
      print("TTS playback started.");
    }
  } else {
    if (kDebugMode) {
      print("Error playing TTS.");
    }
  }
}
