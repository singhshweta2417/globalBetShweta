import 'package:flutter/foundation.dart';
import 'package:game_on/model/country_model.dart';
import 'package:game_on/offer/country_repo.dart';


class CountryViewModel with ChangeNotifier {
  final _countryRepository = CountryRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  CountryCodeModel? _countryModelData;
  CountryCodeModel? get countryModelData => _countryModelData;
  setCountryModel(CountryCodeModel value) {
    _countryModelData = value;
    notifyListeners();
  }

  Future<void> countryApi(context, data) async {

    _countryRepository.countryApi(data).then((value) {
      if (value.status == "success") {
        setCountryModel(value);
      } else {

      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('UserProfileViewModel: $error');
      }
    });
  }
}
