
import '../../../../../../material_imports.dart';

class GameHistoryDataViewList extends StatelessWidget {
  final dynamic players;
  const GameHistoryDataViewList({super.key, this.players});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: players.length,
      itemBuilder: (ctx, int i) {
        final playerData = players[i];
        return ContBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                playerData['name'].toUpperCase(),
                size: Sizes.fontSize8,
                width: Sizes.screenWidth / 6,
              ),
              ContBox(
                width: Sizes.screenWidth / 6,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: List.generate(playerData['hand'].length, (index) {
                    final playerCard = playerData['hand'][index]['imageUrl'];
                    return ContBox(
                      margin: const EdgeInsets.only(left: 5),
                      height: 40,
                      width: 30,
                      radius: 3,
                      image: DecorationImage(
                          image: AssetImage(playerCard), fit: BoxFit.fill),
                    );
                  }),
                ),
              ),
              CText(
                  width: Sizes.screenWidth / 3,
                  playerStatus(
                    playerData['playerStatus'],
                  )),
              CText(
                width: Sizes.screenWidth / 6,
                playerData['playerStatus'] == 5 ? "Winner" : "Looser",
                color:
                    playerData['playerStatus'] == 5 ? Colors.green : Colors.red,
                weight: FontWeight.bold,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (ctx, int index) => const Divider(
        color: Colors.blueGrey,
        thickness: 1.0,
      ),
    );
  }

  String playerStatus(int status) {
    switch (status) {
      case 2:
        return 'Player left the game';
      case 3:
        return 'Player time out';
      case 4:
        return 'Player make slide show and loss';
      case 5:
        return 'Player won the game';
      default:
        return 'status not found';
    }
  }
}
