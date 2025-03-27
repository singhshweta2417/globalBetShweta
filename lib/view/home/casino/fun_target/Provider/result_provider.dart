import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/url.dart';
import '../../../../../utils/utils.dart';
import '../Model/result_model.dart';

import 'package:http/http.dart' as http;

class ResultProvider extends ChangeNotifier {
  ResultModel? _result;

  ResultModel? get result => _result;

  Future<void> fetchResultData(context) async {
    final response = await http.get(Uri.parse(AppUrls.resultApiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _result = ResultModel.fromJson(data);
      } else {
        Utils.flushBarErrorMessage(
            responseData['message'], context, Colors.red);
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
