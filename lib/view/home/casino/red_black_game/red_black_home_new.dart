import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/view/home/casino/andar_bahar/constant/coins_sign_new.dart';
import 'package:game_on/view/home/casino/andar_bahar/constant/hide_coins.dart';
import 'package:game_on/view/home/casino/dragon_tiger_new/widgets/dragon_tiger_assets.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_help_page.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_loading.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_history.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_bet_view_model.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_result_view_model.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_win_popup_view_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import '../../../../res/components/circular_percent.dart';
import '../../../../res/components/text_widget.dart';
import '../../../../utils/utils.dart';
import '../../lottery/wingo/res/size_const.dart';
import '../../mini/aviator/widget/image_toast.dart';

class RedBlackHomeScreen extends StatefulWidget {
  final String gameId;
  const RedBlackHomeScreen({super.key, required this.gameId});

  @override
  State<RedBlackHomeScreen> createState() => _RedBlackHomeScreenState();
}

class _RedBlackHomeScreenState extends State<RedBlackHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultProvider =
          Provider.of<RedBlackResultViewModel>(context, listen: false);
      resultProvider.rBResultApi(context, 10);
    });
    // TODO: implement initState
    super.initState();
    startCountdown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultProvider =
          Provider.of<RedBlackResultViewModel>(context, listen: false);
      resultProvider.rBResultApi(context, "30");
    });
  }

  final cardFlip = FlipCardController();
  int countdownSeconds = 30;
  Timer? countdownTimer;
  int secondsElapsed = 20;
  Timer? secondTimer;
  bool isRunning = false;
  bool hideButton = false;
  bool firstCome = false;

  void startCountdown() {
    DateTime now = DateTime.now().toUtc();
    int initialSeconds = 60 - now.second; // Calculate initial remaining seconds
    setState(() {
      countdownSeconds = initialSeconds;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI();
    });
  }

  void updateUI() {
    setState(() {
      if (countdownSeconds == 29) {
        print('1');
        wallet =
            double.parse(context.read<ProfileViewModel>().balance.toString());
        _handleFlipCards(countdownSeconds);
        if (firstCome == false) {
          print('2');
        } else {
          ImageToast.show(
              imagePath: Assets.dragontigerStartBetting,
              heights: 100,
              context: context);
          isRunning = true;
          startSecondTimer();
          hideButton = false;
        }
      } else if (countdownSeconds == 15) {
        print('3');
        if (firstCome == false) {
          print('4');
        } else {
          ImageToast.show(
              imagePath: AppAssets.dragontigerStopbetting,
              heights: 100,
              context: context);
          hideButton = true;
        }
      } else if (countdownSeconds == 10) {
        if (firstCome == false) {
          print('5');
        } else {
          if (redCount == 0 &&
              blackCount == 0 &&
              heartCount == 0 &&
              clubCount == 0 &&
              spadeCount == 0 &&
              diamondCount == 0 &&
              jokerCount == 0) {
          } else {
            print('7');
            final betProvider =
                Provider.of<RedBlackBetViewModel>(context, listen: false);
            betProvider.redBlackBet(
              context,
              heartCount.toString(),
              clubCount.toString(),
              spadeCount.toString(),
              diamondCount.toString(),
              redCount.toString(),
              blackCount.toString(),
              jokerCount.toString(),
            );
          }
        }
      } else if (countdownSeconds == 6) {
        if (firstCome == false) {
        } else {
          if (isRunning) {
            final resultProvider =
                Provider.of<RedBlackResultViewModel>(context, listen: false);
            resultProvider.rBResultApi(context, "10");
            resetSecondTimer();
            wallet = double.parse(
                context.read<ProfileViewModel>().balance.toString());
          }
        }
        _handleFlipCards(countdownSeconds);
      } else if (countdownSeconds == 1) {
        final resultProvider =
            Provider.of<RedBlackResultViewModel>(context, listen: false);
        resultProvider.rBResultApi(context, "30");
        countAndCoinClear();
        final popupProvider =
            Provider.of<RedBlackPopUpViewModel>(context, listen: false);
        popupProvider.winAmountRb(context,
            "${resultProvider.sevenResultModel?.data!.first.gamesNo + 1}");
        firstCome = true;
      }
      countdownSeconds = (countdownSeconds - 1) % 30;
    });
  }

  void startSecondTimer() {
    secondTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsElapsed > 0) {
          secondsElapsed--;
        } else {
          secondTimer?.cancel();
        }
      });
    });
  }

  void resetSecondTimer() {
    secondTimer?.cancel();
    setState(() {
      secondsElapsed = 20;
      isRunning = false;
    });
  }

  void _handleFlipCards(int newCountdownSeconds) {
    cardFlip.flipcard();

    countdownSeconds = newCountdownSeconds;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    wallet = double.parse(context.read<ProfileViewModel>().balance.toString());
  }

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return firstCome == false
        ? RedBlackLoading(time: int.parse(countdownSeconds.toString()))
        : Scaffold(
            body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.redBlackImgRedBlackBg),
                      fit: BoxFit.fill)),
              child: Consumer<RedBlackResultViewModel>(
                  builder: (context, rbr, child) {
                return Column(
                  children: [
                    backHelpWidget(),
                    SizedBox(
                      height: height * 0.073,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: height * 0.8,
                          width: width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      Assets.redBlackImgRedBlackBottomBg),
                                  fit: BoxFit.fill)),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.02),
                              walletAnimationWidget(rbr),
                              flipCardWidget(rbr),
                              lastResultWidget(rbr),
                              Sizes.spaceHeight10,
                              SizedBox(
                                height: height * 0.095,
                                width: width * 0.78,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    inkwellYellowCard(1,
                                        Assets.redBlackImgBlankBox, spadeCount),
                                    inkwellYellowCard(2,
                                        Assets.redBlackImgBlankBox, heartCount),
                                    inkwellYellowCard(3,
                                        Assets.redBlackImgBlankBox, clubCount),
                                    inkwellYellowCard(
                                        4,
                                        Assets.redBlackImgBlankBox,
                                        diamondCount),
                                    inkwellYellowCard(5,
                                        Assets.redBlackImgBlankBox, jokerCount),
                                    inkwellYellowCard(6,
                                        Assets.redBlackImgBlankBox, blackCount),
                                    inkwellYellowCard(7,
                                        Assets.redBlackImgBlankBox, redCount),
                                  ],
                                ),
                              ),
                              Sizes.spaceHeight5,
                              SizedBox(
                                height: height * 0.095,
                                width: width * 0.78,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    inkwellYellowCard2(1,
                                        Assets.redBlackImgSpades, spadeCount),
                                    inkwellYellowCard2(2,
                                        Assets.redBlackImgHearts, heartCount),
                                    inkwellYellowCard2(
                                        3, Assets.redBlackImgClubs, clubCount),
                                    inkwellYellowCard2(
                                        4,
                                        Assets.redBlackImgDiamonds,
                                        diamondCount),
                                    inkwellYellowCard2(
                                        5, Assets.redBlackImgKingC, jokerCount),
                                    inkwellYellowCard2(
                                        6,
                                        Assets.redBlackImgSpadesClub,
                                        blackCount),
                                    inkwellYellowCard2(7,
                                        Assets.redBlackImgHeartsDia, redCount),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              userWalletWidget(),
                              betAmountWidget(),
                              Sizes.spaceHeight15,
                            ],
                          ),
                        ),
                        Positioned(
                          top: -51,
                          left: width * 0.21,
                          child: Container(
                            height: height * 0.073,
                            width: width * 0.6,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Assets.redBlackImgRedBlackTitle),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          );
  }

  /// WIDGET SECTION //////////////////////

  Widget backHelpWidget() {
    return SizedBox(
      height: height * 0.035,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            },
            child: Container(
              height: height * 0.075,
              width: width * 0.075,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.andarbaharBack),
                      fit: BoxFit.fill)),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const HelpPopup();
                },
              );
            },
            child: Container(
              height: height * 0.075,
              width: width * 0.075,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.andarbaharIcJackpotInfo),
                      fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }

  Widget walletAnimationWidget(RedBlackResultViewModel rbr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * 0.045,
          width: width * 0.37,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.redBlackImgRupeesSection),
                  fit: BoxFit.fill)),
          child: Center(
            child: textWidget(
              text: "₹ $wallet",
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          height: height * 0.045,
          width: width * 0.4,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.redBlackImgSoundBar),
                  fit: BoxFit.fill)),
          child: Center(
            child: textWidget(
              text: "Period No: "
                  "${rbr.sevenResultModel!.data!.first.gamesNo + 1}",
              color: Colors.white,
              maxLines: 1,
              fontWeight: FontWeight.w900,
              fontSize: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget flipCardWidget(RedBlackResultViewModel rbr) {
    return Container(
      height: height * 0.2,
      width: width * 0.5,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.redBlackImgYellowBox),
              fit: BoxFit.fill)),
      child: Center(
        child: FlipCard(
          rotateSide: RotateSide.bottom,
          controller: cardFlip,
          animationDuration: const Duration(milliseconds: 800),
          axis: FlipAxis.horizontal,
          frontWidget: Image.network(
            rbr.sevenResultModel!.data!.first.randomCard,
            height: height * 0.13,
            fit: BoxFit.fill,
          ),
          backWidget: Stack(children: [
            Image.asset(
              AppAssets.imageFireCard,
              fit: BoxFit.fill,
              height: height * 0.13,
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.045, left: width * 0.05),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(28))),
                child: CircularPercentIndicator(
                  lineWidth: 2,
                  reverse: true,
                  radius: width * 0.044,
                  backgroundColor: Colors.green,
                  progressColor: Colors.grey,
                  percent: double.parse((secondsElapsed / 20).toString()),
                  center: Text(
                    '$secondsElapsed',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget lastResultWidget(RedBlackResultViewModel rbr) {
    return Container(
      height: height * 0.11,
      width: width * 0.75,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.redBlackImgFrameUpperBottomChip),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: rbr.sevenResultModel!.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            rbr.sevenResultModel!.data![index].json2),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  index == 0
                      ? Positioned(
                          top: -2,
                          right: -2,
                          child: Container(
                            height: 15,
                            width: 20,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Assets.redBlackImgNew),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              );
            }),
      ),
    );
  }

  Widget userWalletWidget() {
    return SizedBox(
      height: height * 0.06,
      width: width * 0.79,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: height * 0.043,
            width: width * 0.45,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.redBlackImgBrDo),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                    height: height * 0.036,
                    width: width * 0.3,
                    child: Center(
                      child: Text(
                        wallet.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    )),
                InkWell(
                  onTap: () {
                    final profileProvider =
                        Provider.of<ProfileViewModel>(context, listen: false);
                    profileProvider.profileApi(context);
                    Utils.flushBarSuccessMessage(
                        "Wallet refresh successfully", context, Colors.green);
                  },
                  child: Container(
                    height: height * 0.03,
                    width: width * 0.06,
                    margin: EdgeInsets.only(left: width * 0.04),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.imagesReload),
                            fit: BoxFit.fill)),
                  ),
                ),
              ],
            ),
            // color: Colors.red,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const RedBlackGameHistoryScreen(),
                      type: PageTransitionType.topToBottom,
                      duration: const Duration(milliseconds: 500)));
            },
            child: Container(
              height: height * 0.04,
              width: height * 0.045,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(Assets.headTailBetHistory),
                fit: BoxFit.fill,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget betAmountWidget() {
    return SizedBox(
      height: height * 0.08,
      width: width * 0.78,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          return hideButton == true
              ? HideCoins(list[index])
              : InkWell(
                  onTap: () async {
                    wallet == null
                        ? Utils.flushBarErrorMessage(
                            'Please Recharge', context, Colors.red)
                        : wallet! < list[index]
                            ? Utils.flushBarErrorMessage(
                                'Low Balance', context, Colors.red)
                            : Future.delayed(Duration.zero, () {
                                if (selectedCart == 1) {
                                  CoindesignNew(list[index]);
                                } else if (selectedCart == 2) {
                                  CoindesignNew(list[index]);
                                } else if (selectedCart == 3) {
                                  CoindesignNew(list[index]);
                                } else if (selectedCart == 4) {
                                  CoindesignNew(list[index]);
                                } else if (selectedCart == 5) {
                                  CoindesignNew(list[index]);
                                } else {
                                  CoindesignNew(list[index]);
                                }
                                setState(() {
                                  if (selectedCart == 1) {
                                    spadeCount = spadeCount + list[index];
                                  } else if (selectedCart == 2) {
                                    heartCount = heartCount + list[index];
                                  } else if (selectedCart == 3) {
                                    clubCount = clubCount + list[index];
                                  } else if (selectedCart == 4) {
                                    diamondCount = diamondCount + list[index];
                                  } else if (selectedCart == 5) {
                                    jokerCount = jokerCount + list[index];
                                  } else if (selectedCart == 6) {
                                    blackCount = blackCount + list[index];
                                  } else {
                                    redCount = redCount + list[index];
                                  }
                                });
                              });
                    deductAmount(list[index]);

                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.only(
                      bottom: selectedIndex == index ? 20.0 : 0.0,
                    ),
                    child: CoindesignNew(list[index]),
                  ),
                );
        },
      ),
    );
  }

  Widget inkwellYellowCard(int value, String images, int count) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCart = value;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: height * 0.08,
        width: width * 0.103,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1.2,
              color: selectedCart == value
                  ? Colors.deepOrange
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(6),
            image:
                DecorationImage(image: AssetImage(images), fit: BoxFit.fill)),
        child: Text(
          count != 0 ? "₹${count.toString()}" : "0",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget inkwellYellowCard2(int value, String images, int count) {
    return Container(
      alignment: Alignment.center,
      height: height * 0.08,
      width: width * 0.103,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color:
                selectedCart == value ? Colors.deepOrange : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(image: AssetImage(images), fit: BoxFit.fill)),
    );
  }

  int selectedCart = 0;

  dynamic wallet = 0;
  int heartCount = 0;
  int spadeCount = 0;
  int diamondCount = 0;
  int clubCount = 0;
  int jokerCount = 0;
  int blackCount = 0;
  int redCount = 0;
  void countAndCoinClear() {
    setState(() {
      heartCount = 0;
      spadeCount = 0;
      diamondCount = 0;
      clubCount = 0;
      jokerCount = 0;
      blackCount = 0;
      redCount = 0;
      selectedCart = 0;
    });
  }

  void deductAmount(int amountToDeduct) {
    if (wallet! >= amountToDeduct) {
      setState(() {
        wallet = (wallet! - amountToDeduct).toInt();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.red);
      // Handle insufficient funds scenario, e.g., show a message to the user
    }
  }

  List<int> list = [1, 5, 10, 50, 100, 500, 1000];

  @override
  void dispose() {
    if (secondTimer!.isActive) {
      secondTimer!.cancel();
    }
    // countdownSeconds.cancel();
    super.dispose();
  }
}
