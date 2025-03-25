
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/result_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/repo/result_repo.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/get_amount_view_model.dart';
import 'package:provider/provider.dart';

class ResultViewModel with ChangeNotifier {
  final _resultRepo = ResultRepository();
  bool _loading = false;
  bool get loading => _loading;
  ResultModel? _resultModel;
  ResultModel? get resultModel => _resultModel;
  Data? getLastResult;
  Data? getFirstResult;

  int? _lastGameNo;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setResultData(ResultModel value) {
    int newGameNo = value.data!.first.gamesNo;

    if (_resultModel == null || newGameNo != _lastGameNo) {
      _resultModel = value;
      getLastResult = value.data!.last;
      getFirstResult = value.data!.first;

      _lastGameNo = newGameNo; // Update stored game number
      notifyListeners();
    }
  }

  Future<void> resultApi(context) async {
    final data = {
      "game_id": "21",
      "limit": 10
    };

    setLoading(true);
    try {
      final value = await _resultRepo.resultApi(data);

      if (value.status == true) {
        int newGameNo = value.data!.first.gamesNo;

        if (_lastGameNo == null || newGameNo != _lastGameNo) {
          setResultData(value);

          // Ensure result data is updated before calling getAmountApi
          Future.delayed(const Duration(milliseconds: 500), () {
            final getAmountProvider = Provider.of<GetAmountViewModel>(context, listen: false);
            getAmountProvider.getAmountApi(context, newGameNo.toString());
          });

          // Update profile only when the game number changes
          final profileController = Provider.of<ProfileViewModel>(context, listen: false);
          profileController.profileApi(context);
        }
      } else {
        if (kDebugMode) {
          print("Error: API returned unexpected response");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error in resultApi: $error");
      }
    } finally {
      setLoading(false);
    }
  }
  }


