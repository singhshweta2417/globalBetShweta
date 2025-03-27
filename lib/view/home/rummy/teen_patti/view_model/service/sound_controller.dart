import 'package:audioplayers/audioplayers.dart';
//
class SoundController {
  static final SoundController _instance = SoundController._internal();
  factory SoundController() => _instance;
  SoundController._internal();

  final AudioPlayer _sfxPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  /// ✅ Play Sound Effect (Optimized for Quick Playback)
  Future<void> playCardThrowSound() async {
    await _sfxPlayer.play(AssetSource('sound_effects/card_throw.mp3'));
  }

  Future<void> playTossSound() async {
    await _sfxPlayer.play(AssetSource('sound_effects/toss.mp3'));
  }
}