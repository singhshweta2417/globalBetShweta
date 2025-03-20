
import 'package:just_audio/just_audio.dart';

class Audio {
  static AudioPlayer audioPlayers = AudioPlayer();

  static Future<void> playSpinMusic(String soundUrl) async {
    var duration = await audioPlayers.setAsset(soundUrl);
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }

}
