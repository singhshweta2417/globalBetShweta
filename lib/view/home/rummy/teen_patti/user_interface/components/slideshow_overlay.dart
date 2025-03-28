import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:provider/provider.dart';
import '../../../../../../material_imports.dart';

class SlideshowOverlay extends StatelessWidget {
  const SlideshowOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<TeenPattiGameController>(
      builder: (context, gameCon,_) {
        final status = gameCon.gameData!['slide_show']['status'];
        final recieverId = gameCon.gameData!['slide_show']['receiver_player_id'];
        final requesterId = gameCon.gameData!['slide_show']['req_player_id'];
        final winnerData = gameCon.gameData!['slide_show']['winner_data'];
        bool isWinnerDecided = status == 4 && winnerData != null;
        bool hasSlideShowReq = (status >= 1 && status < 5 && status != 3) &&
            recieverId == gameCon.currentUserData!.id;
        bool hasSlideShow = (status >= 2 && status < 5 && status != 3) &&
            requesterId == gameCon.currentUserData!.id;
        if (hasSlideShowReq || hasSlideShow) {
          return Positioned(
            top: isWinnerDecided
                ? -Sizes.screenHeight / 2.5
                : -Sizes.screenHeight / 10,
            child: ContBox(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black54,
                    spreadRadius: 3,
                    blurRadius: 8)
              ],
              radius: 5,
              gradient: const LinearGradient(colors: [
                Color(0xffD4145A),
                Color(0xffFBB03B),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              border: Border.all(color: Colors.black38, width: .5),
              child: status == 1 ? newReq(gameCon) : acceptedReq(gameCon),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }

  Widget newReq(TeenPattiGameController gameCon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CText(
          "Slideshow request!",
          size: Sizes.fontSize8,
          weight: FontWeight.w600,
        ),
        const SizedBox(
          height: 2,
        ),
        CText(
          textAlign: TextAlign.center,
          alignment: Alignment.center,
          "Would you like to accept the slide show\nrequest and compare your cards?",
          size: Sizes.fontSize(7),
          // weight: FontWeight.w600,
        ),
        Sizes.spaceH3,
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CText(
              onTap: () {
                gameCon.updateSlideShowReq(3);
              },
              "No",
              size: Sizes.fontSize6,
              pad: const EdgeInsets.symmetric(vertical: 3),
              width: Sizes.screenWidth / 12,
              bgColor: Colors.grey,
              alignment: Alignment.center,
            ),
            Sizes.spaceW5,
            CText(
              onTap: () {
                gameCon.updateSlideShowReq(2);
              },
              "Yes",
              size: Sizes.fontSize6,
              pad: const EdgeInsets.symmetric(vertical: 3),
              width: Sizes.screenWidth / 12,
              bgColor: Colors.green,
              alignment: Alignment.center,
            ),
          ],
        )
      ],
    );
  }

  Widget acceptedReq(TeenPattiGameController gameCon) {
    final status = gameCon.gameData!['slide_show']['status'];
    final recieverId = gameCon.gameData!['slide_show']['receiver_player_id'];
    final requesterId = gameCon.gameData!['slide_show']['req_player_id'];
    final winnerData = gameCon.gameData!['slide_show']['winner_data'];
    bool isWinnerDecided = status == 4 && winnerData != null;
    final otherPlayerId =
    recieverId == gameCon.currentUserData!.id ? requesterId : recieverId;
    final mePlayer = gameCon.gameData!['players']
        .firstWhere((e) => e['id'] == gameCon.currentUserData!.id);
    final otherOne = gameCon.gameData!['players']
        .firstWhere((e) => e['id'] == otherPlayerId);
    bool meWinner =
        isWinnerDecided && winnerData['player_id'] == mePlayer['id'];
    return Column(
      children: [
        CText(
          isWinnerDecided ? "Slideshow result" : "Comparing Card",
          weight: FontWeight.bold,
        ),
        Sizes.spaceH5,
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  "My cards:",
                  size: Sizes.fontSize6,
                ),
                Sizes.spaceH3,
                comparingCardList(mePlayer['hand'], meWinner),
              ],
            ),
            Sizes.spaceW5,
            const CText(
              "Vs",
              weight: FontWeight.bold,
            ),
            Sizes.spaceW5,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  "Opponents cards:",
                  size: Sizes.fontSize6,
                ),
                Sizes.spaceH3,
                comparingCardList(otherOne['hand'], !meWinner),
              ],
            ),
          ],
        ),
        Sizes.spaceH5,
        if (isWinnerDecided) ...[
          Sizes.spaceH5,
          CText(
            pad: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            meWinner ? 'Congratulations! 🎉 You' : 'Bad luck Your opponent',
            weight: FontWeight.bold,
            bgColor: meWinner ? Colors.green : Colors.red,
          ),
          Sizes.spaceH3,
          CText(
            " have won with a mighty ${winnerData['rank_name']}!",
            weight: FontWeight.w600,
          ),
        ]
      ],
    );
  }
  Widget comparingCardList(dynamic playerCards, bool isWinner) {
    return ContBox(
      border: Border.all(
        color: isWinner ? Colors.green : Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: List.generate(playerCards.length, (index) {
          final playerCard = playerCards[index]['imageUrl'];
          return ContBox(
            margin: const EdgeInsets.only(right: 5),
            height: 40,
            width: 30,
            radius: 3,
            image: DecorationImage(
                image: AssetImage(playerCard), fit: BoxFit.fill),
          );
        }),
      ),
    );
  }

}
