import 'package:globalbet/model/terms_condition_model.dart';
import 'package:flutter/material.dart';


class PrivacyPolicyProvider with ChangeNotifier {
  TcModel? _ppData;

  TcModel? get PpData => _ppData;

  void setPrivacy(TcModel privacyData) {
    _ppData = privacyData;
    notifyListeners();
  }
}