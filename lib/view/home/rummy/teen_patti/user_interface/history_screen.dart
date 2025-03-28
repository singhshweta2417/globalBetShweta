import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/game_history_data_view.dart';
import 'package:provider/provider.dart';
import '../../../../../material_imports.dart';
import '../view_model/service/game_services.dart';

class HistoryScreenActivity extends StatefulWidget {
  const HistoryScreenActivity({super.key});

  @override
  State<HistoryScreenActivity> createState() => _HistoryScreenActivityState();
}

class _HistoryScreenActivityState extends State<HistoryScreenActivity> {
  @override
  void initState() {
    Provider.of<TeenPattiGameController>(context, listen: false)
        .getGameHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const CText("Game History"),
      ),
      body: Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
        if (gameCon.gameHistory == null) {
          return const CText("History not found");
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: gameCon.gameHistory!.length,
            itemBuilder: (ctx, int index) {
              final data = gameCon.gameHistory![index];
              return ContBox(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                border: Border.all(color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText("Date: ${data['id']}"),
                        CText("Time: ${data['timestamp']}"),
                      ],
                    ),
                    GameHistoryDataViewList(
                      players: data['data']['players'],
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
