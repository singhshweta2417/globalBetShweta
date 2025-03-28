import 'package:game_on/model/terms_condition_model.dart';
import 'package:flutter/material.dart';


class TermsConditionProvider with ChangeNotifier {
  TcModel? _tcData;

  TcModel? get tcData => _tcData;

  void setterms(TcModel condData) {
    _tcData = condData;
    notifyListeners();
  }
}