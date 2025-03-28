import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/casino/lucky_card_16/view_model/lucky_16_history_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_16/widgets/lucky_16_btn.dart';
import 'package:provider/provider.dart';

class Lucky16InfoD extends StatefulWidget {
  const Lucky16InfoD({
    super.key,
  });

  @override
  State<Lucky16InfoD> createState() => _Lucky16InfoDState();
}

class _Lucky16InfoDState extends State<Lucky16InfoD> {

  bool selectedBtn = true;
  @override
  void initState() {
    final lucky16HistoryViewModel =
    Provider.of<Lucky16HistoryViewModel>(context, listen: false);
    lucky16HistoryViewModel.lucky16HistoryApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage(Assets.lucky12InfoBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.08,
                  width: height * 0.08,
                  color: Colors.transparent,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBtn = true;
                        });
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.18,
                        alignment: Alignment.center,
                        color: const Color(0xff40183a),
                        child: const Text(
                          'GAME HISTORY',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'roboto_bl'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBtn = false;
                        });
                      },
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.2,
                        alignment: Alignment.center,
                        color: const Color(0xff40183a),
                        child: const Text(
                          'REPORT DETAILS',
                          style: TextStyle(
                              fontFamily: 'roboto_bl',
                              color: Color(0xfffffbfb),
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height * 0.08,
                    width: height * 0.08,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Assets.lucky12Close),
                          fit: BoxFit.fill),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                child: selectedBtn ? const GameHistory() : const ReportDetails(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GameHistory extends StatefulWidget {
  const GameHistory({super.key});

  @override
  State<GameHistory> createState() => _GameHistoryState();
}

class _GameHistoryState extends State<GameHistory> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final l16hvm = Provider.of<Lucky16HistoryViewModel>(context);
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              commonWidget('S.No', height * 0.2),
              commonWidget('GAME ID', height * 0.45),
              commonWidget('PLAY', height * 0.2),
              commonWidget('WIN', height * 0.2),
            ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: l16hvm.lucky16HistoryModel!=null?List.generate(
              l16hvm.lucky16HistoryModel!.data!.length,
                  (index) {
                return l16hvm.lucky16HistoryModel!.data!.isNotEmpty?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      commonWidget('${index+1}', height * 0.2,
                          fotSize: 20
                      ),
                      commonWidget('${l16hvm.lucky16HistoryModel!.data![index].periodNo}', height * 0.45,
                          fotSize: 20
                      ),
                      commonWidget('${l16hvm.lucky16HistoryModel!.data![index].amount}', height * 0.2,
                          fotSize: 20
                      ),
                      commonWidget('${l16hvm.lucky16HistoryModel!.data![index].winAmount}', height * 0.2,
                          fotSize: 20
                      ),
                    ]):Container(); // Replace with your actual widget
              }):[],
        ),
      ],
    );
  }

  Widget commonWidget(String title, double width, {double? fotSize}) {
    return Container(
        alignment: Alignment.center,
        width: width,
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'roboto',
              fontSize: fotSize ?? 18,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        ));
  }
}

class ReportDetails extends StatefulWidget {
  const ReportDetails({super.key});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Row(
            children: [
              commonWidget('FROM',width * 0.08),
              commonWidget('23/9/2024',width * 0.08),
              const SizedBox(width: 10),
              Image.asset(Assets.lucky12InfoCallIcon,scale: 1.5)
            ],
          ),
              const SizedBox(width: 50),
          Row(
            children: [
              commonWidget('FROM',width * 0.08),
              commonWidget('23/9/2024',width * 0.08),
              const SizedBox(width: 10),
              Image.asset(Assets.lucky12InfoCallIcon,scale: 1.5),
              const SizedBox(width: 30),
              Lucky16Btn(
                title: 'VIEW',
                fontSize: 10,
                heights: 18,
                onTap: () {  },

              )
            ],
          ),

        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              commonWidget('NAME', width * 0.1),
              commonWidget('PLAY', width * 0.08),
              commonWidget('WIN', width * 0.08),
              commonWidget('CLAIM', width * 0.08),
              commonWidget('UNCLAIMED', width * 0.08),
              commonWidget('END', width *  0.08),
              commonWidget('COMM', width *  0.08),
              commonWidget('NTP', width * 0.08),
            ]),
      ],
    );
  }

  Widget commonWidget(String title, double width, {double? fotSize}) {
    return Container(
        alignment: Alignment.center,
        // color: Colors.red,
        width: width,
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'roboto',
              fontSize: fotSize ?? 10,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        ));
  }
}