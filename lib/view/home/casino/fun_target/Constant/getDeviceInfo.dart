// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
//
// void getDeviceInformation() async {
//   print("function on");
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//
//   try {
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       deviceId = androidInfo.id;
//       deviceName = androidInfo.device;
//       deviceModel = androidInfo.model;
//       deviceOS = 'Android ${androidInfo.version.release}';
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       deviceId = iosInfo.identifierForVendor.toString();
//       deviceName = iosInfo.name;
//       deviceModel = iosInfo.model;
//       deviceOS = 'iOS ${iosInfo.systemVersion}';
//     }
//   } catch (e) {
//     print('Error getting device info: $e');
//   }
// }
