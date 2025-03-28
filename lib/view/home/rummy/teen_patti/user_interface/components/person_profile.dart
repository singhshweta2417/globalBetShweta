import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:provider/provider.dart';
import '../../../../../../material_imports.dart';
import '../../../../../../res/components/circular_percent.dart';

class PersonProfile extends StatelessWidget {
  final String image;
  final bool isPlayerTurn;
  final bool isPlaying;
  final String playerId;
  const PersonProfile(this.image,
      {super.key,
      this.isPlayerTurn = false,
      this.isPlaying = true,
      required this.playerId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      final status =gameCon.gameData!['game_event']['status']>=4? gameCon.gameData!['slide_show']['status']:0;
      final recieverId =gameCon.gameData!['game_event']['status']>=4? gameCon.gameData!['slide_show']['receiver_player_id']:'';
      final requesterId =gameCon.gameData!['game_event']['status']>=4? gameCon.gameData!['slide_show']['req_player_id']:'';
      final slideShowStatus =
          (playerId == recieverId || playerId == requesterId) && status == 1
              ? 1
              : (playerId == recieverId || playerId == requesterId) &&
                      status >= 1 &&
                      status < 5
                  ? 2
                  : 0;
      bool isTossWinner = gameCon.gameData!['toss_winner_id']==playerId && gameCon.gameData!['game_event']['status'] == 3;

      return ContBox(
        shape: BoxShape.circle,
        height: Sizes.screenWidth / 18,
        width: Sizes.screenWidth / 18,
        color: Colors.grey,
        border: Border.all(
            color:isTossWinner?Colors.green:slideShowStatus == 1
                ? Colors.red
                : slideShowStatus == 2
                    ? Colors.blue
                    : isPlayerTurn
                        ? Colors.green
                        : !isPlaying
                            ? Colors.black
                            : Colors.white,
            width: slideShowStatus == 1 || slideShowStatus == 2 || isPlayerTurn
                ? 2
                : 1),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        child: isPlayerTurn
            ? CircularPercentIndicator(
                radius: Sizes.screenWidth / 40,
                lineWidth: Sizes.screenWidth / 40,
                percent: gameCon.gameData!['game_timer']['timeLeft'] / 60,
                reverse: true,
                backgroundColor: Colors.transparent,
                progressColor: Colors.green.withOpacity(0.7),
              )
            : !isPlaying
                ? ContBox(
                    shape: BoxShape.circle,
                    height: Sizes.screenWidth / 15,
                    width: Sizes.screenWidth / 15,
                    color: const Color.fromRGBO(0, 1, 2, 0.5),
                  )
                : null,
      );
    });
  }
}
