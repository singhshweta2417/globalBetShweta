import 'package:flutter/cupertino.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/game_history_data_view.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:provider/provider.dart';
import '../../../../../../material_imports.dart';

class SummaryScreenActivity extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final String? roomCode;
  const SummaryScreenActivity(
      {super.key, required this.gameData, this.roomCode});

  @override
  State<SummaryScreenActivity> createState() => _SummaryScreenActivityState();
}

class _SummaryScreenActivityState extends State<SummaryScreenActivity> {
  @override
  void initState() {
    Provider.of<TeenPattiGameController>(context, listen: false).stopListeningToGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: (){
            Provider.of<TeenPattiGameController>(context, listen: false).leaveTable(context);
          }, child:const Icon(CupertinoIcons.home)),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const CText('Game summary!'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight * 1.5),
            child: ContBox(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.roomCode != null)
                        CText(
                          "Room code: ${widget.roomCode}",
                          size: Sizes.fontSize6,
                        ),
                      CText(
                        "Table type: ${widget.gameData['game_specification']['table_type']} player",
                        size: Sizes.fontSize6,
                      ),
                    ],
                  ),
                  Sizes.spaceH20,
                  ContBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(
                          width: Sizes.screenWidth / 6,
                          "Player name",
                          color: Colors.grey,
                          size: Sizes.fontSize6,
                        ),
                        CText(
                          width: Sizes.screenWidth / 6,
                          "Player cards",
                          color: Colors.grey,
                          size: Sizes.fontSize8,
                        ),
                        CText(
                          width: Sizes.screenWidth / 3,
                          "Description",
                          color: Colors.grey,
                          size: Sizes.fontSize8,
                        ),
                        CText(
                          width: Sizes.screenWidth / 6,
                          "Status",
                          color: Colors.grey,
                          size: Sizes.fontSize8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
      body: GameHistoryDataViewList(players: widget.gameData['players'],),
    );
  }
}
