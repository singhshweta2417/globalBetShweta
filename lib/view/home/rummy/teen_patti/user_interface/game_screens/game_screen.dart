import 'dart:math';

import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/res/orientation.dart';
import 'package:globalbet/view/bottom/bottom_nav_bar.dart';
import 'package:globalbet/view/home/casino/triple_chance/widgets/exit_pop_up.dart';
import 'package:globalbet/view/home/rummy/teen_patti/user_interface/components/players_positioning.dart';
import 'package:globalbet/view/home/rummy/teen_patti/user_interface/components/user_control_panel.dart';
import 'package:provider/provider.dart';
import '../../../../../../material_imports.dart';
import '../../view_model/service/game_services.dart';

class GameScreenActivity extends StatefulWidget {
  const GameScreenActivity({super.key});

  @override
  State<GameScreenActivity> createState() => _GameScreenActivityState();
}

class _GameScreenActivityState extends State<GameScreenActivity>
    with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      return Scaffold(
        body: ContBox(
          height: Sizes.screenHeight,
          width: Sizes.screenWidth,
          alignment: Alignment.center,
          image: const DecorationImage(
              image: AssetImage('assets/teen_patti/home_bg.png'),
              fit: BoxFit.fill),
          padding: EdgeInsets.fromLTRB(Sizes.screenWidth * 0.03, 0,
              Sizes.screenWidth * 0.03, Sizes.screenWidth * 0.005),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: Sizes.screenHeight / 8,
                child: Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(
                        Sizes.screenWidth > 1000 ? (-pi / 4) : (-pi / 4)),
                  child: ContBox(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.all(0),
                    height:
                        Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                            ? Sizes.screenWidth / 2.5
                            : Sizes.screenWidth / 3,
                    width: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                        ? Sizes.screenWidth / 1.15
                        : Sizes.screenWidth / 1.4,
                    alignment: Alignment.topCenter,
                    image: const DecorationImage(
                        image: AssetImage(Assets.teenPattiGameB),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter),
                    child: Image.asset(
                      Assets.teenPattiLadyImg,
                      width: Sizes.screenWidth < 1000
                          ? Sizes.screenWidth / 10
                          : Sizes.screenWidth / 8.5,
                    ),
                  ),
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                ContBox(
                    height:
                        Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                            ? Sizes.screenWidth / 3.45
                            : Sizes.screenWidth / 4.5,
                    clipBehavior: Clip.none,
                    child: const PlayerPositioning()),
                const UserControlPanelSection(),
              ])
            ],
          ),
        ),
      );
    });
  }
}
