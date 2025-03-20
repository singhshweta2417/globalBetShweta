import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_result_api.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_url.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/kino_winpopup.dart';
import 'package:http/http.dart' as http;

class KiNoBoolProvider with ChangeNotifier {
  bool _betPlaced = false;
  bool _betStop = false;
  int _countdownSeconds = 30;
  int _selectedNumber = 10;

  final List<int> selectedNumbers = [];
  int _selectedValue = 2; // Default risk level
  final List<List<String>> lowList = [
    ['0.5x', '2.38x'], // For 1 selection
    ['0.5x', '1.19x', '0.5x'], // For 2 selections
    ['0.5x', '0.5x', '2.2x', '20x'], // For 3 selections
    ['0.5x', '0.5x', '1.4x', '5x', '40x'], // For 4 selections
    ['0.5x', '0.5x', '1x', '2.4x', '15x', '100x'], // For 5 selections
    ['0.5x', '0.5x', '0.5x', '2.13x', '7x', '50x', '200x'], // For 6 selections
    [
      '0.5x',
      '0.5x',
      '0.5x',
      '2x',
      '3.48x',
      '6x',
      '100x',
      '5000x'
    ], // For 7 selections
    [
      '1x',
      '0.2x',
      '0.2x',
      '1x',
      '5.21x',
      '8x',
      '30x',
      '300x',
      '5000x'
    ], // For 8 selections
    [
      '01x',
      '0.5x',
      '0.5x',
      '0.5x',
      '2x',
      '5.5x',
      '20x',
      '400x',
      '1000x',
      '5000x'
    ], // For 9 selections
    [
      '2x',
      '0.5x',
      '0.5x',
      '0.5x',
      '0.5x',
      '6.37x',
      '15x',
      '100x',
      '500x',
      '2000x',
      '5000x'
    ], // For 10 selections
    // Extend this as needed for more selections
  ];
  final List<List<String>> mediumList = [
    ['0.2x', '3.28x'], // For 1 selection
    ['0.2x', '1.18x', '7x'], // For 2 selections
    ['0.2x', '0.2x', '2.74x', '3.5x'], // For 3 selections
    ['0.2x', '0.2x', '1.5x', '8x', '80x'], // For 4 selections
    ['0.2x', '0.2x', '1x', '3.5x', '20x', '250x'], // For 5 selections
    ['0.2x', '0.2x', '0.2x', '2.56x', '9x', '120x', '450x'], // For 6 selections
    [
      '1x',
      '0.2x',
      '0.2x',
      '2x',
      '5.3x',
      '10x',
      '200x',
      '1000x'
    ], // For 7 selections
    [
      '1x',
      '0.2x',
      '0.2x',
      '1x',
      '5.21x',
      '8x',
      '30x',
      '300x',
      '5000x'
    ], // For 8 selections
    [
      '1.5x',
      '0.2x',
      '0.2x',
      '0.2x',
      '2x',
      '10.07x',
      '30x',
      '800x',
      '2000x',
      '10000x'
    ], // For 9 selections
    [
      '2x',
      '0.3x',
      '0.3x',
      '0.3x',
      '0.3x',
      '6.2x',
      '25x',
      '300x',
      '8000x',
      '90000x',
      '800000x'
    ], // For 10 selections
    // Extend this as needed for more selections
  ];
  final List<List<String>> highRiskList = [
    ['0x', '3.88x'], // For 1 selection
    ['0x', '1.17x', '9x'], // For 2 selections
    ['0x', '0x', '2.65x', '50x'], // For 3 selections
    ['0x', '0x', '1.62x', '10x', '100x'], // For 4 selections
    ['0x', '0x', '1x', '3.78x', '25x', '400x'], // For 5 selections
    ['0x', '0x', '0x', '2.67x', '10x', '180x', '700x'], // For 6 selections
    [
      '1x',
      '0x',
      '0x',
      '2x',
      '5.3x',
      '20x',
      '400x',
      '2000x'
    ], // For 7 selections
    [
      '1',
      '0x',
      '0x',
      '1x',
      '5.38x',
      '11x',
      '50x',
      '5000x',
      '10000x'
    ],
    [
      '2x',
      '0x',
      '0x',
      '0x',
      '2x',
      '10.86x',
      '50x',
      '1000x',
      '5000x',
      '25000x'
    ],
    [
      '2x',
      '0x',
      '0x',
      '0x',
      '1x',
      '5.57x',
      '30x',
      '500x',
      '1000x',
      '5000x',
      '10000x'
    ],
  ];



  // Getters
  bool get kiNoBetPlaced => _betPlaced;
  bool get betStop => _betStop;
  int get countdownSeconds => _countdownSeconds;
  int get selectedNumber => _selectedNumber;
  int get selectedValue => _selectedValue;

  // Setters
  void setBetPlaced(bool value) {
    _betPlaced = value;
    notifyListeners();
  }

  void setBetStop(bool value) {
    _betStop = value;
    notifyListeners();
  }

  void setSelectedNumber(int value) {
    _selectedNumber = value;
    notifyListeners();
  }

  // Increment/Decrement Selected Number
  void increment() {
    if (_selectedNumber < 100000) {
      _selectedNumber += 10;
      notifyListeners();
    }
  }

  void decrement() {
    if (_selectedNumber > 10) {
      _selectedNumber -= 10;
      notifyListeners();
    }
  }

  // Start Countdown
  Future<void> startCountdown(BuildContext context, KinoResultApi resultProvider) async {
    DateTime now = DateTime.now().toUtc();
    int initialSeconds = 30 - now.second;
    _countdownSeconds = initialSeconds;
    notifyListeners();

  }

  void updateUI(BuildContext context, Timer timer, KinoResultApi resultProvider) {
    _countdownSeconds = (_countdownSeconds - 1) % 30;
    notifyListeners();

    if (_countdownSeconds == 29) {
      resultProvider.resultFetch();
      resultProvider.response.first.gamesno;
      // final winLossPopup = Provider.of<KinoWinApi>(context,listen: false);
      // winLossPopup.kinoWinLossApi(context: context, gameNo:  resultProvider.response.first.gamesno.toString());
      kinoWinLossApi(context: context, gameNo: resultProvider.response.first.gamesno.toString());
    } else if (_countdownSeconds < 10 && _countdownSeconds > 1) {
      setBetStop(true);
    }

    if (_countdownSeconds == 5) {

    } else if (_countdownSeconds == 1) {
      setBetStop(false);
      setBetPlaced(false);
      selectedNumbers.clear();

    }
  }

  int _kinoMinuteTime = 0;
  int get kinoMinuteTime => _kinoMinuteTime;
  int _kinoMinuteStatus = 0;
  int get kinoMinuteStatus => _kinoMinuteStatus;
  setKinoMinutesData(int time, int status) {
    _kinoMinuteTime = time;
    _kinoMinuteStatus = status;
    notifyListeners();
  }

  // late IO.Socket _socket;
  //
  // void connectToServer(BuildContext context, KinoResultApi resultProvider) {
  //   _socket = IO.io(
  //     KinoUrl.kinoSocket,
  //     IO.OptionBuilder().setTransports(['websocket']).build(),
  //   );
  //   _socket.on('connect', (_) {
  //     if (kDebugMode) {
  //     }
  //   });
  //   _socket.onConnectError((data) {
  //     if (kDebugMode) {
  //     }
  //   });
  //   _socket.on(KinoUrl.kinoSocketEvent, (response) {
  //     final res = jsonDecode(response);
  //     setKinoMinutesData(res['timerBetTime'], res['timerStatus']);
  //     if(res['timerBetTime']==29 && res['timerStatus']==1){
  //       resultProvider.resultFetch();
  //       resultProvider.response.first.gamesno;
  //       kinoWinLossApi(context: context, gameNo: resultProvider.response.first.gamesno.toString());
  //     } else if(res['timerBetTime']< 10  && res['timerBetTime']> 1 && res['timerStatus']==1){
  //       setBetStop(true);
  //     }
  //       if (res['timerBetTime'] == 1 && res['timerStatus']==1 ) {
  //       setBetStop(false);
  //       setBetPlaced(false);
  //       selectedNumbers.clear();
  //     }
  //   });
  //   _socket.connect();
  // }

  String formatTime(int seconds, int position) {
    final Duration duration = Duration(seconds: seconds);
    final int minutes = duration.inMinutes;
    final int remainingSeconds = duration.inSeconds % 60;

    return position == 0
        ? minutes.toString().padLeft(2, '0')
        : remainingSeconds.toString().padLeft(2, '0');
  }

  // void disConnectToServer(context) async {
  //   _socket.disconnect();
  //   _socket.clearListeners();
  //   _socket.close();
  //   if (kDebugMode) {
  //     print('SOCKET DISCONNECT');
  //   }
  // }

  void toggleBetPlaced() {
    _betPlaced = !_betPlaced;
    notifyListeners();
  }

  // void cancelCountdown() {
  //   _countdownTimer?.cancel();
  //   notifyListeners();
  // }
  //
  // @override
  // void dispose() {
  //   cancelCountdown();
  //   super.dispose();
  // }

  List<String> getDisplayedList() {
    if (selectedNumbers.isEmpty) {
      return [];
    }

    int count = selectedNumbers.length;

    if (count > mediumList.length) {
      return [];
    }
    switch (_selectedValue) {
      case 1:
        return lowList[count - 1];
      case 2:
        return mediumList[count - 1];
      case 3:
        return highRiskList[count - 1];
      default:
        return [];
    }

  }

  void setSelectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }

  dynamic  result;
  dynamic  gamesno;
  dynamic numberList;
  dynamic amount;
  Future<void> kinoWinLossApi({required BuildContext context, required String gameNo}) async {
    try {
      final response = await http.post(
        Uri.parse(KinoUrl.kinoWinResult),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userid" : "3",
          "game_id" : "23",
          "gamesno": gameNo
        }),
      );
      print({
        "userid" : "3",
        "game_id" : "23",
        "gamesno": gameNo
      });
      print("response");
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        result = data['result'];
        gamesno = data['games_no'];
        numberList = (data['number'] as Map<String, dynamic>).values.toList();
        amount = data['amount'];
        Utils.flushBarSuccessMessage(data['message'], context,Colors.green);
        showDialog(context: context, builder: (context)=>WinPopUpPage(
          winNumber: numberList.join(", "),
          gameSrNo: gamesno,
          winAmount: amount,
        ));
        print('api chli');
      }
    } catch (e) {
      rethrow;
    } finally {

    }
  }
}
