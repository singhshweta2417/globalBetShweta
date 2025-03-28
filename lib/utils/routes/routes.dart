import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/utils/routes/routes_name.dart';
import 'package:game_on/view/account/History/betting_history.dart';
import 'package:game_on/view/account/gifts.dart';
import 'package:game_on/view/account/service_center/feedback.dart';
import 'package:game_on/view/auth/login_screen.dart';
import 'package:game_on/view/auth/register_otp.dart';
import 'package:game_on/view/auth/splash_screen_test.dart';
import 'package:game_on/view/bottom/bottom_nav_bar.dart';
import 'package:game_on/view/home/lottery/wingo/win_go.dart';
import 'package:game_on/view/home/mini/Aviator/home_page_aviator.dart';
import 'package:game_on/view/home/mini/titli_kabootar/view/titli_home.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/game_screens/game_ui_control_screen.dart';
import 'package:game_on/view/wallet/add_bank_account.dart';
import 'package:game_on/view/wallet/deposit_history.dart';
import 'package:game_on/view/wallet/deposit_screen.dart';
import 'package:game_on/view/wallet/withdraw_screen.dart';
import 'package:game_on/view/wallet/withdrawal_history.dart';
import 'package:flutter/material.dart';
import '../../res/components/text_widget.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      case RoutesName.splashScreen:
        return (context) => const Splash();
      case RoutesName.bottomNavBar:
        return (context) => const BottomNavBar();
      case RoutesName.loginScreen:
        return (context) => const LoginScreen();
      case RoutesName.registerScreenOtp:
        return (context) => const RegisterScreenOtp();
      case RoutesName.depositScreen:
        return (context) => const DepositScreen();
      case RoutesName.withdrawScreen:
        return (context) => const WithdrawScreen();
      case RoutesName.addBankAccount:
        return (context) => AddBankAccount();
      case RoutesName.depositHistory:
        return (context) => const DepositHistory();
      case RoutesName.withdrawalHistory:
        return (context) => const WithdrawHistory();
      case RoutesName.aviatorGame:
        return (context) => const GameAviator();
      case RoutesName.winGoScreen:
        return (context) => const WinGo();
      case RoutesName.Bethistoryscreen:
        return (context) => const BetHistory();

      case RoutesName.feedbackscreen:
        return (context) => const FeedbackPage();
      case RoutesName.giftsscreen:
        return (context) => const GiftsPage();
      case RoutesName.waitingActivity:
        return (context) => const GameUIControlScreenActivity();
      case RoutesName.titli:
        return (context) => const TitliHomeScreen();
      default:
        return (context) => Scaffold(
              body: Center(
                child: textWidget(
                    text: 'No Route Found!',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor),
              ),
            );
    }
  }
}
