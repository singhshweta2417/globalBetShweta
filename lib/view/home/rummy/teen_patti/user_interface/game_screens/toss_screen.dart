import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:provider/provider.dart';
import '../../../../../../material_imports.dart';
import '../components/person_profile.dart';
import '../components/players_positioning.dart';

class TossScreenActivity extends StatelessWidget {
  const TossScreenActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      final mePlayer = gameCon.gameData!['players']
          .firstWhere((e) => e['id'] == gameCon.currentUserData!.id);
      return Scaffold(
        body: Center(
          child: ContBox(
            color: Colors.black,
            height: Sizes.screenWidth,
            width: Sizes.screenWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(Sizes.screenWidth * 0.03, 0,
                Sizes.screenWidth * 0.03, Sizes.screenWidth * 0.005),
            child: ContBox(
              color: Colors.black,
              padding: const EdgeInsets.all(0),
              height: Sizes.screenHeight / 1.03,
              width: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                  ? Sizes.screenWidth
                  : Sizes.screenWidth / 1.2,
              alignment: Alignment.bottomCenter,
              image: const DecorationImage(
                  image: AssetImage(Assets.teenPattiGameB),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        "Game room: ${gameCon.roomCode}",
                        color: Colors.white,
                        width: Sizes.screenWidth / 4,
                        margin: const EdgeInsets.only(top: 10),
                        weight: FontWeight.w600,
                      ),
                      Image.asset(
                        Assets.teenPattiLadyImg,
                        width: Sizes.screenWidth / 9,
                      ),
                      CText(
                        "Wallet balance: ${gameCon.walletBalance}",
                        color: Colors.white,
                        width: Sizes.screenWidth / 4,
                        margin: const EdgeInsets.only(top: 10),
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  ContBox(
                      height: Sizes.screenHeight / 2,
                      clipBehavior: Clip.none,
                      child: const PlayerPositioning()),
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      if (gameCon.gameData!['game_event']['status'] == 2 ||
                          gameCon.gameData!['game_event']['status'] == 3)
                        Positioned(
                            top: -Sizes.screenHeight / 8,
                            child: cardImage(
                                gameCon.gameData!['game_event']['status'] == 2
                                    ? Assets.diamondsBack
                                    : mePlayer['tossCard'])),
                      PersonProfile(
                        Assets.personPersonLady,
                        playerId: mePlayer['id'],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget cardImage(String cardImg) {
    return ContBox(
      height: Sizes.screenWidth / 14,
      width: Sizes.screenWidth / 21,
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(image: AssetImage(cardImg)),
    );
  }
}
