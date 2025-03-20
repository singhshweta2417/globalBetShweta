
import 'package:flutter/foundation.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/profile_provider.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/repo/bet_repo.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/get_amount_view_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/result_view_model.dart';
import 'package:provider/provider.dart';

class BetViewModel with ChangeNotifier {
  final _titliBetRepo = BetRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> titliBetApi(dynamic betList, context) async {
    setLoading(true);
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();

    Map data = {
      "userid": userId,
      "game_id": 21,
      "bet": betList
    };

    try {
      final value = await _titliBetRepo.betApi(data);
      if (value["status"] == true) {
        setLoading(false);

        final resultProvider = Provider.of<ResultViewModel>(context, listen: false);
        final getAmountProvider = Provider.of<GetAmountViewModel>(context, listen: false);

        // Call getAmountApi only if resultModel exists
        if (resultProvider.resultModel?.data != null && resultProvider.resultModel!.data!.isNotEmpty) {
          int nextGameNo = resultProvider.resultModel!.data!.first.gamesNo + 1;
          getAmountProvider.getAmountApi(context, nextGameNo.toString());
        }

        // Update profile
        final profileController = Provider.of<ProfileProvider>(context, listen: false);
        profileController.fetchProfileData();

        // Success message & TTS
        Utils.flushBarSuccessMessage(value['message'].toString(), context, AppColors.green);
        playTTSMessage("Bet Successfully Placed");
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(value['message'].toString(), context, AppColors.red);
      }
    } catch (error) {
      setLoading(false);
      if (kDebugMode) {
        print('Error in Bet API: $error');
      }
    }
  }
}

Future<void> playTTSMessage(String message) async {
  // FlutterTts flutterTts = FlutterTts();
  // await flutterTts.setLanguage("en-US");
  // await flutterTts.setSpeechRate(0.5);
  // var result = await flutterTts.speak(message);
  // if (result != 1 && kDebugMode) {
  //   print("Error playing TTS.");
  // }
}
