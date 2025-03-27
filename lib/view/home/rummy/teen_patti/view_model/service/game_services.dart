import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/card_deck_services.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/card_sorting_service.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/card_throw_animaton.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/firebase_services.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/game_timer_service.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/loader_overlay_service.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/sound_controller.dart';
import 'package:provider/provider.dart';
import '../../../../../../material_imports.dart';
import '../../../../../../model/user_model.dart';
import '../../model/card_model.dart';

class TeenPattiGameController extends ChangeNotifier {
  StreamSubscription<DocumentSnapshot>? _subscription;
  final _firebaseCon = FireBaseServices();
  final _cardClassificationCon = CardSortingService();
  final _timerCon = TimerService();
  // final _dbCon = LocalDBService();
  final int _gameType = 1;
  final int _gameId = 1;
  final int _gamePlayerType = 3;
  final int _tableType = 3;
  final int _cardsPerPlayer = 3;
  List<String> gameType = [
    Assets.teenPattiListImgOne,
    Assets.teenPattiListImgTwo,
    Assets.teenPattiListImgThree,
    Assets.teenPattiListImgFour
  ];

  String _roomCode = '';
  double _betPlacedAmount = 1.0;
  Map<String, dynamic>? _gameData;
  dynamic _currentUserData;
  List<Map<String, dynamic>>? _gameHistory;

  double get betPlacedAmount => _betPlacedAmount;
  String get roomCode => _roomCode;
  Map<String, dynamic>? get gameData => _gameData;
  double get walletBalance => 5000;
  UserModel? get currentUserData => _currentUserData;
  List<Map<String, dynamic>>? get gameHistory => _gameHistory;

  void startListeningToGame(BuildContext context, TickerProvider vsync) {
    LoaderOverlay().hide();
    Navigator.pushNamed(context, RoutesName.waitingActivity);
    _subscription = _firebaseCon.listenToFirestore(_roomCode, (data) {
      _gameData = data;
      notifyListeners();
      streamControl(context, vsync);
    });
  }

  void stopListeningToGame() {
    _subscription?.cancel();
    // _dbCon.insertGameHistory(_gameData!);
  }

  streamControl(BuildContext context, TickerProvider vsync) {
    if (_gameData!["game_event"]["status"] < 5) return;
    gameTimeControl();
    if (_gameData!['game_timer']['timeLeft'] == 60) {
      updateBetAmount('');
    }
    if(_gameData!['game_event']['status']==3){
      SoundController().playTossSound();
    }
  }

  gameTimeControl() {
    if (_gameData!['current_turn'] == _currentUserData!.id &&
        _gameData!['game_timer']['isActive'] == false) {
      if (_gameData!["game_event"]["status"] == 5) {
        _timerCon.startTimer(_roomCode, () {
          debugPrint("it is in the callback function");
          if (_gameData!['game_timer']['timeLeft'] == 0 &&
              _gameData!['game_timer']['isActive'] == true) {
            debugPrint("update player pack satisfied");
            playerPacked(_gameData!['current_turn']);
          }
        });
      }
    }
  }

  void updateBetAmount(String operation, {double value = 0.0}) {
    final isBlind = _gameData!['players']
        .firstWhere((e) => e['id'] == _currentUserData!.id)['isBlind'];
    double minBet = isBlind
        ? _gameData!['betting']['blindVal']
        : (_gameData!['betting']['blindVal'] * 2);
    if (operation == '-' && _betPlacedAmount > minBet) {
      _betPlacedAmount /= 2;
    } else if (operation == '+' && _betPlacedAmount < minBet * 4) {
      if (isBlind) {
        _betPlacedAmount *= 2;
      } else {
        _betPlacedAmount *= 2;
      }
    } else if (operation == '') {
      _betPlacedAmount = minBet;
    }
    notifyListeners();
  }

  Future<bool> joinGame(BuildContext context) async {
    gameReset();
    Provider.of<CardThrowAnimation>(context, listen: false).resetAnimation();
    final profileData =
        Provider.of<ProfileViewModel>(context, listen: false);
    _currentUserData= {"name":profileData.userName, "id":profileData.userId};
    QuerySnapshot roomSnapshot = await _firebaseCon.getDesiredRoomData(
        _gamePlayerType, _gameType, _gameId, _tableType);
    if (roomSnapshot.docs.isEmpty) {
      _roomCode = await _firebaseCon.createNewRoom(
          playerData: [_currentUserData],
          gamePlayerType: _gamePlayerType,
          gameType: _gameType,
          gameId: _gameType,
          tableType: _tableType,
          entryFees: 1);
      debugPrint("room code $roomCode");
      notifyListeners();
      return true;
    } else {
      DocumentReference roomRef = roomSnapshot.docs.first.reference;
      _roomCode = roomRef.id;
      Map<String, dynamic> roomData =
          roomSnapshot.docs.first.data() as Map<String, dynamic>;
      List<dynamic> players = roomData['players'];
      if (players.length == _gamePlayerType) {
      } else if (players.length == _gamePlayerType - 1) {
        players.add(_currentUserData);
        gameToss(players, roomRef.id);
        notifyListeners();
        return true;
      } else {
        players.add(_currentUserData);
        await _firebaseCon.joinAvailableRoom(
            roomRef: roomRef, players: players);
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<void> gameToss(List<dynamic> players, String roomId) async {
    DeckModel deck = DeckModel();
    deck.shuffle();

    String winnerId = players.first['id'].toString();
    CardModel highestCard = deck.deal(1).first;

    for (var player in players) {
      String playerId = player['id'].toString();
      CardModel card = deck.deal(1).first;
      player['tossCard'] = card.imageUrl;

      if (card.rank > highestCard.rank) {
        winnerId = playerId;
        highestCard = card;
      }
    }

    debugPrint("Toss winner ID: $winnerId");

    await _firebaseCon.updateTossResultWithPlayer(
        roomCode: roomId, playerData: players, winnerId: winnerId);
    await Future.delayed(Duration(seconds: 5));
    distributeCards(roomId);
    notifyListeners();
  }

  Future<void> distributeCards(String roomId) async {
    if (_gameData!["game_event"]["status"] == 4) {
      debugPrint("Game already started");
      return;
    }
    List<dynamic> players = _gameData!['players'];
    DeckModel deck1 = DeckModel();
    DeckModel deck2 = DeckModel();

    List<CardModel> combinedCards = List.from(deck1.cards)..addAll(deck2.cards);
    combinedCards.shuffle();
    DeckModel combinedDeck = DeckModel()..cards = combinedCards;
    List<dynamic> playersWithUpdatedHand = [];
    for (var player in players) {
      player["hand"] =
          combinedDeck.deal(_cardsPerPlayer).map((e) => e.toMap()).toList();
      player['isBlind'] = true;
      player['playerStatus'] = 1;
      playersWithUpdatedHand.add(player);
    }

    List<CardModel> remainingCards = combinedDeck.cards;
    CardModel jokerCard = remainingCards.removeAt(0);
    CardModel intDiscardedCard = remainingCards.removeAt(0);

    List<Map<String, dynamic>> availableDeck =
        remainingCards.map((card) => card.toMap()).toList();
    await _firebaseCon.updatePlayersCardDistributionData(
        playerHands: playersWithUpdatedHand,
        availableDeck: availableDeck,
        discardedDeck: [intDiscardedCard.toMap()],
        jokerCard: jokerCard,
        roomCode: roomId,
        initBetValue: 1);

    debugPrint('Cards have been distributed and the game has started.');
    // return;
    await Future.delayed(Duration(seconds: 3));
    _firebaseCon.updateGameStatus(roomCode, 4, "Game card distribution");
    await Future.delayed(Duration(seconds: 6));
    _firebaseCon.updateGameStatus(roomCode, 5, "Game started");
    notifyListeners();
  }

  playerSeenCard(String playerId) {
    List<dynamic> playersWithUpdatedValue = [];
    List<dynamic> players = _gameData!['players'];
    for (var player in players) {
      if (playerId == player['id']) {
        player['isBlind'] = false;
      }
      playersWithUpdatedValue.add(player);
    }
    _firebaseCon.updatePlayerData(playersWithUpdatedValue, roomCode);
  }

  playerPacked(String playerId, {bool playerLeaveTable = false}) async {
    debugPrint("inside player pack condition");
    final status = playerLeaveTable ? 0 : _gameData!['slide_show']['status'];
    List<dynamic> playersWithUpdatedValue = [];
    List<dynamic> players = _gameData!['players'];
    final playerStatus = playerLeaveTable
        ? 2
        : status > 0 && status < 5
            ? 4
            : 3;
    for (var player in players) {
      if (playerId == player['id']) {
        player['playerStatus'] = playerStatus;
        if (status > 0) {
          await _firebaseCon.updateSpecificField(
              'slide_show.status', 0, roomCode);
        }
        debugPrint("status updated");
      } else {
        debugPrint("player not allowed");
      }
      playersWithUpdatedValue.add(player);
    }
    await _firebaseCon.updatePlayerData(playersWithUpdatedValue, roomCode);
    hasValidMove();
    notifyListeners();
  }

  hasValidMove() async {
    List<dynamic> players = _gameData!['players'];
    final packedPlayers = players.where((e) => e['playerStatus'] != 1).toList();
    int maxPackedPlayers = _gameData!['game_specification']['table_type'] - 1;
    if (packedPlayers.length == maxPackedPlayers) {
      int winnerIndex = players.indexWhere((e) => e['playerStatus'] == 1);
      if (winnerIndex != -1) {
        players[winnerIndex]['playerStatus'] = 5;
      }
      await _firebaseCon.updateMultipleField(roomCode, {
        "game_event.status": 6,
        "current_turn": "",
        "winnerId": players[winnerIndex]['id'],
        "players": players,
      });
    } else {
      changeTurn();
    }
  }

  placeBet(bool isBlind) async {
    final key = isBlind ? 'betting.blindVal' : 'betting.seenVal';
    await _firebaseCon.updateSpecificField(key, _betPlacedAmount, roomCode);
    changeTurn();
  }

  Future<void> changeTurn() async {
    if (_gameData == null) return;

    debugPrint("Inside update player case");

    List<dynamic> players = List.from(_gameData!['players']);
    int currentPlayerIndex = players
        .indexWhere((player) => player['id'] == _gameData!['current_turn']);

    if (currentPlayerIndex == -1) return;
    String? nextPlayerId;
    for (int i = 1; i < players.length; i++) {
      int nextPlayerIndex = (currentPlayerIndex + i) % players.length;
      if (players[nextPlayerIndex]['playerStatus'] == 1) {
        nextPlayerId = players[nextPlayerIndex]['id'];
        break;
      }
    }
    if (nextPlayerId == null) {
      await _firebaseCon.updateMultipleField(roomCode,
          {"game_event.status": 6, 'current_turn': "", 'players': players});
    } else {
      await _firebaseCon.updateMultipleField(roomCode, {
        "game_timer.isActive": false,
        "game_timer.timeLeft": 60,
        "current_turn": nextPlayerId,
      });
    }
    notifyListeners();
  }

  String getPlayerForSlideShow() {
    List<dynamic> players = List.from(_gameData!['players']);
    int currentPlayerIndex = players
        .indexWhere((player) => player['id'] == _gameData!['current_turn']);
    if (currentPlayerIndex == -1) return '';
    String? prevPlayerId;
    for (int i = 1; i < players.length; i++) {
      int nextPlayerIndex =
          (currentPlayerIndex - i + players.length) % players.length;
      if (players[nextPlayerIndex]['playerStatus'] == 1) {
        prevPlayerId = players[nextPlayerIndex]['id'];
        break;
      }
    }
    return prevPlayerId ?? '';
  }

  getSlideShow() async {
    final recieverId = getPlayerForSlideShow();
    if (recieverId == '') {
      debugPrint("No player found for slide show");
      return;
    }
    await _firebaseCon.updateMultipleField(roomCode, {
      'slide_show': {
        'req_player_id': _currentUserData!.id,
        'receiver_player_id': recieverId,
        'status': 1
      }
    });
  }

  updateSlideShowReq(int status) async {
    await _firebaseCon.updateSpecificField(
        'slide_show.status', status, roomCode);
    if (status == 2) {
      comparingPlayerCard();
    }
  }

  comparingPlayerCard() async {
    final recieverId = _gameData!['slide_show']['receiver_player_id'];
    final requesterId = _gameData!['slide_show']['req_player_id'];
    final otherPlayerId =
        recieverId == _currentUserData!.id ? requesterId : recieverId;
    final mePlayer = _gameData!['players']
        .firstWhere((e) => e['id'] == _currentUserData!.id);
    final otherOne =
        _gameData!['players'].firstWhere((e) => e['id'] == otherPlayerId);
    final List<CardModel> player1Card = (mePlayer['hand'] as List)
        .map((e) => CardModel.fromMap(e as Map<String, dynamic>))
        .toList();

    final List<CardModel> player2Card = (otherOne['hand'] as List)
        .map((e) => CardModel.fromMap(e as Map<String, dynamic>))
        .toList();
    final winnerData = _cardClassificationCon.compareHands(
        player1Card, player2Card, mePlayer['id'], otherOne['id']);
    debugPrint("comparing cards result $winnerData");
    await Future.delayed(Duration(seconds: 2));
    await _firebaseCon.updateMultipleField(
      roomCode,
      {
        'slide_show': {
          'req_player_id': requesterId,
          'receiver_player_id': recieverId,
          'status': 4,
          'winner_data': winnerData
        }
      },
    );
    await Future.delayed(Duration(seconds: 2));
    playerPacked(winnerData['lose_id']);
    await _firebaseCon.updateSpecificField('slide_show.status', 5, roomCode);
  }

  getGameHistory() async {
    // _gameHistory = await _dbCon.getGameHistory();
    notifyListeners();
  }

  leaveTable(context) {
    LoaderOverlay().show(context);
    if (_gameData!['game_event']['status'] < 5) {
      removePlayerFromTable(_currentUserData!.id);
    }
    stopListeningToGame();
    LoaderOverlay().hide();
    return Navigator.of(context).pop(true);
  }

  removePlayerFromTable(String playerId) async {
    List<dynamic> playersWithUpdatedValue = [];
    List<dynamic> players = _gameData!['players'];
    if (_gameData!['game_event']['status'] == 1) {
      for (var player in players) {
        if (playerId == player['id']) {
          debugPrint('player removed');
        } else {
          playersWithUpdatedValue.add(player);
        }
      }
      await _firebaseCon.updatePlayerData(playersWithUpdatedValue, roomCode);
    } else {
      playerPacked(playerId, playerLeaveTable: true);
    }
  }

  gameReset() {
    _gameData = null;
    _betPlacedAmount = 1.0;
    _roomCode = '';
    notifyListeners();
  }
}
