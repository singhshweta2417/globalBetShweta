import 'package:flutter/foundation.dart';
import 'package:game_on/model/offer_model.dart';
import 'package:game_on/offer/offer_repo.dart';


class OfferViewModel with ChangeNotifier {
  final _offerRepository = OfferRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  OfferModel? _offerModelData;
  OfferModel? get offerModelData => _offerModelData;
  setOfferModel(OfferModel value) {
    _offerModelData = value;
    notifyListeners();
  }

  Future<void> offerApi(context) async {

    _offerRepository.offerApi().then((value) {
      if (value.status == "success") {
        setOfferModel(value);
      } else {

      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('UserProfileViewModel: $error');
      }
    });
  }
}
