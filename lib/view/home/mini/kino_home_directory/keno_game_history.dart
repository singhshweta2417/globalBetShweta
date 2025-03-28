import 'package:flutter/material.dart';
import 'package:game_on/main.dart';
import 'package:game_on/view/home/mini/kino_home_directory/api/kino_bet_history_api.dart';
import 'package:provider/provider.dart';


class KinoGameHistory extends StatefulWidget {
  const KinoGameHistory({super.key});

  @override
  State<KinoGameHistory> createState() => _KinoGameHistoryState();
}

class _KinoGameHistoryState extends State<KinoGameHistory> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<KinoGameHistoryApi>(context, listen: false).resultFetchGames();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KinoGameHistoryApi>(
      builder: (context, gameHistoryData, child) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding:  const EdgeInsets.only(top: 38, right: 10, left: 10),
              child: Container(
                height: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade900,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Game history',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade800,
                              ),
                              child: const Icon(
                                Icons.cancel_outlined,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          SizedBox(
                            width: width*0.15,
                            child: const Text(
                              'S.no',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Text(
                            'Risk',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Bet/Amount',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Win Amount',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.2),
                      Expanded(
                        child: gameHistoryData.response.isNotEmpty
                            ? ListView.builder(
                          itemCount: gameHistoryData.response.length,
                          itemBuilder: (context, index) {
                            final gameResponse = gameHistoryData.response[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width*0.19,
                                    child: Text(
                                      gameResponse.gamesno.toString(),
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Container(
                                    width: width*0.1,
                                    margin: EdgeInsets.only(left: width*0.047),
                                    child: Center(
                                      child: Text(
                                        gameResponse.riskLevel == 0
                                            ? "Low"
                                            :  gameResponse.riskLevel == 1
                                            ? "Medium"
                                            : "High",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width*0.12,
                                    margin: EdgeInsets.only(left: width*0.1),
                                    child: Center(
                                      child: Text(
                                        '${gameResponse.amount} INR',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: width*0.093,
                                    margin: EdgeInsets.only(left: width*0.21),

                                    child: Center(
                                      child: Text(
                                        gameResponse.winAmount?.toString() ?? "0",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                            : const Center(
                          child: Text(
                            'No game history found',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
