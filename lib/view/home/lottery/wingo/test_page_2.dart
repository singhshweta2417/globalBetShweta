// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:game_on/view/home/lottery/wingo/res/win_go_api_url.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class SocketApply with ChangeNotifier {
//
//   int _gameIndex = 0;
//   int get gameIndex => _gameIndex;
//
//   void setGameTimer(int index) {
//     _gameIndex = index;
//     notifyListeners();
//   }
//
//   int _oneMinuteTime = 0;
//   int _threeMinuteTime = 0;
//   int _fiveMinuteTime = 0;
//   int _tenMinuteTime = 0;
//
//   // Getters for time values
//   int get oneMinuteTime => _oneMinuteTime;
//   int get threeMinuteTime => _threeMinuteTime;
//   int get fiveMinuteTime => _fiveMinuteTime;
//   int get tenMinuteTime => _tenMinuteTime;
//
//   // Setters to update values & notify UI
//   set oneMinuteTime(int value) {
//     _oneMinuteTime = value;
//     notifyListeners();
//   }
//
//   set threeMinuteTime(int value) {
//     _threeMinuteTime = value;
//     notifyListeners();
//   }
//
//   set fiveMinuteTime(int value) {
//     _fiveMinuteTime = value;
//     notifyListeners();
//   }
//
//   set tenMinuteTime(int value) {
//     _tenMinuteTime = value;
//     notifyListeners();
//   }
//
//   // Function to format seconds into MM:SS
//   String formatTime(int totalSeconds) {
//     int minutes = totalSeconds ~/ 60;
//     int seconds = totalSeconds % 60;
//     return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
//   }
//
//   // Socket connection
//   late IO.Socket _socket;
//
//   void connectToServer() {
//     _socket = IO.io(
//       WinGoApiUrl.wingoSocketUrl,
//       IO.OptionBuilder().setTransports(['websocket']).build(),
//     );
//
//     _socket.on('connect', (_) {
//       if (kDebugMode) {
//         print("Connected to socket server");
//       }
//     });
//
//     _socket.onConnectError((data) {
//       if (kDebugMode) {
//         print("Connection error: $data");
//       }
//     });
//
//     _socket.onDisconnect((_) {
//       if (kDebugMode) {
//         print("Disconnected from socket server");
//       }
//     });
//
//     _socket.on(WinGoApiUrl.wingoEvent, (response) {
//       try {
//         if (kDebugMode) {
//           print("Raw Socket Data: $response");
//         }
//
//         Map<String, dynamic> res;
//
//         if (response is String) {
//           res = jsonDecode(response);
//         } else if (response is Map<String, dynamic>) {
//           res = response;
//         } else {
//           if (kDebugMode) {
//             print("Unexpected data type from socket: ${response.runtimeType}");
//           }
//           return;
//         }
//
//         // Setting time values from API response
//         oneMinuteTime = res['oneMinTimer'];
//         threeMinuteTime = res['threeMinTimer'];
//         fiveMinuteTime = res['fiveMinTimer'];
//         tenMinuteTime = res['tenMinTimer'];
//
//       } catch (e) {
//         if (kDebugMode) {
//           print("Error parsing socket response: $e");
//         }
//       }
//     });
//   }
// }
