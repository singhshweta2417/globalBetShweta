import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/person_profile.dart';
import 'package:provider/provider.dart';


import '../../../../../../material_imports.dart';
import '../../view_model/service/game_services.dart';

class PlayerProfileWithCard extends StatelessWidget {
  final bool leftSide;
  final dynamic playerData;
  final bool showCardData;
  const PlayerProfileWithCard({
    super.key,
    this.leftSide = true,
    this.playerData,
    this.showCardData = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      final playerCard = gameCon.gameData!['game_event']['status'] <= 3
          ? [
              {'imageUrl': playerData['tossCard']}
            ]
          : playerData['hand'];
      final showCard = gameCon.gameData!['game_event']['status'] == 3;
      bool isPlayerTurn = gameCon.gameData!['current_turn'] == playerData['id'];
      bool isTossWinner = gameCon.gameData!['toss_winner_id']==playerData['id'] && gameCon.gameData!['game_event']['status'] == 3;
      return ContBox(
        clipBehavior: Clip.none,
        width: Sizes.screenWidth / 12,
        padding: const EdgeInsets.all(0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if(gameCon.gameData!['game_event']['status'] == 3 || gameCon.gameData!['game_event']['status'] >= 5)
            Positioned(
              top: -30,
              left: leftSide ? 20 : 10,
              child: ContBox(
                width: Sizes.screenWidth / 12,
                height: Sizes.screenWidth / 15,
                clipBehavior: Clip.none,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: List.generate(playerCard.length, (i) {
                    double left = leftSide ? (10.0 * i) : (-10.0 * i);
                    double top = 8.0 * i;
                    double angle = leftSide ? (0.2 * i) : (-0.2 * i);
                    final card = playerCard[i];
                    return Positioned(
                      left: left,
                      top: top,
                      child: Transform.rotate(
                        angle: angle,
                        child: Transform.flip(
                          child: ContBox(
                            height: Sizes.screenWidth / 20,
                            width: Sizes.screenWidth / 30,
                            color: Colors.black,
                            border:isTossWinner? Border.all(color: Colors.green,width: 3):null,
                            boxShadow: [
                              BoxShadow(
                                  offset: leftSide
                                      ? const Offset(-.5, 0)
                                      : const Offset(0.5, 0),
                                  color: Colors.grey)
                            ],
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: AssetImage(!showCard
                                    ? Assets.diamondsBack
                                    : card['imageUrl']),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            PersonProfile(
              Assets.teenPattiLadyImg,
              isPlayerTurn:
                  isPlayerTurn && gameCon.gameData!['game_event']['status'] > 4,
              isPlaying: playerData['playerStatus'] == 1,
              playerId: playerData['id'],
            ),
            if (gameCon.gameData!['game_event']['status'] > 4)
              Positioned(
                top: -20,
                left: leftSide ? 30 : -12,
                child: CText(
                  playerData['isBlind'] ? "Blind" : "Seen",
                  bgColor: Colors.black.withOpacity(0.5),
                  pad: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  size: Sizes.fontSize6 / 1.1,
                ),
              )
          ],
        ),
      );
    });
  }
}
