// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:globalbet/view/home/mini/titli_kabootar/repo/auth_repo.dart';
// // import 'package:flutter_tts/flutter_tts.dart';
// import 'package:provider/provider.dart';
//
// class AuthViewModel with ChangeNotifier {
//   final _authRepo = AuthRepository();
//
//   bool _loading = false;
//
//   bool get loading => _loading;
//
//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }
//
//
//   bool _loadingTwo = false;
//   bool get loadingTwo => _loadingTwo;
//   setLoadingTwo(bool value) {
//     _loadingTwo = value;
//     notifyListeners();
//   }
//
//   bool _loadingOne = false;
//   bool get loadingOne => _loadingOne;
//   setLoadingOne(bool value) {
//     _loadingOne = value;
//     notifyListeners();
//   }
//
//   Future<void> loginApi(dynamic mobile, context) async {
//     setLoading(true);
//     final userPref = Provider.of<UserViewModel>(context, listen: false);
//     Map<String, dynamic> data =
//     {
//       "mobile": mobile,
//    };
//     if (kDebugMode) {
//       print('Data being sent: $data');
//     }
//     _authRepo.loginApi(data).then((value) {
//       if (value['status'] == true) {
//         userPref.saveUser(value['id'].toString());
//         setLoading(false);
//
//
//         if (kDebugMode) {
//           print("TTS about to play");
//         }
//         playTTSMessage("User Login Successfully");
//         Navigator.pushReplacementNamed(context, RoutesName.dashboard);
//         Utils.flushBarSuccessMessage(value['message'].toString(), context, Colors.green);
//       }
//
//       else {
//         setLoading(false);
//         Utils.flushBarErrorMessage(value['message'].toString(), context, Colors.red);
//       }
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       if (kDebugMode) {
//         print('error: $error');
//       }
//     });
//   }
//
//   Future<void> sendOtp(dynamic data, dynamic context) async {
//     _authRepo.sendOtp(data).then((value) {
//       if (value['error'] ==200) {
//         setLoadingTwo(true);
//
//       } else {
//         setLoadingTwo(false);
//
//       }
//     }).onError((error, stackTrace) {
//       setLoadingTwo(false);
//       if (kDebugMode) {
//         print('error: $error');
//       }
//     });
//   }
//
//
//   Future<void> verifyOtp(
//       dynamic data, dynamic myControllers, context) async {
//     setLoadingOne(true);
//     _authRepo.verifyOtp(data, myControllers).then((value) {
//       if (value['error'] == "200") {
//         loginApi(data, context);
//       } else {
//         setLoadingOne(false);
//         Utils.flushBarErrorMessage(value["msg"], context, Colors.red);
//       }
//     }).onError((error, stackTrace) {
//       setLoadingOne(false);
//       if (kDebugMode) {
//         print('error: $error');
//       }
//     });
//   }
//
// }
//
// Future<void> playTTSMessage(String message) async {
//   // Initialize FlutterTTS
//   FlutterTts flutterTts = FlutterTts();
//
//   // Set TTS options
//   await flutterTts.setLanguage("en-US");
//   await flutterTts.setSpeechRate(0.5);
//
//   // Speak the message
//   var result = await flutterTts.speak(message);
//
//   if (result == 1) {
//     if (kDebugMode) {
//       print("TTS playback started.");
//     }
//   } else {
//     if (kDebugMode) {
//       print("Error playing TTS.");
//     }
//   }
// }
