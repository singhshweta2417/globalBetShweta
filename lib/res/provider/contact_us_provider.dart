import 'package:game_on/model/terms_condition_model.dart';
import 'package:flutter/material.dart';


class ContactUsProvider with ChangeNotifier {
  TcModel? _contactusData;

  TcModel? get contactUsData => _contactusData;

  void setCu(TcModel contactData) {
    _contactusData = contactData;
    notifyListeners();
  }
}