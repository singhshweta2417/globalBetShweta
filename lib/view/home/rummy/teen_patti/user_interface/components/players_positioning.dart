import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/player_profile_with_card.dart';
import 'package:provider/provider.dart';

import '../../../../../../material_imports.dart';
import '../../view_model/service/card_throw_animaton.dart';
import '../../view_model/service/game_services.dart';

class PlayerPositioning extends StatefulWidget {
  const PlayerPositioning({
    super.key,
  });

  @override
  State<PlayerPositioning> createState() => _PlayerPositioningState();
}

class _PlayerPositioningState extends State<PlayerPositioning> {
  @override
  Widget build(BuildContext context) {
    final cardThrow = Provider.of<CardThrowAnimation>(context);
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (gameCon.gameData!['game_event']['status'] < 3 ||
              gameCon.gameData!['game_event']['status'] == 4) ...[
            AnimatedBuilder(
              animation: cardThrow.controller!,
              builder: (context, child) {
                return Positioned(
                  left: cardThrow.animation!.value.dx,
                  top: cardThrow.animation!.value.dy,
                  child: cardImage(Assets.diamondsBack),
                );
              },
            ),

            // **Placed cards appearing near player**
            for (int i = 0; i < cardThrow.distributedCards.length; i++)
              for (int j = 0; j < cardThrow.distributedCards[i].length; j++)
                Positioned(
                  left: cardThrow.distributedCards[i][j].dx,
                  top: cardThrow.distributedCards[i][j].dy,
                  child: cardImage(Assets.diamondsBack),
                ),
          ],
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: _buildPlayerPositions(gameCon, cardThrow),
          ),
        ],
      );
    });
  }

  List<Widget> _buildPlayerPositions(
      TeenPattiGameController gameCon, CardThrowAnimation throwCard) {
    final otherPlayer = gameCon.gameData!['players']
        .where((e) => e['id'] != gameCon.currentUserData!.id)
        .toList();
    if (otherPlayer.length == 2) {
      return _threePlayerLayout(gameCon, throwCard);
    } else if (otherPlayer.length == 4) {
      return _fivePlayerLayout(gameCon, throwCard);
    } else {
      return [];
    }
  }

  /// Layout for 3 Players
  List<Widget> _threePlayerLayout(
      TeenPattiGameController gameCon, CardThrowAnimation throwCard) {
    bool isTossCase = gameCon.gameData!['game_event']['status'] <= 3;

    final otherPlayers = gameCon.gameData!['players']
        .where((e) => e['id'] != gameCon.currentUserData!.id)
        .toList();
    return [
      Positioned(
        bottom: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
            ? Sizes.screenHeight / 5.5
            : Sizes.screenHeight / 7,
        child: ContBox(
          width: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
              ? Sizes.screenWidth / 1.05
              : Sizes.screenWidth / 1.6,
          height: Sizes.screenHeight / 10,
          clipBehavior: Clip.none,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayerProfileWithCard(
                playerData: otherPlayers[0],
              ),
              PlayerProfileWithCard(
                leftSide: false,
                playerData: otherPlayers[1],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  /// Layout for 5 Players
  List<Widget> _fivePlayerLayout(
      TeenPattiGameController gameCon, CardThrowAnimation throwCard) {
    final otherPlayers = gameCon.gameData!['players']
        .where((e) => e['id'] != gameCon.currentUserData!.id)
        .toList();
    return [
      Positioned(
        bottom: Sizes.screenHeight / 2.8,
        child: ContBox(
          width: Sizes.screenWidth / 1.55,
          height: Sizes.screenHeight / 5,
          clipBehavior: Clip.none,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayerProfileWithCard(
                playerData: otherPlayers[0],
              ),
              PlayerProfileWithCard(
                leftSide: false,
                playerData: otherPlayers[1],
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: Sizes.screenHeight / 3.8,
        child: ContBox(
          width: Sizes.screenWidth / 1.25,
          height: Sizes.screenHeight / 5,
          clipBehavior: Clip.none,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayerProfileWithCard(
                playerData: otherPlayers![2],
              ),
              PlayerProfileWithCard(
                leftSide: false,
                playerData: otherPlayers![3],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Widget cardImage(String cardImg) {
    return ContBox(
      height: Sizes.screenWidth / 20,
      width: Sizes.screenWidth / 30,
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(image: AssetImage(cardImg)),
    );
  }
}
