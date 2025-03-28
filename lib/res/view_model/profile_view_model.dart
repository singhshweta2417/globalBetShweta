import 'package:flutter/foundation.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/repo/profile_repo.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfileViewModel with ChangeNotifier {
  final _profileRepo = ProfileRepository();
  dynamic _balance = 0;

  dynamic get balance => _balance;

  void addBalance(dynamic amount) {
    _balance += amount;
    notifyListeners();
  }

  void deductBalance(dynamic amount) {
    _balance -= amount;
    notifyListeners();
  }

  void setBalance(dynamic amount) {
    _balance = amount;
    notifyListeners();
  }

///mainWallet
  dynamic _mainWallet = 0;

  dynamic get mainWallet => _mainWallet;
  void addMainWallet(dynamic wallet) {
    _mainWallet = wallet;
    notifyListeners();
  }


  ///thirdPartyWallet
  dynamic _thirdPartyWallet = 0;

  dynamic get thirdPartyWallet => _thirdPartyWallet;
  void addThirdPartyWallet(dynamic thirdParty) {
    _thirdPartyWallet = thirdParty;
    notifyListeners();
  }


  ///userImage
  String _userName = '';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  ///userImage
  String _userImage = '';

  String get userImage => _userImage;
  void setUserImage(String image) {
    _userImage = image;
    notifyListeners();
  }

  ///userId
  String _userId = '';

  String get userId => _userId;
  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }

  ///lastLoginTime
  String _lastLoginTime = '';

  String get lastLoginTime => _lastLoginTime;
  void setLastLoginTime(String lastLogin) {
    _lastLoginTime = lastLogin;
    notifyListeners();
  }
  ///referralCode
  String _referralCodeUrl = '';

  String get referralCodeUrl => _referralCodeUrl;
  void setReferralCodeUrl(String codeUrl) {
    _referralCodeUrl = codeUrl;
    notifyListeners();
  }
  ///aviatorLink
  String _aviatorLink = '';

  String get aviatorLink => _aviatorLink;
  void setAviatorLink(String link) {
    _aviatorLink = link;
    notifyListeners();
  }

  ///eventName
  String _aviatorEvent = '';

  String get aviatorEvent => _aviatorEvent;
  void setAviatorEvent(String event) {
    _aviatorEvent = event;
    notifyListeners();
  }

  ///appLink
  String _appLink = '';

  String get appLink => _appLink;

  void setAppLink(String appLink) {
    _appLink = appLink;
    notifyListeners();
  }
  ///recharge
  dynamic _recharge = 0;

  dynamic get recharge => _recharge;

  void setRecharge(dynamic charge) {
    _recharge = charge;
    notifyListeners();
  }
  ///minimumWithdraw
  String _minimumWithdraw = '';

  String get minimumWithdraw => _minimumWithdraw;

  void setMinimumWithdraw(String withdraw) {
    _minimumWithdraw = withdraw;
    notifyListeners();
  }

  Future<void> profileApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    UserModel user = await userViewModel.getUser();
    String userId = user.id.toString();
    _profileRepo.profileApi(userId).then((value) {
      if (value.status == 200) {
        // ProfileModel profileData = ProfileModel.fromJson(value);
        Provider.of<ProfileViewModel>(context, listen: false)
            .setAppLink('${value.apkLink}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setRecharge('${value.recharge}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setMinimumWithdraw('${value.minimumWithdraw}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .addThirdPartyWallet('${value.thirdPartyWallet}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .addMainWallet('${value.mainWallet}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setReferralCodeUrl('${value.referralCodeUrl}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setUserImage('${value.userimage}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setAviatorEvent('${value.aviatorEventName}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setAviatorLink('${value.aviatorLink}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setLastLoginTime('${value.lastLoginTime}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setUserId('${value.uId}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setUserName('${value.username}');
        Provider.of<ProfileViewModel>(context, listen: false)
            .setBalance(value.totalWallet ?? 0);
      } else {
        if (kDebugMode) {
          print('value: ${value.message}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
