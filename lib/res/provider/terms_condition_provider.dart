import 'package:globalbet/model/terms_condition_model.dart';
import 'package:flutter/material.dart';


class TermsConditionProvider with ChangeNotifier {
  TcModel? _tcData;

  TcModel? get TcData => _tcData;

  void setterms(TcModel condData) {
    _tcData = condData;
    notifyListeners();
  }
}