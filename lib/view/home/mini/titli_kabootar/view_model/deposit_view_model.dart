import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/account_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/repo/deposit_repo.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/qr_page.dart';

class DepositViewModel with ChangeNotifier {
  final _depositRepo = DepositRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> userPayinApi(dynamic amount,  context) async {
    setLoading(true);
    try {
      UserViewProvider userProvider = UserViewProvider();
      UserModel user = await userProvider.getUser();
      String userId = user.id.toString();

      Map<String, dynamic> data = {
        "user_id": userId,
        "cash": amount,
        "type" : "1"
      };

      final value = await _depositRepo.userPayin(data);
      if (value["status"] == "SUCCESS") {
        final String? urlLink = value["payment_link"]?.toString();
        setLoading(false);
        if (urlLink != null && urlLink.isNotEmpty && urlLink != "null") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExtraDepositPay(url: urlLink)),
          );
        }
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(value['message'].toString(), context, Colors.red);
      }
    } catch (error) {
      setLoading(false);
      if (kDebugMode) {
        print('API Error: $error');
      }
      Utils.flushBarErrorMessage("Something went wrong. Please try again.", context, Colors.red);
    }
  }


  bool _addAccountLoading = false;

  bool get addAccountLoading => _addAccountLoading;

  setAddLoading(bool value) {
    _addAccountLoading= value;
    notifyListeners();
  }

  Future<void> addAccountApi(dynamic name, dynamic accountNum , dynamic bankName, dynamic ifscCode, dynamic upiId,context) async {
    setAddLoading(true);
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    Map<String, dynamic> data =
    {
      "userid" : userId,
      "name" : name,
      "account_number" : accountNum,
      "bank_name" : bankName,
      "ifsc_code" : ifscCode,
      "upi" : upiId

    };
    if (kDebugMode) {
      print('Data being sent: $data');
    }
    _depositRepo.addAccountApi(data).then((value) {
      if (value['status'] == "true") {
        setAddLoading(false);
        // Navigator.pushNamed(context, RoutesName.dashboard);
        Utils.flushBarSuccessMessage(value['message'].toString(), context, Colors.green);
        playTTSMessage(value['message'].toString());
      }
      else {
        setAddLoading(false);
        Utils.flushBarErrorMessage(value['message'].toString(), context, Colors.red);
      }
    }).onError((error, stackTrace) {
      setAddLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }


  bool _accountViewLoading = false;
  bool get accountViewLoading => _accountViewLoading;
  setAccountViewLoading(bool value) {
    _accountViewLoading= value;
    notifyListeners();
  }

  AccountViewModel? _accountViewModel;
  AccountViewModel? get accountViewModel => _accountViewModel;
  setAccountViewData(AccountViewModel value) {
    _accountViewModel = value;
    notifyListeners();
  }


  Future<void> accountViewApi(context) async {
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    final data = {
      "userid" : userId,
    };
    if (kDebugMode) {
      print("Account View Data");
      print({
        "userid" : userId,
      });
    }
    setAccountViewLoading(true);
    _depositRepo.viewAccountApi(data).then((value) {
      if (value.status == "true") {
        setAccountViewLoading(false);
        setAccountViewData(value);
      }
    }).onError((error, stackTrace) {
      setAccountViewLoading(false);
      if (kDebugMode) {
        print('error on HistoryAPI : $error');
      }
    });
  }

  Future<void> withdrawApi(dynamic accountId, dynamic amount,dynamic upiId, context) async {
    setAddLoading(true);
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();

    if (accountId == null || accountId.toString().isEmpty) {
      setAddLoading(false);
      Utils.flushBarErrorMessage("Error: Account ID is required!", context, Colors.red);
      return;
    }

    Map<String, dynamic> data = {
      "user_id": userId,
      "account_id": accountId,
      "amount": amount,
      "upi": upiId
    };

    if (kDebugMode) {
      print('Data being sent: $data');
    }

    try {
      var value = await _depositRepo.withdrawApi(data);
      setAddLoading(false);

      if (value['status'] == "true") {
        Navigator.pushNamed(context, RoutesName.dashboard);
        Utils.flushBarSuccessMessage(value['message'], context, Colors.black);
        playTTSMessage(value['message'].toString());
      } else {
        Utils.flushBarErrorMessage(value['message'], context, Colors.black);
      }
    } catch (error) {
      setAddLoading(false);
      if (kDebugMode) {
        print('API error: $error');
      }
      Utils.flushBarErrorMessage("Something went wrong. Please try again.", context, Colors.red);
    }
  }



}

Future<void> playTTSMessage(String message) async {
  // FlutterTts flutterTts = FlutterTts();

  // await flutterTts.setLanguage("en-US");
  // await flutterTts.setSpeechRate(0.5);
  //
  // var result = await flutterTts.speak(message);
  //
  // if (result == 1) {
  //   if (kDebugMode) {
  //     print("TTS playback started.");
  //   }
  // } else {
  //   if (kDebugMode) {
  //     print("Error playing TTS.");
  //   }
  // }
}
