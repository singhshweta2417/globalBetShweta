import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/api_url.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/sound.dart';
import 'package:game_on/view/home/mini/titli_kabootar/view_model/bet_view_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/view_model/result_view_model.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SevenUpController with ChangeNotifier {

  bool _resetOne = false;
  bool get resetOne => _resetOne;
  void setResetOne(bool val) {
    _resetOne = val;
    notifyListeners();
  }

  List<LuckyCoinModel> coinList = [
    LuckyCoinModel(image: Assets.titliChip1, value: 1),
    LuckyCoinModel(image: Assets.titliChip2, value: 2),
    LuckyCoinModel(image: Assets.titliChip3, value: 5),
    LuckyCoinModel(image: Assets.titliChip4, value: 10),
    LuckyCoinModel(image: Assets.titliChip5, value: 20),
    LuckyCoinModel(image: Assets.titliChip6, value: 50),
    LuckyCoinModel(image: Assets.titliChip7, value: 100),
    LuckyCoinModel(image: Assets.titliChip1, value: 500),
  ];

  List<Map<String, int>> addTitliBets = [];

  void titliAddBet(int id, int amount, int index, context) {
    Audio.playSpinMusic(Assets.musicCoinSplash);
    if (kDebugMode) {
      print("print done");
    }
    if (!isPlayAllowed()) {
      return;
    }
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);

    if (resetOne == false) {
      if (kDebugMode) {
        print(profileViewModel.balance);
      }
      if (amount > profileViewModel.balance) {
        Utils.flushBarErrorMessage(
            'INSUFFICIENT BALANCE ! , Add Amount To Play Game ',
            context,
            AppColors.red);
        playTTSMessage("INSUFFICIENT BALANCE");
        return;
      }

      bool betExists = false;
      for (var bet in addTitliBets) {
        if (bet['number'] == id) {
          bet['amount'] = (bet['amount'] ?? 0) + amount;
          betExists = true;
          break;
        }
      }

      if (!betExists) {
        addTitliBets.add({'number': id, 'amount': amount});
      }
      betHistory.add({'index': index, 'number': id, 'amount': amount});
      totalBetAmount += amount;
      profileViewModel.deductBalance(amount);
      notifyListeners();
    } else {
      resetOneByOne(context, index);
    }
  }

  List<Map<String, int>> betHistory = [];
  int totalBetAmount = 0;

  void resetOneByOne(context, int tappedIndex) {
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);

    if (betHistory.isNotEmpty) {
      int betToRemoveIndex = -1;
      for (int i = betHistory.length - 1; i >= 0; i--) {
        if (betHistory[i]['index'] == tappedIndex) {
          betToRemoveIndex = i;
          break;
        }
      }

      if (betToRemoveIndex != -1) {
        var betToRemove = betHistory.removeAt(betToRemoveIndex);
        int gameId = betToRemove['number']!;
        int amount = betToRemove['amount']!;

        var existingBet = addTitliBets.firstWhere(
              (bet) => bet['number'] == gameId,
        );

        if (existingBet['amount']! > amount) {
          existingBet['amount'] = existingBet['amount']! - amount;
        } else {
          addTitliBets.removeWhere((bet) => bet['number'] == gameId);
        }

        totalBetAmount -= amount;
        profileViewModel.addBalance(amount);

        notifyListeners();
      }
    }
  }

  bool isPlayAllowed() {
    if ((timerStatus == 1 && timerBetTime <= 5)) {
      if (kDebugMode) {
        print('NO MORE PLAY');
      }
      setMessage('NO MORE PLAY');
      return false;
    }
    return true;
  }

  String _showMessage = '';
  String get showMessage => _showMessage;

  void setMessage(String value) {
    _showMessage = value;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      _showMessage = '';
      notifyListeners();
    });
  }

  // timer api
  int _timerBetTime = 0;
  int _timerStatus = 0;

  int get timerBetTime => _timerBetTime;
  int get timerStatus => _timerStatus;

  void setData(int betTime, int status) {
    _timerBetTime = betTime;
    _timerStatus = status;
    notifyListeners();
  }

  void clearAllBet(context) {
    if (!isPlayAllowed()) return;
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.addBalance(
        addTitliBets.fold(0, (sum, element) => sum + element["amount"]!));
    addTitliBets.clear();
    totalBetAmount = 0;
    betHistory.clear();
    notifyListeners();
  }

  List<Map<dynamic, int>> reBets = [];

  bool _isBetAccept = false;
  bool get isBetAccept => _isBetAccept;
  void isBetAccepted(bool val) {
    _isBetAccept = val;
    notifyListeners();
  }

  void repeatBet(context) {
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    final betViewModel = Provider.of<BetViewModel>(context, listen: false);

    // Ensure that reBets is populated correctly before repeating
    if (reBets.isEmpty) {
      return;
    }

    final newAmount =
    reBets.fold(0, (sum, element) => sum + element["amount"]!);

    // Check if the user has enough balance
    if (profileViewModel.balance >= newAmount) {
      isBetAccepted(true); // Set the flag to indicate the bet is accepted

      // Add all bets to addTitliBets before calling the API
      addTitliBets.clear(); // Clear previous bets to avoid duplicate bets
      for (var bet in reBets) {
        addTitliBets.add({'number': bet['number']!, 'amount': bet['amount']!});
      }

      // Call the API once after all bets are added
      betViewModel.titliBetApi(addTitliBets, context);

      // Deduct the balance based on the new amount
      profileViewModel.deductBalance(newAmount);//deductBalance
      notifyListeners(); // Notify listeners to update the UI

    } else {
      // Show an error message if the user does not have enough balance
      if (kDebugMode) {
        print("Not enough wallet balance!");
      }
    }
  }

  void placeBet(List<Map<String, int>> bets, context) {
    reBets = bets;

    final betViewModel = Provider.of<BetViewModel>(context, listen: false);
    betViewModel.titliBetApi(bets, context);

  }

  void doubleUpBet(context) {
    if (!isPlayAllowed()) return; // Check if play is allowed

    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);

    // Calculate total required balance to double the current bets
    int totalRequiredBalance = addTitliBets.fold(0, (sum, bet) {
      return sum + (bet['amount']! * 2); // Doubling the current bet amount
    });

    // Check if the user has enough balance to place the doubled bets
    if (totalRequiredBalance > profileViewModel.balance) {
      Utils.flushBarErrorMessage(
          'INSUFFICIENT BALANCE', context, AppColors.red);
      playTTSMessage("INSUFFICIENT BALANCE");
      return;
    }

    // Double the bet amounts in addTitliBets
    for (var bet in addTitliBets) {
      int currentAmount = bet['amount']!;
      int newAmount = currentAmount * 2;
      bet['amount'] =
          newAmount; // Update the bet amount to double the current amount
    }

    // Place the doubled bet by calling the same function that places the bet
    final betViewModel = Provider.of<BetViewModel>(context, listen: false);
    betViewModel.titliBetApi(addTitliBets, context);

    // Deduct the balance for the doubled bets
    profileViewModel.deductBalance(totalRequiredBalance);//deductBalance

    // Update the UI
    notifyListeners();

  }

  bool _resultShowTime = false;
  bool get resultShowTime => _resultShowTime;
  void setResultShowTime(bool val) {
    _resultShowTime = val;
    notifyListeners();
  }

  bool _showBettingTime = false;
  bool get showBettingTime => _showBettingTime;
  void setBettingTime(bool val) {
    _showBettingTime = val;
    notifyListeners();
  }

  bool betBool = false;
  late IO.Socket _socket;
  void connectToServer(context) async {
    Provider.of<BetViewModel>(context, listen: false);

    _socket = IO.io(
      TitliKabootarApiUrl.socketUrl,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    _socket.on('connect', (_) {
      if (kDebugMode) {
        print('Connected');
      }
    });
    _socket.onConnectError((errorData) {
      if (kDebugMode) {
        print('Connection error: $errorData');
      }
    });
    _socket.on(TitliKabootarApiUrl.eventName, (timerData) async {
      final receiveData = jsonDecode(timerData);
      setData(receiveData['timerBetTime'], receiveData['timerStatus']);
      // bet on
      if (receiveData['timerStatus'] == 1 &&
          receiveData['timerBetTime'] == 75) {
        Utils.flushBarSuccessMessage(
            'PLACE YOUR CHIPS', context, AppColors.green);
        // setMessage('PLACE YOUR CHIPS');
        playTTSMessage('PLACE YOUR CHIPS');
        setBettingTime(false);
        final resultProvider =
        Provider.of<ResultViewModel>(context, listen: false);
        resultProvider.resultModel!.data!.first.gamesNo.toString();
      }
      // clear bet
      if (receiveData['timerStatus'] == 2 && receiveData['timerBetTime'] == 5) {
        Utils.flushBarSuccessMessage('No More Play', context, AppColors.green);
        playTTSMessage('NO MORE PLAY');
        totalBetAmount = 0;
        betHistory.clear();
        notifyListeners();
        isBetAccepted(false);
      }
      if (kDebugMode) {
        print("receiveData $receiveData");
      }
      // // result api
      if (receiveData['timerStatus'] == 2 && receiveData['timerBetTime'] == 5) {
        startSparkleAnimation(context);
        Future.delayed(const Duration(seconds: 10), () async {
          final titliResultViewModel =
          Provider.of<ResultViewModel>(context, listen: false);
          await titliResultViewModel.resultApi(context);
        });
      }
    });
    _socket.connect();
  }

  void disConnectToServer(context) async {
    _socket.disconnect();
    _socket.clearListeners();
    _socket.close();
    Audio.audioPlayers.stop();
    if (kDebugMode) {
      print('SOCKET DISCONNECT');
    }
  }

  List<GridAllModel> cardList = [
    GridAllModel(image: Assets.titliUmbrella, id: 1),
    GridAllModel(image: Assets.titliBall, id: 2),
    GridAllModel(image: Assets.titliSun, id: 3),
    GridAllModel(image: Assets.titliLamp, id: 4),
    GridAllModel(image: Assets.titliCow, id: 5),
    GridAllModel(image: Assets.titliWatterDoll, id: 6),
    GridAllModel(image: Assets.titliKite, id: 7),
    GridAllModel(image: Assets.titliSpinningTop, id: 8),
    GridAllModel(image: Assets.titliRose, id: 9),
    GridAllModel(image: Assets.titliButterFly, id: 10),
    GridAllModel(image: Assets.titliEagle, id: 11),
    GridAllModel(image: Assets.titliRabbit, id: 12),
  ];

  bool isSparkling = false;
  Timer? sparkleTimer;
  int? winningItem;

  void startSparkleAnimation(context) async {
    if (kDebugMode) {
      print("startSparkleAnimation");
    }

    final titliResultViewModel =
    Provider.of<ResultViewModel>(context, listen: false);

    await titliResultViewModel.resultApi(context);

    final id = titliResultViewModel.resultModel?.data?.first.cardId;

    if (id == null) {
      if (kDebugMode) print("Error: No result data available.");
      return;
    }

    if (isSparkling) return;

    notifyListeners();
    isSparkling = true;
    Audio.playSpinMusic(Assets.musicWinnerclap);
    notifyListeners();

    int index = 0;
    sparkleTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (index >= cardList.length) {
        index = 0;
      }

      winningItem = cardList[index].id; // Assign ID from the list

      if (kDebugMode) {
        print("Current ID: ${cardList[index].id}");
      }

      notifyListeners();
      if (winningItem == id) {
        if (kDebugMode) {
          print("Got ID = $id");
          print("Match Found: $winningItem");
          print("Winner Announced: $winningItem");
        }

        timer.cancel();
        isSparkling = false;
        notifyListeners();
      }

      index++; // Move to the next ID in the list
    });
    Future.delayed(const Duration(seconds: 2), () {
      sparkleTimer?.cancel();

      // Stop sparkling animation
      selectWinningItem(id); // Announce the winner
      addTitliBets.clear();

    });
  }

  void selectWinningItem(int winnerId) {
    winningItem = winnerId;
    isSparkling = false;
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      resetGame();
    });
  }

  void resetGame() {
    winningItem = null;
    notifyListeners();
  }
}

class LuckyCoinModel {
  final String image;
  final int value;

  LuckyCoinModel({
    required this.image,
    required this.value,
  });
}

class GridAllModel {
  final String image;
  final int id;

  GridAllModel({
    required this.image,
    required this.id,
  });
}
