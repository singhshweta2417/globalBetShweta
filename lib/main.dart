import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:game_on/model/color_prediction_result_provider.dart';
import 'package:game_on/offer/offer_view_model.dart';
import 'package:game_on/res/app_constant.dart';
import 'package:game_on/res/provider/terms_condition_provider.dart';
import 'package:game_on/res/provider/about_us_provider.dart';
import 'package:game_on/res/provider/add_acount_controller.dart';
import 'package:game_on/res/provider/auth_provider.dart';
import 'package:game_on/res/provider/bet_color_prediction_provider.dart';
import 'package:game_on/res/provider/bet_color_prediction_trx.dart';
import 'package:game_on/res/provider/contact_us_provider.dart';
import 'package:game_on/res/provider/feedback_provider.dart';
import 'package:game_on/res/provider/gift_code_provider.dart';
import 'package:game_on/res/provider/plinko_bet_provider.dart';
import 'package:game_on/res/provider/privacy_policy_provider.dart';
import 'package:game_on/res/provider/slider_provider.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/utils/routes/routes.dart';
import 'package:game_on/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/view/home/casino/fun_target/Provider/result_history_provider.dart';
import 'package:game_on/view/home/casino/fun_target/Provider/result_provider.dart';
import 'package:game_on/view/home/casino/fun_target/api/bet_service.dart';
import 'package:game_on/view/home/casino/fun_target/api/take_winning_amount_service.dart';
import 'package:game_on/view/home/casino/lucky_card_12/controller/lucky_12_controller.dart';
import 'package:game_on/view/home/casino/lucky_card_12/view_model/lucky_12_bet_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_12/view_model/lucky_12_history_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_12/view_model/lucky_12_result_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_16/controller/lucky_16_controller.dart';
import 'package:game_on/view/home/casino/lucky_card_16/view_model/lucky_16_bet_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_16/view_model/lucky_16_history_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_16/view_model/lucky_16_result_view_model.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_bet_view_model.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_game_history_view_model.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_result_view_model.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_win_popup_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/view_model/seven_up_down_bet_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/view_model/seven_up_down_game_history_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/view_model/seven_up_down_result_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/view_model/seven_up_down_win_popup.dart';
import 'package:game_on/view/home/casino/triple_chance/controller/triple_chance_controller.dart';
import 'package:game_on/view/home/casino/triple_chance/view_model/triple_chance_bet_view_model.dart';
import 'package:game_on/view/home/casino/triple_chance/view_model/triple_chance_history_view_model.dart';
import 'package:game_on/view/home/casino/triple_chance/view_model/triple_chance_result_view_model.dart';
import 'package:game_on/view/home/lottery/trx/controller/trx_controller.dart';
import 'package:game_on/view/home/lottery/trx/view_model/trx_bet_view_model.dart';
import 'package:game_on/view/home/lottery/trx/view_model/trx_game_his_view_model.dart';
import 'package:game_on/view/home/lottery/trx/view_model/trx_my_bet_his_view_model.dart';
import 'package:game_on/view/home/lottery/trx/view_model/trx_result_view_model.dart';
import 'package:game_on/view/home/lottery/trx/view_model/trx_win_amount_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/controller/win_go_controller.dart';
import 'package:game_on/view/home/lottery/wingo/view_model/win_go_bet_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/view_model/win_go_game_his_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/view_model/win_go_my_his_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/view_model/win_go_pop_up_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/view_model/win_go_result_view_model.dart';
import 'package:game_on/view/home/mini/Aviator/aviator_provider.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_bet_api.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_bet_history_api.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_bool_provider.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_result_api.dart';
import 'package:game_on/view/home/mini/mines/controller/mine_controller.dart';
import 'package:game_on/view/home/mini/mines/view_model/mine_bet_his_view_model.dart';
import 'package:game_on/view/home/mini/mines/view_model/mine_bet_view_model.dart';
import 'package:game_on/view/home/mini/mines/view_model/mine_cash_out_view_model.dart';
import 'package:game_on/view/home/mini/mines/view_model/mine_drop_down_view_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/controller/controller.dart';
import 'package:game_on/view/home/mini/titli_kabootar/view_model/bet_view_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/view_model/get_amount_view_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/view_model/history_view_model.dart';
import 'package:game_on/view/home/rummy/spin_to_win/controller/spin_controller.dart';
import 'package:game_on/view/home/rummy/spin_to_win/view_model/spin_bet_view_model.dart';
import 'package:game_on/view/home/rummy/spin_to_win/view_model/spin_history_view_model.dart';
import 'package:game_on/view/home/rummy/spin_to_win/view_model/spin_result_view_model.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/card_throw_animaton.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/room_timer_service.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'firebase_options.dart';
import 'view/home/mini/titli_kabootar/view_model/result_view_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("error $e");
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: []);
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  runApp(const MyApp());
}

double heightFun = 360.0;
double widthFun = 720.0;
double ratioFun = 2;
double height = 0.0;
double width = 0.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    double heightRatio = MediaQuery.of(context).size.height;
    double widthRatio = MediaQuery.of(context).size.width;
    ratioFun = widthRatio / heightRatio;
    heightFun = heightRatio;
    widthFun = widthRatio;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width > 500
        ? 500
        : MediaQuery.of(context).size.width;
    WakelockPlus.enable();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => AviatorWallet()),
        // ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SliderProvider()),
        ChangeNotifierProvider(create: (context) => AboutusProvider()),
        ChangeNotifierProvider(create: (context) => AddacountProvider()),
        ChangeNotifierProvider(create: (context) => GiftCardProvider()),
        ChangeNotifierProvider(create: (context) => ColorPredictionProvider()),
        ChangeNotifierProvider(create: (context) => BetColorResultProvider()),
        ChangeNotifierProvider(create: (context) => FeedbackProvider()),
        ChangeNotifierProvider(create: (context) => TermsConditionProvider()),
        ChangeNotifierProvider(create: (context) => PrivacyPolicyProvider()),
        ChangeNotifierProvider(create: (context) => ContactUsProvider()),
        ChangeNotifierProvider(
            create: (context) => BetColorResultProviderTRX()),
        ChangeNotifierProvider(create: (context) => PlinkoBetHistoryProvider()),
        //win go
        ChangeNotifierProvider(create: (context) => WinGoController()),
        ChangeNotifierProvider(create: (context) => WinGoGameHisViewModel()),
        ChangeNotifierProvider(create: (context) => WinGoMyHisViewModel()),
        ChangeNotifierProvider(create: (context) => WinGoPopUpViewModel()),
        ChangeNotifierProvider(create: (context) => WinGoBetViewModel()),
        ChangeNotifierProvider(create: (context) => WinGoResultViewModel()),
        ChangeNotifierProvider(create: (context) => OfferViewModel()),
        ChangeNotifierProvider(create: (context) => TrxBetViewModel()),
        ChangeNotifierProvider(create: (context) => TrxGameHisViewModel()),
        ChangeNotifierProvider(create: (context) => TrxMyBetHisViewModel()),
        ChangeNotifierProvider(create: (context) => TrxResultViewModel()),
        ChangeNotifierProvider(create: (context) => TrxController()),
        ChangeNotifierProvider(create: (context) => TrxWinAmountViewModel()),
        ChangeNotifierProvider(create: (context) => MineBetHisViewModel()),
        ChangeNotifierProvider(create: (context) => MineBetViewModel()),
        ChangeNotifierProvider(create: (context) => MineCashOutViewModel()),
        ChangeNotifierProvider(create: (context) => MineDropDownViewModel()),
        ChangeNotifierProvider(create: (context) => MineController()),
        ChangeNotifierProvider(create: (context) => KiNoBoolProvider()),
        ChangeNotifierProvider(create: (context) => KinoBetApi()),
        ChangeNotifierProvider(create: (context) => KinoGameHistoryApi()),
        ChangeNotifierProvider(create: (context) => KinoResultApi()),
        ChangeNotifierProvider(create: (context) => BetViewModel()),
        ChangeNotifierProvider(create: (context) => GetAmountViewModel()),
        ChangeNotifierProvider(create: (context) => HistoryViewModel()),
        ChangeNotifierProvider(create: (context) => ResultViewModel()),
        ChangeNotifierProvider(create: (context) => TitliController()),

        ///lucky12
        ChangeNotifierProvider(create: (context) => Lucky12BetViewModel()),
        ChangeNotifierProvider(create: (context) => Lucky12HistoryViewModel()),
        ChangeNotifierProvider(create: (context) => Lucky12ResultViewModel()),
        ChangeNotifierProvider(create: (context) => Lucky12Controller()),

        ///lucky16
        ChangeNotifierProvider(create: (context) => Lucky16BetViewModel()),
        ChangeNotifierProvider(create: (context) => Lucky16HistoryViewModel()),
        ChangeNotifierProvider(create: (context) => Lucky16ResultViewModel()),
        ChangeNotifierProvider(create: (context) => Lucky16Controller()),

        ///tripleChance
        ChangeNotifierProvider(create: (context) => TripleChanceBetViewModel()),
        ChangeNotifierProvider(
            create: (context) => TripleChanceHistoryViewModel()),
        ChangeNotifierProvider(
            create: (context) => TripleChanceResultViewModel()),
        ChangeNotifierProvider(create: (context) => TripleChanceController()),

        ///spinToWin
        ChangeNotifierProvider(create: (context) => SpinBetViewModel()),
        ChangeNotifierProvider(create: (context) => SpinHistoryViewModel()),
        ChangeNotifierProvider(create: (context) => SpinResultViewModel()),
        ChangeNotifierProvider(create: (context) => SpinController()),

        ///funTarget
        ChangeNotifierProvider(create: (context) => ResultHistoryProvider()),
        ChangeNotifierProvider(create: (context) => ResultProvider()),
        ChangeNotifierProvider(create: (context) => BetService()),
        ChangeNotifierProvider(create: (context) => WinningAmountService()),

        ///teenPatti
        ChangeNotifierProvider(create: (context) => TeenPattiGameController()),
        ChangeNotifierProvider(create: (context) => CardThrowAnimation()),
        ChangeNotifierProvider(create: (context) => RoomTimerProvider()),

        ///RedBlack
        ChangeNotifierProvider(create: (context) => RedBlackBetViewModel()),
        ChangeNotifierProvider(create: (context) => RedBlackGameHistoryViewModel()),
        ChangeNotifierProvider(create: (context) => RedBlackPopUpViewModel()),
        ChangeNotifierProvider(create: (context) => RedBlackResultViewModel()),

        ///7UpDown
        ChangeNotifierProvider(create: (context) => SevenUpDownViewModel()),
        ChangeNotifierProvider(create: (context) => SevenUpDownGameHistoryViewModel()),
        ChangeNotifierProvider(create: (context) => SevenUpDownResultViewModel()),
        ChangeNotifierProvider(create: (context) => SevenUpDownPopUpViewModel()),
      ],
      child: Builder(
        builder: (context) {
          if (kIsWeb) {
            width = MediaQuery.of(context).size.width > 500
                ? 500
                : MediaQuery.of(context).size.width;
            return MaterialApp(
              navigatorKey: navigatorKey,
              builder: (context, child) {
                return Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: width,
                    ),
                    child: child,
                  ),
                );
              },
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.splashScreen,
              onGenerateRoute: (settings) {
                if (settings.name != null) {
                  return MaterialPageRoute(
                    builder: Routers.generateRoute(settings.name!),
                    settings: settings,
                  );
                }
                return null;
              },
            );
          } else {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              // home: TimerPage(),
              initialRoute: RoutesName.splashScreen,
              onGenerateRoute: (settings) {
                if (settings.name != null) {
                  return MaterialPageRoute(
                    builder: Routers.generateRoute(settings.name!),
                    settings: settings,
                  );
                }
                return null;
              },
            );
          }
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
