import 'package:just_audio/just_audio.dart';

class Audio {
  static AudioPlayer audioPlayers = AudioPlayer();

  static Future<void> depositmusic() async {
    var duration = await audioPlayers.setAsset('assets/music/mp3.mp3');
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }
  static Future<void> aviatorplanmusic() async {
    var duration = await audioPlayers.setAsset('assets/music/aviatorplan.mp3');
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }
  static Future<void> wingoTimerOne() async {
    var duration = await audioPlayers.setAsset('assets/music/countdownone.mp3');
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }
  static Future<void> wingoTimerTwo() async {
    var duration = await audioPlayers.setAsset('assets/music/countdowntwo.mp3');
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }
  static Future<void> dragonBgSound() async {
    var duration = await audioPlayers.setAsset('assets/music/dragontiger.mp3');
    audioPlayers.play();
    audioPlayers.setLoopMode(LoopMode.off);
    return Future.delayed(duration ?? Duration.zero);
  }

}
