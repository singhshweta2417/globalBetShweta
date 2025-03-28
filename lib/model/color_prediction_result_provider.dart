import 'package:game_on/model/color_prediction_model.dart';
import 'package:flutter/material.dart';


class ColorPredictionProvider with ChangeNotifier {
  List<ColorPredictionModel> _resultListColor = [];

  List<ColorPredictionModel> get resultListColorList => _resultListColor;

  void setColorResultList(List<ColorPredictionModel> colorList) {
    _resultListColor = colorList;
    notifyListeners();
  }
}
