import 'package:flutter/cupertino.dart';
import 'package:game_on/res/orientation.dart';
import 'package:game_on/view/home/rummy/teen_patti/res/card_distribution.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/game_screens/game_screen.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/game_screens/summary_screen.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/game_screens/waiting_screen.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/room_timer_service.dart';
import 'package:provider/provider.dart';

import '../../../../../../material_imports.dart';

class GameUIControlScreenActivity extends StatefulWidget {
  const GameUIControlScreenActivity({super.key});

  @override
  State<GameUIControlScreenActivity> createState() =>
      _GameUIControlScreenActivityState();
}

class _GameUIControlScreenActivityState
    extends State<GameUIControlScreenActivity> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OrientationLandscapeUtil.setLandscapeOrientation();
      Provider.of<RoomTimerProvider>(context, listen: false).startTimer(() {
        debugPrint("data getting over");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
        if (gameCon.gameData == null) {
          return const Scaffold(
              body: CText("Your game is setting up! please wait for a while"));
        } else if (gameCon.gameData!['game_event']['status'] == 1) {
          return WaitingScreenActivity(
            playersJoined: gameCon.gameData!['players'].length,
          );
        } else if (gameCon.gameData!['game_event']['status'] == 2) {
          return const CardDistributionScreenActivity(
            cardPerPlayer: 1,
            isAnimationAllowed: true,
          );
        } else if (gameCon.gameData!['game_event']['status'] == 4) {
          return const ThreeCardDistributionScreenActivity(
            cardPerPlayer: 4,
            isAnimationAllowed: true,
          );
        } else if (gameCon.gameData!['game_event']['status'] == 5) {
          return const GameScreenActivity();
        } else if (gameCon.gameData!['game_event']['status'] == 6) {
          return SummaryScreenActivity(
            gameData: gameCon.gameData!,
            roomCode: gameCon.roomCode,
          );
        }
        return const CardDistributionScreenActivity(
          cardPerPlayer: 1,
        );
      }),
    );
  }

  Future<bool> _onWillPop() async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Exit Game"),
            content: const Text("Are you sure you want to leave the game?"),
            actions: [
              CupertinoDialogAction(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
                return CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text("Exit"),
                  onPressed: () async => await gameCon.leaveTable(context),
                );
              }),
            ],
          ),
        ) ??
        false;
  }
}
