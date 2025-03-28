import 'dart:async';
import 'package:flutter/material.dart';

class RoomTimerProvider extends ChangeNotifier {
  int _timeLeft = 60;
  double _progress = 1.0;
  Timer? _timer;

  int get timeLeft => _timeLeft;
  double get progress => _progress;

  void startTimer(VoidCallback onTimeout) {
    _timer?.cancel();
    _timeLeft = 60;
    _progress = 1.0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        _progress = _timeLeft / 60;
        notifyListeners();
      } else {
        timer.cancel();
        onTimeout();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
