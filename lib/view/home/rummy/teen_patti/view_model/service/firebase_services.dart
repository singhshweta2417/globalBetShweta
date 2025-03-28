import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../material_imports.dart';
import '../../model/card_model.dart';

class FireBaseServices {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final _roomCollection = FirebaseFirestore.instance.collection('rooms');

  // Get user by name
  // Future<UserModel?> getUserByName(String name) async {
  //   var querySnapshot =
  //       await _usersCollection.where('name', isEqualTo: name).get();
  //
  //   if (querySnapshot.docs.isNotEmpty) {
  //     var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
  //     return UserModel.fromMap(userData);
  //   }
  //   return null;
  // }

  Future<QuerySnapshot> getDesiredRoomData(dynamic gamePlayerType,
      dynamic gameType, dynamic gameId, dynamic tableType) async {
    try {
      final roomSnapshot = await _roomCollection
          .where('game_event.status', isEqualTo: 1)
          .where('game_specification.game_player_type',
              isEqualTo: gamePlayerType)
          .where('game_specification.game_type', isEqualTo: gameType)
          .where('game_specification.game_id', isEqualTo: gameId)
          .where('game_specification.table_type', isEqualTo: tableType)
          .limit(1)
          .get();
      return roomSnapshot;
    } catch (e) {
      debugPrint('Error fetching desired room data: $e');
      rethrow;
    }
  }

  Future<String> createNewRoom({
    required dynamic playerData,
    required dynamic gamePlayerType,
    required dynamic gameType,
    required dynamic gameId,
    required dynamic tableType,
    required double entryFees,
  }) async {
    try {
      final roomCode = DateTime.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance.collection('rooms').doc(roomCode).set({
        'game_specification': {
          'game_player_type': gamePlayerType,
          'game_type': gameType,
          'game_id': gameId,
          'table_type': tableType,
          'entry_fees': entryFees,
        },
        'game_event': {
          'status': 1,
          'msg': 'Room created and waiting for players.'
        },
        'players': playerData,
        'game_player_type': gamePlayerType,
        'winnerId': ""
      });
      return roomCode;
    } catch (e) {
      debugPrint('Error creating new room: $e');
      rethrow;
    }
  }

  Future<void> joinAvailableRoom({
    required DocumentReference roomRef,
    required List<dynamic> players,
  }) async {
    try {
      await roomRef.update({'players': players});
    } catch (e) {
      debugPrint('Error joining available room: $e');
      rethrow;
    }
  }

  Future<void> updateTossResultWithPlayer({
    required String roomCode,
    required dynamic playerData,
    required String winnerId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomCode)
          .update({
        'game_event': {'status': 2, 'msg': 'Toss done and toss data updated'},
        'players': playerData,
        'current_turn': winnerId,
        "game_timer": {
          "timeLeft": 60,
          "isActive": false,
        },
        'toss_winner_id': winnerId
      });
    } catch (e) {
      debugPrint('Error updating toss result: $e');
      rethrow;
    }
  }

  Future<void> updatePlayersCardDistributionData(
      {required List<dynamic> playerHands,
      required List<Map<String, dynamic>> availableDeck,
      required List<Map<String, dynamic>> discardedDeck,
      required CardModel jokerCard,
      required String roomCode,
      required double initBetValue}) async {
    try {
      await _roomCollection.doc(roomCode).update({
        'game_event': {
          'status': 3,
          'msg': 'Toss result show and card distribution data updated'
        },
        'players': playerHands,
        'betting': {'blindVal': initBetValue, 'seenVal': initBetValue},
        'slide_show': {
          'req_player_id': '',
          'receiver_player_id': "",
          'status': 0,
          'winner_data': null
        }
        // 'availableDeck': availableDeck,
        // 'discardedCards': discardedDeck,
        // 'jokerCard': jokerCard.toMap(),
      });
    } catch (e) {
      debugPrint('Error updating players card distribution data: $e');
      rethrow;
    }
  }

  StreamSubscription<DocumentSnapshot>? listenToFirestore(
      String roomId, Function(Map<String, dynamic>?) onDataChanged) {
    return _roomCollection.doc(roomId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        onDataChanged(snapshot.data());
      } else {
        debugPrint("The entered room code was not found.");
        onDataChanged(null);
      }
    }, onError: (error) {
      debugPrint('Error: $error');
    });
  }

  Future<void> updateGameStatus(String roomCode, int status, String msg) async {
    await _roomCollection.doc(roomCode).update({
      'game_event': {'status': status, 'msg': msg},
    });
  }

  Future<void> updatePlayerData(
      List<dynamic> playerData, String roomCode) async {
    await _roomCollection.doc(roomCode).update({'players': playerData});
  }

  Future<void> updateSpecificField(
      String key, dynamic value, String roomCode) async {
    await _roomCollection.doc(roomCode).update({key: value});
  }

  Future<void> updateMultipleField(String roomCode, dynamic data) async {
    await _roomCollection.doc(roomCode).update(data);
  }
}
