import 'package:flutter/material.dart';
import 'package:game_on/model/about_us_model.dart';


class AboutusProvider with ChangeNotifier {
  AboutusModel? _aboutusData;

  AboutusModel? get aboutusData => _aboutusData;

  void setUser(AboutusModel userData) {
    _aboutusData = userData;
    notifyListeners();
  }
}