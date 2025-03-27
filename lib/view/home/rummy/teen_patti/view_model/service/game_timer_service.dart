import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timer? _timer;

  Future<void> startTimer(String docId, VoidCallback onTimeout) async {
    if (_timer != null && _timer!.isActive) {
      stopTimer(docId);
    }
    await _firestore.collection("rooms").doc(docId).update({
      "game_timer": {"isActive": true, 'timeLeft': 60}
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      DocumentSnapshot snapshot =
          await _firestore.collection("rooms").doc(docId).get();
      if (snapshot.exists && snapshot.data() != null) {
        int currentTimeLeft = snapshot["game_timer"]["timeLeft"];
        if (currentTimeLeft > 0) {
          await _firestore.collection("rooms").doc(docId).update({
            "game_timer.timeLeft": currentTimeLeft - 1,
          });
        } else {
          await _firestore.collection("rooms").doc(docId).update({
            "game_timer.timeLeft": 0,
          });
          onTimeout();
          _timer?.cancel();
        }
      }
    });
  }

  // Stop the timer manually
  Future<void> stopTimer(String docId) async {
    await _firestore.collection("rooms").doc(docId).update({
      "game_timer.isActive": false,
    });
    _timer?.cancel();
  }
}
