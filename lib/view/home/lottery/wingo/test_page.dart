// // import 'package:flutter/material.dart';
// // import 'package:game_on/view/home/lottery/wingo/controller/win_go_controller.dart';
// // import 'package:game_on/view/home/lottery/wingo/test_page_2.dart';
// // import 'package:provider/provider.dart';
// //
// // class TimerPage extends StatefulWidget {
// //   const TimerPage({super.key});
// //
// //   @override
// //   State<TimerPage> createState() => _TimerPageState();
// // }
// //
// // class _TimerPageState extends State<TimerPage> {
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     // Connect to socket when the screen loads
// //     Future.microtask(() {
// //       Provider.of<SocketApply>(context, listen: false).connectToServer();
// //     });
// //   }
// //
// //   List<GameTimerModel> gameTimerList = [
// //     GameTimerModel(title: "Win Go", subTitle: "1 Min"),
// //     GameTimerModel(title: "Win Go", subTitle: "3 Min"),
// //     GameTimerModel(title: "Win Go", subTitle: "5 Min"),
// //     GameTimerModel(title: "Win Go", subTitle: "10 Min"),
// //   ];
// //
// //    int selectIndex = 0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final socket = Provider.of<SocketApply>(context);
// //
// //     return  Scaffold(
// //       body: Center(
// //         child: Column(
// //           children: [
// //             SizedBox(
// //               height: 50,
// //               child: ListView.builder(
// //                   itemCount: gameTimerList.length,
// //                   shrinkWrap: true,
// //                   scrollDirection: Axis.horizontal,
// //                   physics: const NeverScrollableScrollPhysics(),
// //                   itemBuilder: ( context, int index){
// //
// //                     final data = gameTimerList[index];
// //
// //                 return InkWell(
// //                   onTap: (){
// //                     setState(() {
// //                       selectIndex = index;
// //                     });
// //                   },
// //                   child: Container(
// //                     margin: const EdgeInsets.all(5),
// //                     height: 50,
// //                     width: 70,
// //                     decoration:  BoxDecoration(
// //                       color: selectIndex == index ? Colors.green : Colors.blue
// //                     ),
// //                     child: Text(
// //                       data.subTitle,
// //                       style: TextStyle(
// //                         color: Colors.white
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               }),
// //             ),
// //             Text(
// //               socket.formatTime(
// //                   selectIndex == 0? socket.oneMinuteTime
// //                       : selectIndex == 1 ? socket.threeMinuteTime
// //                       : selectIndex == 2 ? socket.fiveMinuteTime: socket.tenMinuteTime
// //
// //               ),
// //
// //               style: const TextStyle(fontSize: 40),
// //             )
// //
// //           ],
// //         )
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:game_on/res/components/audio.dart';
// import 'package:game_on/view/home/lottery/wingo/res/win_go_api_url.dart';
// import 'package:game_on/view/home/lottery/wingo/view_model/win_go_game_his_view_model.dart';
// import 'package:game_on/view/home/lottery/wingo/view_model/win_go_my_his_view_model.dart';
// import 'package:game_on/view/home/lottery/wingo/view_model/win_go_result_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:game_on/generated/assets.dart';
// import 'package:game_on/utils/utils.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class socketController with ChangeNotifier {
//   final TextEditingController amount = TextEditingController(text: "1");
//
//   // int _gameIndex = 0;
//   // int get gameIndex => _gameIndex;
//   //
//   // void setGameTimer(int index) {
//   //   _gameIndex = index;
//   //   notifyListeners();
//   // }
//
//   int _gameDataTab = 0;
//   int get gameDataTab => _gameDataTab;
//   setGameDataTab(int value) {
//     _gameDataTab = value;
//     notifyListeners();
//   }
//
//   String _gameHistorySelect = "0";
//   String get gameHistorySelect => _gameHistorySelect;
//   setGameHistorySelect(String value) {
//     _gameHistorySelect = value;
//     notifyListeners();
//   }
//
//   bool _isSelected = true;
//
//   bool get isSelected => _isSelected;
//
//   void setIsSelected(bool value) {
//     _isSelected = value;
//     notifyListeners();
//   }
//
//   int _selectedIndexBalance = 0;
//   int get selectedIndexBalance => _selectedIndexBalance;
//   void setSelectedBIndex(int value) {
//     _selectedIndexBalance = value;
//     notifyListeners();
//   }
//
//   int _selectedIndexMultiplier = 0;
//   int get selectedIndexMultiplier => _selectedIndexMultiplier;
//   void setSelectedIndexMultiplier(int value) {
//     _selectedIndexMultiplier = value;
//     getXAmount(multiplierList[value]);
//     notifyListeners();
//   }
//
//   List<GameTimerModel> gameTimerList = [
//     GameTimerModel(title: "Win Go", subTitle: "1 Min"),
//     GameTimerModel(title: "Win Go", subTitle: "3 Min"),
//     GameTimerModel(title: "Win Go", subTitle: "5 Min"),
//     GameTimerModel(title: "Win Go", subTitle: "10 Min"),
//   ];
//
//   List<dynamic> colorBetList = [
//     {"title":"Green","col1":Colors.green,"col2":Colors.green,"game_id":10},
//     {"title":"Violet","col1":Colors.purple,"col2":Colors.purple,"game_id":20},
//     {"title":"Red","col1":Colors.red,"col2":Colors.red,"game_id":30}
//   ];
//
//   List<dynamic> bigSmallList = [
//     {"title":"Big","col1":Colors.orange,"col2":Colors.orange,"game_id":40},
//     {"title":"Small","col1":Colors.blue,"col2":Colors.blue,"game_id":50},
//   ];
//
//   List<dynamic> betNumbers = [
//     {"img":Assets.winGo0, "col1":Colors.red, "col2":Colors.purple, "game_id":0,"title":"0"},
//     {"img":Assets.winGo1, "col1":Colors.green, "col2":Colors.green, "game_id":1,"title":"1"},
//     {"img":Assets.winGo2, "col1":Colors.red, "col2":Colors.red, "game_id":2,"title":"2"},
//     {"img":Assets.winGo3, "col1":Colors.green, "col2":Colors.green, "game_id":3,"title":"3"},
//     {"img":Assets.winGo4, "col1":Colors.red, "col2":Colors.red, "game_id":4,"title":"4"},
//     {"img":Assets.winGo5, "col1":Colors.green, "col2":Colors.purple, "game_id":5,"title":"5"},
//     {"img":Assets.winGo6, "col1":Colors.red, "col2":Colors.red, "game_id":6,"title":"6"},
//     {"img":Assets.winGo7, "col1":Colors.green, "col2":Colors.green, "game_id":7,"title":"7"},
//     {"img":Assets.winGo8, "col1":Colors.red, "col2":Colors.red, "game_id":8,"title":"8"},
//     {"img":Assets.winGo9, "col1":Colors.green, "col2":Colors.green, "game_id":9,"title":"9"},
//   ];
//
//
//   List<String> gameDataTabList = [
//     "Game History",
//     "Chart",
//     "My History",
//   ];
//
//   List<int> balanceList = [
//     1,
//     10,
//     100,
//     1000,
//   ];
//
//   List<int> multiplierList = [
//     1,
//     5,
//     10,
//     20,
//     50,
//     100,
//   ];
//
//   void decrement() {
//     int currentValue = int.tryParse(amount.text) ?? 0;
//     if (currentValue > 0) {
//       currentValue--;
//       amount.text = currentValue.toString();
//     }
//     notifyListeners();
//   }
//
//   void increment() {
//     int currentValue = int.tryParse(amount.text) ?? 0;
//     currentValue++;
//     amount.text = currentValue.toString();
//     notifyListeners();
//   }
//
//   void getXAmount(int x) {
//     amount.text = (int.parse(amount.text) * x).toString();
//     notifyListeners();
//   }
//
//   void clear() {
//     amount.text = '1';
//     _selectedIndexBalance = 0;
//     _selectedIndexMultiplier = 0;
//     notifyListeners();
//   }
//
//
//
//   // int _oneMinuteTime = 0;
//   // int get oneMinuteTime => _oneMinuteTime;
//   // int _oneMinuteStatus = 0;
//   // int get oneMinuteStatus => _oneMinuteStatus;
//   // set1MinutesData(int time, int status) {
//   //   _oneMinuteTime = time;
//   //   _oneMinuteStatus = status;
//   //   notifyListeners();
//   // }
//   //
//   // int _threeMinuteTime = 0;
//   // int get threeMinuteTime => _threeMinuteTime;
//   // int _threeMinuteStatus = 0;
//   // int get threeMinuteStatus => _threeMinuteStatus;
//   // set3MinutesData(int time, int status) {
//   //   _threeMinuteTime = time;
//   //   _threeMinuteStatus = status;
//   //   notifyListeners();
//   // }
//   //
//   // int _fiveMinuteTime = 0;
//   // int get fiveMinuteTime => _fiveMinuteTime;
//   // int _fiveMinuteStatus = 0;
//   // int get fiveMinuteStatus => _fiveMinuteStatus;
//   // set5MinutesData(int time, int status) {
//   //   _fiveMinuteTime = time;
//   //   _fiveMinuteStatus = status;
//   //   notifyListeners();
//   // }
//   //
//   // int _tenMinuteTime = 0;
//   // int get tenMinuteTime => _tenMinuteTime;
//   // int _tenMinuteStatus = 0;
//   // int get tenMinuteStatus => _tenMinuteStatus;
//   // set10MinutesData(int time, int status) {
//   //   _tenMinuteTime = time;
//   //   _tenMinuteStatus = status;
//   //   notifyListeners();
//   // }
//
//   bool resOne=false;
//
//   int _gameIndex = 0;
//   int get gameIndex => _gameIndex;
//
//   void setGameTimer(int index) {
//     _gameIndex = index;
//     notifyListeners();
//   }
//
//
//   int _oneMinuteTime = 0;
//   int get oneMinuteTime => _oneMinuteTime;
//   int _oneMinuteStatus = 0;
//   int get oneMinuteStatus => _oneMinuteStatus;
//
//   int _threeMinuteTime = 0;
//   int get threeMinuteTime => _threeMinuteTime;
//   int _threeMinuteStatus = 0;
//   int get threeMinuteStatus => _threeMinuteStatus;
//
//   int _fiveMinuteTime = 0;
//   int get fiveMinuteTime => _fiveMinuteTime;
//   int _fiveMinuteStatus = 0;
//   int get fiveMinuteStatus => _fiveMinuteStatus;
//
//   int _tenMinuteTime = 0;
//   int get tenMinuteTime => _tenMinuteTime;
//   int _tenMinuteStatus = 0;
//   int get tenMinuteStatus => _tenMinuteStatus;
//
//
//   void setTimerData(int minutes, int time, int status) {
//     switch (minutes) {
//       case 1:
//         _oneMinuteTime = time;
//         _oneMinuteStatus = status;
//         break;
//       case 3:
//         _threeMinuteTime = time;
//         _threeMinuteStatus = status;
//         break;
//       case 5:
//         _fiveMinuteTime = time;
//         _fiveMinuteStatus = status;
//         break;
//       case 10:
//         _tenMinuteTime = time;
//         _tenMinuteStatus = status;
//         break;
//       default:
//         if (kDebugMode) {
//           print("Invalid timer type: $minutes");
//         }
//         return;
//     }
//     notifyListeners();
//   }
//
//
//   late IO.Socket _socket;
//
//   void connectToServer( context) {
//     final wgr = Provider.of<WinGoResultViewModel>(context, listen: false);
//
//     _socket = IO.io(
//       WinGoApiUrl.wingoSocketUrl,
//       IO.OptionBuilder().setTransports(['websocket']).build(),
//     );
//
//     _socket.on('connect', (_) {
//       if (kDebugMode) {
//         print("Connected");
//       }
//     });
//
//     _socket.onConnectError((data) {
//       if (kDebugMode) {
//         print("Connection error: $data");
//       }
//     });
//
//     bool resOne = false;
//
//     _socket.on(WinGoApiUrl.wingoEvent, (response) {
//       final res = jsonDecode(response);
//
//
//       setTimerData(1, res['oneMinTimer'], res['timerStatus']);
//       setTimerData(3, res['threeMinTimer'], res['timerStatus']);
//       setTimerData(5, res['fiveMinTimer'], res['timerStatus']);
//       setTimerData(10, res['tenMinTimer'], res['timerStatus']);
//
//       if (gameIndex == 0) {
//         if (res['oneMinTimer'] == 1 && res['timerStatus'] == 1) {
//           resOne = false;
//         }
//         if (res['oneMinTimer'] == 3 && res['timerStatus'] == 2 && !resOne) {
//           wgr.wingoResultApi(context, 1, gameIndex);
//           Provider.of<WinGoGameHisViewModel>(context, listen: false).gameHisApi(context, 0);
//           Provider.of<WinGoMyHisViewModel>(context, listen: false).myBetHisApi(context, 0);
//
//           resOne = true;
//         }
//       }
//     });
//
//     _socket.connect();
//   }
//
//   void disconnectSocket() {
//     _socket.disconnect();
//   }
//
//   // late IO.Socket _socket;
//   // void connectToServer(context) {
//   //   final wgr = Provider.of<WinGoResultViewModel>(context, listen: false);
//   //   _socket = IO.io(
//   //     WinGoApiUrl.wingoSocketUrl,
//   //     IO.OptionBuilder().setTransports(['websocket']).build(),
//   //   );
//   //
//   //   socket.on('connect', () {
//   //     if (kDebugMode) {
//   //       print("Connected");
//   //     }
//   //   });
//   //
//   //   _socket.onConnectError((data) {
//   //     if (kDebugMode) {
//   //       print("Connection error $data");
//   //     }
//   //   });
//   //
//   //
//   //   _socket.on(WinGoApiUrl.wingoEventTen, (response) {
//   //     final res = jsonDecode(response);
//   //     set1MinutesData(res['timerBetTime'], res['timerStatus']);
//   //     if(gameIndex==0){
//   //       if(res['timerBetTime']==1&&res['timerStatus']==1){
//   //         resOne=false;
//   //       }
//   //       if(res['timerBetTime']==3&&res['timerStatus']==2&&resOne==false){
//   //         wgr.wingoResultApi(context,1,gameIndex);
//   //         Provider.of<WinGoGameHisViewModel>(context, listen: false).gameHisApi(context, 0);
//   //         Provider.of<WinGoMyHisViewModel>(context, listen: false).myBetHisApi(context, 0);
//   //
//   //         // last  five result
//   //         resOne=true;
//   //       }
//   //     }
//   //   });
//   //
//   //   _socket.on(WinGoApiUrl.wingoEventOne, (response) {
//   //     final res = jsonDecode(response);
//   //     set3MinutesData(res['timerBetTime'], res['timerStatus']);
//   //     if(gameIndex==1){
//   //       if(res['timerBetTime']==1&&res['timerStatus']==1){
//   //         resOne=false;
//   //
//   //       }
//   //       if(res['timerBetTime']==3&&res['timerStatus']==2&&resOne==false){
//   //         wgr.wingoResultApi(context,1,gameIndex);
//   //         Provider.of<WinGoGameHisViewModel>(context, listen: false).gameHisApi(context, 0);
//   //         Provider.of<WinGoMyHisViewModel>(context, listen: false).myBetHisApi(context, 0);
//   //
//   //         // last  five result
//   //         resOne=true;
//   //       }
//   //     }
//   //   });
//   //
//   //   _socket.on(WinGoApiUrl.wingoEventThree, (response) {
//   //     final res = jsonDecode(response);
//   //     set5MinutesData(res['timerBetTime'], res['timerStatus']);
//   //     if(gameIndex==2){
//   //       if(res['timerBetTime']==1&&res['timerStatus']==1){
//   //         resOne=false;
//   //
//   //       }
//   //       if(res['timerBetTime']==3&&res['timerStatus']==2&&resOne==false){
//   //         wgr.wingoResultApi(context,1,gameIndex);
//   //         Provider.of<WinGoGameHisViewModel>(context, listen: false).gameHisApi(context, 0);
//   //         Provider.of<WinGoMyHisViewModel>(context, listen: false).myBetHisApi(context, 0);
//   //
//   //         // last  five result
//   //         resOne=true;
//   //       }
//   //     }
//   //   });
//   //
//   //   _socket.on(WinGoApiUrl.wingoEventFive, (response) {
//   //     final res = jsonDecode(response);
//   //     set10MinutesData(res['timerBetTime'], res['timerStatus']);
//   //     if(gameIndex==3){
//   //       if(res['timerBetTime']==1&&res['timerStatus']==1){
//   //         resOne=false;
//   //       }
//   //       if(res['timerBetTime']==3&&res['timerStatus']==2&&resOne==false){
//   //         wgr.wingoResultApi(context,1,gameIndex);
//   //         Provider.of<WinGoGameHisViewModel>(context, listen: false).gameHisApi(context, 0);
//   //         Provider.of<WinGoMyHisViewModel>(context, listen: false).myBetHisApi(context, 0);
//   //
//   //         // last  five result
//   //         resOne=true;
//   //       }
//   //     }
//   //   });
//   //   _socket.connect();
//   // }
//
//   bool isPlayAllowed(int time, int status, context) {
//     if ((status == 1 && time <= 5) || status == 2) {
//       if (kDebugMode) {
//         Utils.flushBarErrorMessage("No more bet", context, Colors.red);
//       }
//       return false;
//     }
//     return true;
//   }
//
//   void disConnectToServer(context) async {
//     _gameIndex=0;
//     _socket.disconnect();
//     _socket.clearListeners();
//     _socket.close();
//     Audio.audioPlayers.dispose();
//     if (kDebugMode) {
//       print('SOCKET DISCONNECT');
//     }
//   }
//
//   String formatTime(int seconds, int position) {
//     final Duration duration = Duration(seconds: seconds);
//     final int minutes = duration.inMinutes;
//     final int remainingSeconds = duration.inSeconds % 60;
//
//     return position == 0
//         ? minutes.toString().padLeft(2, '0')
//         : remainingSeconds.toString().padLeft(2, '0');
//   }
// }
//
//
// class GameTimerModel{
//   String title;
//   String subTitle;
//   GameTimerModel({required this.title,required this.subTitle});
// }