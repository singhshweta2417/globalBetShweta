import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/res/orientation.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/controller/controller.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/font_size.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/sound.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/stroke_text.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view/widget/exit_game.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view/widget/timer.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view/widget/titli_history.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view/widget/titli_result.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/bet_view_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/get_amount_view_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view_model/result_view_model.dart';
import 'package:provider/provider.dart';

class TitliHomeScreen extends StatefulWidget {
  const TitliHomeScreen({super.key});

  @override
  State<TitliHomeScreen> createState() => _TitliHomeScreenState();
}

class _TitliHomeScreenState extends State<TitliHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OrientationLandscapeUtil.setLandscapeOrientation();
      final resTimer = Provider.of<TitliController>(context, listen: false);
      resTimer.connectToServer(context);
      final result = Provider.of<ResultViewModel>(context, listen: false);
      result.resultApi(context);
      final getAmountProvider =
          Provider.of<GetAmountViewModel>(context, listen: false);
      getAmountProvider.getAmountApi(
          context, "${result.resultModel!.data!.first.gamesNo + 1}".toString());
      print("${result.resultModel!.data!.first.gamesNo + 1}".toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    final tc = Provider.of<TitliController>(context);
    final profile = Provider.of<ProfileViewModel>(context);
    final betViewModel = Provider.of<BetViewModel>(context);
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return ExitTitliGame();
          },
        );
      },
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.titliBg), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height * 0.05,
                      width: width * 0.13,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.titliBalnce),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextConst(
                            textAlign: TextAlign.center,
                            title: "BALANCE: ₹${profile.balance}",
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                          InkWell(
                              onTap: () {
                                Utils.flushBarSuccessMessage(
                                    "Wallet Refresh Successfully",
                                    context,
                                    AppColors.white);
                                final profile = Provider.of<ProfileViewModel>(
                                    context,
                                    listen: false);
                                profile.profileApi(context);
                              },
                              child: const Icon(
                                Icons.refresh,
                                color: AppColors.white,
                                size: 15,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.4,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.titliBalnce),
                              fit: BoxFit.fill)),
                      child: TextConst(
                        textAlign: TextAlign.center,
                        title: tc.timerStatus == 1 && tc.timerBetTime == 75
                            ? "No more Play"
                            : tc.timerStatus == 1 &&
                                    (tc.timerBetTime <= 10 &&
                                        tc.timerBetTime >= 1)
                                ? "Bet Successfully Placed!"
                                : tc.timerStatus == 2
                                    ? "Result Announcement"
                                    : "Place Your Chips",
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: tc.timerStatus == 1 && tc.timerBetTime == 75
                            ? AppColors.green
                            : tc.timerStatus == 1 &&
                                    (tc.timerBetTime <= 10 &&
                                        tc.timerBetTime >= 1)
                                ? AppColors.green
                                : tc.timerStatus == 2
                                    ? AppColors.green
                                    : AppColors.green,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playTTSMessage(
                            "Are you sure you want to exit this game");
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return const ExitTitliGame();
                          },
                        );
                      },
                      child: Container(
                        height: height * 0.053,
                        width: width * 0.028,
                        margin: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.titliCancel),
                                fit: BoxFit.fill)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: height * 0.55,
                width: double.infinity, // Full width
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.titliBoard),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.07,
                      left: width * 0.14,
                      right: width * 0.14),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 1,
                    children: List.generate(tc.cardList.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (tc.addTitliBets.isEmpty && tc.resetOne == true) {
                            tc.setResetOne(false);
                          }
                          if (kDebugMode) {
                            print(tc.cardList[index].id);
                            print(tc.selectedValue);
                          }
                          tc.titliAddBet(tc.cardList[index].id,
                              tc.selectedValue, index, context);
                        },
                        child: Stack(
                          // clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  alignment: Alignment.center,
                                  width: (width*0.5) / 6,
                                  height: (height * 0.4) / 2.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage(tc.cardList[index].image),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(1),
                                  height: height * 0.025,
                                  width: width * 0.08,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    children: tc.addTitliBets
                                            .where((value) =>
                                                value['number'] ==
                                                tc.cardList[index].id)
                                            .isNotEmpty
                                        ? tc.addTitliBets
                                            .where((e) =>
                                                e['number'] ==
                                                tc.cardList[index].id)
                                            .map((bet) {
                                            return Positioned(
                                              bottom: 2.0 *
                                                  tc.addTitliBets.indexOf(bet),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: height * 0.1,
                                                width: height * 0.1,
                                                decoration: getBoxDecoration(
                                                    bet["amount"]!),
                                                child: Text(
                                                  bet["amount"].toString(),
                                                  style: TextStyle(
                                                    fontSize: bet["amount"]
                                                                .toString()
                                                                .length <
                                                            3
                                                        ? 8
                                                        : 7,
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList()
                                        : [Container()], // Empty state
                                  ),
                                ),
                              ],
                            ),

                            if (tc.isSparkling &&
                                tc.winningItem == tc.cardList[index].id)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.yellow, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.yellow
                                            .withAlpha((244 * 0.5).toInt()),
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            // Winning Effect - Solid Highlight
                            if (!tc.isSparkling &&
                                tc.winningItem == tc.cardList[index].id)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.yellow, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.yellow
                                            .withAlpha((244 * 0.5).toInt()),
                                        blurRadius: 20,
                                        spreadRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const TitliResultScreen(),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    height: height * 0.2,
                    child: const Column(
                      children: [
                        Spacer(),
                        TimerScreen(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2,
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Audio.playSpinMusic(Assets.musicPlacechip);
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const TitliHistoryPage();
                                  },
                                );
                              },
                              child: Image.asset(
                                Assets.titliInfoIcon,
                                height: height * 0.06,
                              ),
                            ),
                            SizedBox(width: width * 0.02),
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    betViewModel.titliBetApi(
                                        tc.addTitliBets, context);
                                    Audio.playSpinMusic(Assets.musicPlacechip);
                                    if (kDebugMode) {
                                      print(tc.addTitliBets);
                                      print("addTitliBets");
                                    }
                                  },
                                  child: Container(
                                    height: height * 0.08,
                                    width: width * 0.12,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Assets.titliBet),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                if (tc.addTitliBets.isEmpty &&
                                    (tc.timerStatus == 2 ||
                                        (tc.timerStatus == 1 &&
                                            tc.timerBetTime <= 10 &&
                                            tc.timerBetTime >= 0)))
                                  shadowContainer(context),
                              ],
                            ),
                            spaceWidth25,
                            Container(
                              height: height * 0.08,
                              width: width * 0.12,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Assets.titliButton),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const StrokeText(
                                textAlign: TextAlign.center,
                                text: "Claim",
                                fontSize: 12,
                                strokeWidth: 1,
                                textColor: AppColors.white,
                              ),
                            )
                          ],
                        ),
                        spaceHeight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            spaceWidth10,
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (tc.addTitliBets.isNotEmpty) {
                                      tc.placeBet(tc.addTitliBets,
                                          context); // Place the bet
                                      print("Bet placed");
                                      Audio.playSpinMusic(
                                          Assets.musicPlacechip);
                                    } else {
                                      Utils.flushBarSuccessMessage(
                                          "No Previous bet placed to be rebet",
                                          context,
                                          AppColors.white);
                                    }
                                    // Play sound
                                  },
                                  child: Container(
                                    height: height * 0.08,
                                    width: width * 0.12,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Assets.titliRepeat),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                if (tc.addTitliBets.isEmpty &&
                                    (tc.timerStatus == 2 ||
                                        (tc.timerStatus == 1 &&
                                            tc.timerBetTime <= 10 &&
                                            tc.timerBetTime >= 0)))
                                  shadowContainer(context)
                              ],
                            ),
                            SizedBox(width: width * 0.02),
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (tc.addTitliBets.isNotEmpty) {
                                      tc.doubleUpBet(
                                          context); // Double the bet and place it
                                      print("Double Up triggered");
                                      Audio.playSpinMusic(
                                          Assets.musicPlacechip);
                                    } else {
                                      Utils.flushBarSuccessMessage(
                                          "No Previous Bet Placed to be Double Up",
                                          context,
                                          AppColors.white);
                                    }
                                  },
                                  child: Container(
                                    height: height * 0.08,
                                    width: width * 0.12,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Assets.titliDoubleUp),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                if (tc.addTitliBets.isEmpty &&
                                    (tc.timerStatus == 2 ||
                                        (tc.timerStatus == 1 &&
                                            tc.timerBetTime <= 10 &&
                                            tc.timerBetTime >= 0)))
                                  shadowContainer(context)
                              ],
                            ),
                            SizedBox(width: width * 0.02),
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (tc.addTitliBets.isNotEmpty) {
                                      tc.clearAllBet(context);
                                      Audio.playSpinMusic(
                                          Assets.musicPlacechip);
                                    }
                                  },
                                  child: Container(
                                    height: height * 0.08,
                                    width: width * 0.12,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Assets.titliClear),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                if (tc.addTitliBets.isEmpty &&
                                    (tc.timerStatus == 2 ||
                                        (tc.timerStatus == 1 &&
                                            tc.timerBetTime <= 10 &&
                                            tc.timerBetTime >= 0)))
                                  shadowContainer(context)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration getBoxDecoration(int amount) {
  String assetName;

  if (amount >= 1 && amount < 2) {
    assetName = Assets.titliChip1;
  } else if (amount >= 2 && amount < 5) {
    assetName = Assets.titliChip2;
  } else if (amount >= 5 && amount < 10) {
    assetName = Assets.titliChip3;
  } else if (amount >= 10 && amount < 100) {
    assetName = Assets.titliChip4;
  } else if (amount >= 100 && amount < 500) {
    assetName = Assets.titliChip5;
  } else if (amount >= 500 && amount < 1000) {
    assetName = Assets.titliChip6;
  } else {
    assetName = Assets.titliChip7;
  }

  return BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(image: AssetImage(assetName), fit: BoxFit.fill),
  );
}

Widget shadowContainer(context) {
  final  height = MediaQuery.of(context).size.height;
  final  width = MediaQuery.of(context).size.width;
  return Container(
    height: height * 0.06,
    width: width * 0.12,
    decoration: BoxDecoration(
        color: Colors.black.withAlpha((244 * 0.5).toInt()),
        borderRadius: BorderRadius.circular(5)),
  );
}

Future<void> playTTSMessage(String message) async {
  // Initialize FlutterTTS
  FlutterTts flutterTts = FlutterTts();

  // Set TTS options
  await flutterTts.setLanguage("en-US");
  await flutterTts.setSpeechRate(0.5);

  // Speak the message
  var result = await flutterTts.speak(message);

  if (result == 1) {
    if (kDebugMode) {
      print("TTS playback started.");
    }
  } else {
    if (kDebugMode) {
      print("Error playing TTS.");
    }
  }
}
