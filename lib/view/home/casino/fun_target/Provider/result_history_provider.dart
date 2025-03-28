import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_on/view/home/casino/fun_target/Constant/url.dart';
import 'package:http/http.dart' as http;
import '../../../../../utils/utils.dart';
import '../Model/result_history_model.dart';

class ResultHistoryProvider extends ChangeNotifier {
  ResultHistoryModel? _result;

  ResultHistoryModel? get result => _result;

  Future<void> fetchResultHistoryData(context) async {
    final response = await http.get(Uri.parse(AppUrls.resultHistoryApiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if(responseData['status']==200){
        final Map<String, dynamic> data = responseData;
        _result = ResultHistoryModel.fromJson(data);
      }
      else{
        Utils.flushBarErrorMessage(responseData['message'],context,Colors.red);
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
