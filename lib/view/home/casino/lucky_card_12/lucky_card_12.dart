import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/res/orientation.dart';
import 'package:game_on/view/bottom/bottom_nav_bar.dart';
import 'package:game_on/view/home/casino/lucky_card_12/view_model/lucky_12_result_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/luck_12_exit_pop_up.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_btn.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_coin_list.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_info_d.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_result.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_second_wheel.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_timer.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_top.dart';
import 'package:game_on/view/home/casino/lucky_card_12/widgets/lucky_12_wheel_first.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:provider/provider.dart';
import 'controller/lucky_12_controller.dart';

class LuckyCard12 extends StatefulWidget {
  const LuckyCard12({super.key});

  @override
  State<LuckyCard12> createState() => _LuckyCard12State();
}

class _LuckyCard12State extends State<LuckyCard12> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OrientationLandscapeUtil.setLandscapeOrientation();
      final resTimer = Provider.of<Lucky12Controller>(context, listen: false);
      resTimer.connectToServer(context);
      final lucky12ResultViewModel =
          Provider.of<Lucky12ResultViewModel>(context, listen: false);
      lucky12ResultViewModel.lucky12ResultApi(context, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final lucky12ResultViewModel = Provider.of<Lucky12ResultViewModel>(context);
    return Consumer<Lucky12Controller>(builder: (context, l12c, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (BuildContext context) {
              return Luck12ExitPopUp(
                yes: () {
                  // exit pop up
                  OrientationPortraitUtil.setPortraitOrientation();
                  FeedbackProvider.navigateToHome(context);
                  l12c.disConnectToServer(context);
                  // Navigator.pushReplacementNamed(context, RoutesName.dashboard);
                },
              );
            },
          );
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.lucky16LuckyBg),
                        fit: BoxFit.fill)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      width: width * 0.5,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: width * 0.32,
                                    width: width * 0.32,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                      image:
                                          AssetImage(Assets.lucky16LWheelBgOne),
                                      fit: BoxFit.fill,
                                    )),
                                  ),
                                  Lucky12WheelFirst(
                                    controller: l12c,
                                    pathImage: Assets.lucky12L12FirstWheel,
                                    withWheel: width * 0.289,
                                    pieces: 12,
                                  ),
                                  Lucky12SecondWheel(
                                    controller: l12c,
                                    pathImage: Assets.lucky12L12SecondWheel,
                                    withWheel: width * 0.2,
                                    pieces: 12,
                                  ),
                                  Container(
                                    height: width * 0.131,
                                    width: width * 0.131,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              Assets.lucky16L16ThirdWheel),
                                          fit: BoxFit.fill,
                                        )),
                                    child: lucky12ResultViewModel
                                                .lucky12ResultList.isNotEmpty &&
                                            !l12c.resultShowTime
                                        ? _buildVerticalLayout(
                                            l12c, lucky12ResultViewModel)
                                        : null,
                                  ),
                                ],
                              ),
                              Container(
                                height: width * 0.38,
                                width: width * 0.32,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(Assets.lucky12ShowRes),
                                  fit: BoxFit.fill,
                                )),
                              ),
                            ],
                          ),
                          Container(
                            height: height * 0.08,
                            width: width * 0.3,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Assets.lucky16LBgBlue),
                                    fit: BoxFit.fill)),
                            child: Text(
                              l12c.showMessage,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'ville',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: height * 0.05,
                                width: width * 0.15,
                                margin:
                                    const EdgeInsets.only(right: 2, left: 2),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(Assets.lucky16LBgYellow),
                                        fit: BoxFit.fill)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'PLAY:',
                                        style: TextStyle(
                                            fontSize: AppConstant.luckyRoFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'roboto'),
                                      ),
                                      Text(
                                        l12c.totalBetAmount.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: AppConstant.luckyRoFont,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'roboto'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.05,
                                width: width * 0.15,
                                margin:
                                    const EdgeInsets.only(right: 2, left: 2),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(Assets.lucky16LBgYellow),
                                        fit: BoxFit.fill)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'WIN:',
                                        style: TextStyle(
                                            fontSize: AppConstant.luckyRoFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'roboto'),
                                      ),
                                      Text(
                                        lucky12ResultViewModel.winAmount
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: AppConstant.luckyRoFont,
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(
                                        l12c.columnBetList.length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (l12c.addLucky12Bets.isEmpty &&
                                                  l12c.resetOne == true) {
                                                l12c.setResetOne(false);
                                              }
                                              l12c.addColumnBet(context, index);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height * 0.14,
                                              width: width * 0.06,
                                              padding: EdgeInsets.only(
                                                  bottom: width * 0.005),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(l12c
                                                      .columnBetList[index]),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: l12c.tapedColumnList
                                                          .isNotEmpty &&
                                                      l12c.tapedColumnList
                                                          .where((e) =>
                                                              e["index"] ==
                                                              index)
                                                          .isNotEmpty
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: height * 0.052,
                                                      width: height * 0.052,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          1, 2.5, 1, 1),
                                                      decoration:
                                                          getBoxDecoration(
                                                        l12c.tapedColumnList
                                                            .where((e) =>
                                                                e["index"] ==
                                                                index)
                                                            .first["amount"]!,
                                                      ),
                                                      child: Text(
                                                        l12c.tapedColumnList
                                                            .where((e) =>
                                                                e["index"] ==
                                                                index)
                                                            .first["amount"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: l12c
                                                                        .tapedColumnList
                                                                        .where((e) =>
                                                                            e["index"] ==
                                                                            index)
                                                                        .first[
                                                                            "amount"]
                                                                        .toString()
                                                                        .length <
                                                                    3
                                                                ? 8
                                                                : 7,
                                                            fontFamily:
                                                                'dangrek',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )
                                                  : Text(
                                                      !l12c.showBettingTime
                                                          ? 'Play'
                                                          : '',
                                                      style: TextStyle(
                                                          fontSize: AppConstant
                                                              .luckyKaFont,
                                                          fontFamily: 'dancing',
                                                          color: Colors.white),
                                                    ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    GridView.builder(
                                      padding: const EdgeInsets.all(2),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: l12c.cardList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1.4 / 1.25,
                                        mainAxisSpacing: 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (l12c.addLucky12Bets.isEmpty &&
                                                l12c.resetOne == true) {
                                              l12c.setResetOne(false);
                                            }
                                            l12c.luckyAddBet(
                                                l12c.cardList[index].id,
                                                l12c.selectedValue,
                                                index,
                                                context);
                                          },
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: height * 0.10,
                                            width: width * 0.06,
                                            padding: EdgeInsets.only(
                                                bottom: width * 0.008),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(l12c
                                                      .cardList[index].image),
                                                  fit: BoxFit.fill),
                                            ),
                                            child: l12c.addLucky12Bets
                                                        .isNotEmpty &&
                                                    l12c.addLucky12Bets
                                                        .where((value) =>
                                                            value['game_id'] ==
                                                            l12c.cardList[index]
                                                                .id)
                                                        .isNotEmpty
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    height: height * 0.052,
                                                    width: height * 0.052,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(1, 2.5, 1, 1),
                                                    decoration:
                                                        getBoxDecoration(l12c
                                                            .addLucky12Bets
                                                            .where((e) =>
                                                                e['game_id'] ==
                                                                l12c
                                                                    .cardList[
                                                                        index]
                                                                    .id)
                                                            .first["amount"]!),
                                                    child: Text(
                                                      l12c.addLucky12Bets
                                                          .where((e) =>
                                                              e['game_id'] ==
                                                              l12c
                                                                  .cardList[
                                                                      index]
                                                                  .id)
                                                          .first["amount"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: l12c
                                                                      .addLucky12Bets
                                                                      .where((e) =>
                                                                          e['game_id'] ==
                                                                          l12c
                                                                              .cardList[
                                                                                  index]
                                                                              .id)
                                                                      .first[
                                                                          "amount"]
                                                                      .toString()
                                                                      .length <
                                                                  3
                                                              ? 8
                                                              : 7,
                                                          fontFamily: 'dangrek',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                : Text(
                                                    !l12c.showBettingTime
                                                        ? 'Play'
                                                        : '',
                                                    style: TextStyle(
                                                        fontSize: AppConstant
                                                            .luckyKaFont,
                                                        fontFamily: 'dancing'),
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: width * 0.12,
                                    height: height * 0.11,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                Assets.lucky16LBetInfo),
                                            fit: BoxFit.fill)),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      l12c.rowBetList.length,
                                      (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (l12c.addLucky12Bets.isEmpty &&
                                                l12c.resetOne == true) {
                                              l12c.setResetOne(false);
                                            }
                                            l12c.addRowBet(context, index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: width * 0.015),
                                            padding: EdgeInsets.only(
                                                top: width * 0.008,
                                                left: width * 0.03),
                                            alignment: Alignment.center,
                                            height: height * 0.1,
                                            width: width * 0.07,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    l12c.rowBetList[index]),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: l12c.tapedRowList
                                                        .isNotEmpty &&
                                                    l12c.tapedRowList
                                                        .where((e) =>
                                                            e["index"] == index)
                                                        .isNotEmpty
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    height: height * 0.052,
                                                    width: height * 0.052,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(1, 2.5, 1, 1),
                                                    decoration:
                                                        getBoxDecoration(
                                                      l12c.tapedRowList
                                                          .where((e) =>
                                                              e["index"] ==
                                                              index)
                                                          .first["amount"]!,
                                                    ),
                                                    child: Text(
                                                      l12c.tapedRowList
                                                          .where((e) =>
                                                              e["index"] ==
                                                              index)
                                                          .first["amount"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: l12c
                                                                      .tapedRowList
                                                                      .where((e) =>
                                                                          e["index"] ==
                                                                          index)
                                                                      .first[
                                                                          "amount"]
                                                                      .toString()
                                                                      .length <
                                                                  3
                                                              ? 8
                                                              : 7,
                                                          fontFamily: 'dangrek',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                : Text(
                                                    !l12c.showBettingTime
                                                        ? 'Play'
                                                        : '',
                                                    style: TextStyle(
                                                        fontSize: AppConstant
                                                            .luckyKaFont,
                                                        color: Colors.white,
                                                        fontFamily: 'dancing'),
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Lucky12Result(),
                                    Lucky12CoinList()
                                  ],
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Lucky12Timer()
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: height * 0.30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Lucky12Btn(
                                  title: 'INFO',
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const Lucky12InfoD();
                                      },
                                    );
                                  },
                                ),
                                Stack(
                                  children: [
                                    Lucky12Btn(
                                      title: 'CLEAR',
                                      onTap: () {
                                        if (l12c.addLucky12Bets.isNotEmpty) {
                                          l12c.clearAllBet(context);
                                        }
                                      },
                                    ),
                                    if (l12c.addLucky12Bets.isEmpty)
                                      shadowContainer()
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Lucky12Btn(
                                      title: 'REMOVE',
                                      onTap: () {
                                        if (l12c.addLucky12Bets.isNotEmpty) {
                                          l12c.setResetOne(true);
                                        }
                                      },
                                    ),
                                    if (l12c.addLucky12Bets.isEmpty)
                                      shadowContainer()
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Lucky12Btn(
                                      title: 'DOUBLE',
                                      onTap: () {
                                        if (l12c.addLucky12Bets.isNotEmpty) {
                                          l12c.doubleAllBets(context);
                                        }
                                      },
                                    ),
                                    if (l12c.addLucky12Bets.isEmpty)
                                      shadowContainer()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // first time position
              const Lucky12Top(),
            ],
          ),
        ),
      );
    });
  }

  Widget shadowContainer() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.06,
      width: width * 0.08,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  Widget _buildVerticalLayout(
      Lucky12Controller l12c, Lucky12ResultViewModel lucky12resultViewModel) {
    final card = l12c.getCardForIndex(
        lucky12resultViewModel.lucky12ResultList.first.cardIndex!);
    final color = l12c.getColorForIndex(
        lucky12resultViewModel.lucky12ResultList.first.colorIndex!);
    final jackpot = l12c.getJackpotForIndex(
        lucky12resultViewModel.lucky12ResultList.first.jackpot!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageContainer(card),
            _buildImageContainer(color),
          ],
        ),
        if (jackpot != null) _buildJackpotImage(jackpot),
      ],
    );
  }

  Widget _buildImageContainer(String assetPath) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.1,
      width: width * 0.04,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.fill),
      ),
    );
  }

  Widget _buildJackpotImage(String assetPath) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.fill),
      ),
    );
  }
}

BoxDecoration getBoxDecoration(int amount) {
  String assetName;

  if (amount >= 5 && amount < 10) {
    assetName = Assets.lucky16LC5;
  } else if (amount >= 10 && amount < 20) {
    assetName = Assets.lucky16LC10;
  } else if (amount >= 20 && amount < 50) {
    assetName = Assets.lucky16LC20;
  } else if (amount >= 50 && amount < 100) {
    assetName = Assets.lucky16LC50;
  } else if (amount >= 100 && amount < 500) {
    assetName = Assets.lucky16LC100;
  } else {
    assetName = Assets.lucky16LC500;
  }

  return BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(image: AssetImage(assetName), fit: BoxFit.fill),
  );
}
