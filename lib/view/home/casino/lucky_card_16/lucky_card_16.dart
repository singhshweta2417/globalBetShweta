import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/view_model/lucky_16_result_view_model.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/luck_16_exit_pop_up.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_btn.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_coin_list.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_info_d.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_result.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_second_wheel.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_timer.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_top.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/widgets/lucky_16_wheel_first.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:provider/provider.dart';
import 'controller/lucky_16_controller.dart';

class LuckyCard16 extends StatefulWidget {
  const LuckyCard16({super.key});

  @override
  State<LuckyCard16> createState() => _LuckyCard16State();
}

class _LuckyCard16State extends State<LuckyCard16> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resTimer = Provider.of<Lucky16Controller>(context, listen: false);
      resTimer.connectToServer(context);
      final lucky16ResultViewModel =
          Provider.of<Lucky16ResultViewModel>(context, listen: false);
      lucky16ResultViewModel.lucky16ResultApi(context, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lucky16ResultViewModel = Provider.of<Lucky16ResultViewModel>(context);
    return Consumer<Lucky16Controller>(builder: (context, l16c, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (_) {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (BuildContext context) {
              return Luck16ExitPopUp(
                yes: () {
                  // exit pop up
                  l16c.disConnectToServer(context);
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
                      // padding: const EdgeInsets.only(bottom: 1),
                      width: width * 0.5,
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Stack(
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
                                  Lucky16WheelFirst(
                                    controller: l16c,
                                    pathImage: Assets.lucky16L16FirstWheel,
                                    withWheel: width * 0.289,
                                    pieces: 16,
                                  ),
                                  Lucky16SecondWheel(
                                    controller: l16c,
                                    pathImage: Assets.lucky16L16SecondWheel,
                                    withWheel: width * 0.2,
                                    pieces: 16,
                                  ),
                                  Container(
                                    height: width * 0.134,
                                    width: width * 0.134,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              Assets.lucky16L16ThirdWheel),
                                          fit: BoxFit.fitWidth,
                                        )),
                                    child: lucky16ResultViewModel
                                                .lucky16ResultList.isNotEmpty &&
                                            !l16c.resultShowTime
                                        ? _buildVerticalLayout(
                                            l16c, lucky16ResultViewModel)
                                        : null,
                                  )
                                ],
                              ),
                              Container(
                                height: width * 0.38,
                                width: width * 0.32,
                                decoration:  const BoxDecoration(
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
                              l16c.showMessage,
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
                                height: height * 0.08,
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
                                        l16c.totalBetAmount.toString(),
                                        style: TextStyle(
                                            fontSize: AppConstant.luckyRoFont,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.08,
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
                                        lucky16ResultViewModel.winAmount
                                            .toString(),
                                        style:  TextStyle(
                                            fontSize: AppConstant.luckyRoFont,
                                            color: Colors.black,
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
                    Container(
                      width: width * 0.5,
                      height: height,
                      padding: const EdgeInsets.only(bottom: 5),
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
                                        l16c.columnBetList.length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (l16c.addLucky16Bets.isEmpty &&
                                                  l16c.resetOne == true) {
                                                l16c.setResetOne(false);
                                              }
                                              l16c.addColumnBet(context, index);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height * 0.11,
                                              width: width * 0.06,
                                              padding:  EdgeInsets.only(
                                                  bottom:width*0.005),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(l16c
                                                      .columnBetList[index]),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: l16c.tapedColumnList
                                                          .isNotEmpty &&
                                                      l16c.tapedColumnList
                                                          .where((e) =>
                                                              e["index"] ==
                                                              index)
                                                          .isNotEmpty
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height:
                                                          height * 0.052,
                                                      width:
                                                          height * 0.052,
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          1, 2.5, 1, 1),
                                                      decoration:
                                                          getBoxDecoration(
                                                        l16c.tapedColumnList
                                                            .where((e) =>
                                                                e["index"] ==
                                                                index)
                                                            .first["amount"]!,
                                                      ),
                                                      child: Text(
                                                        l16c.tapedColumnList
                                                            .where((e) =>
                                                                e["index"] ==
                                                                index)
                                                            .first["amount"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: l16c
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
                                                      !l16c.showBettingTime
                                                          ? 'Play'
                                                          : '',
                                                      style:  TextStyle(
                                                          fontSize: AppConstant.luckyKaFont,
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
                                      itemCount: l16c.cardList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 1.4 / 1,
                                        mainAxisSpacing: 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (l16c.addLucky16Bets.isEmpty &&
                                                l16c.resetOne == true) {
                                              l16c.setResetOne(false);
                                            }
                                            l16c.luckyAddBet(
                                                l16c.cardList[index].id,
                                                l16c.selectedValue,
                                                index,
                                                context);
                                          },
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: height * 0.10,
                                            width: width * 0.06,
                                            padding: EdgeInsets.only(
                                                bottom: width*0.008),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(l16c
                                                      .cardList[index].image),
                                                  fit: BoxFit.fill),
                                            ),
                                            child: l16c.addLucky16Bets
                                                        .isNotEmpty &&
                                                    l16c.addLucky16Bets
                                                        .where((value) =>
                                                            value[
                                                                'game_id'] ==
                                                            l16c
                                                                .cardList[
                                                                    index]
                                                                .id)
                                                        .isNotEmpty
                                                ? Container(
                                                    alignment:
                                                        Alignment.center,
                                                    height: height *
                                                        0.052,
                                                    width: height *
                                                        0.052,
                                                    padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            1, 2.5, 1, 1),
                                                    decoration: getBoxDecoration(l16c
                                                        .addLucky16Bets
                                                        .where((e) =>
                                                            e['game_id'] ==
                                                            l16c
                                                                .cardList[
                                                                    index]
                                                                .id)
                                                        .first["amount"]!),
                                                    child: Text(
                                                      l16c.addLucky16Bets
                                                          .where((e) =>
                                                              e['game_id'] ==
                                                              l16c
                                                                  .cardList[
                                                                      index]
                                                                  .id)
                                                          .first["amount"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: l16c
                                                                      .addLucky16Bets
                                                                      .where((e) =>
                                                                          e['game_id'] ==
                                                                          l16c
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
                                                          fontFamily:
                                                              'dangrek',
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                    ),
                                                  )
                                                : Text(
                                                    !l16c.showBettingTime
                                                        ? 'Play'
                                                        : '',
                                                    style:  TextStyle(
                                                        fontSize: AppConstant.luckyKaFont,
                                                        fontFamily:
                                                            'dancing'),
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
                                      l16c.rowBetList.length,
                                          (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (l16c.addLucky16Bets
                                                .isEmpty &&
                                                l16c.resetOne == true) {
                                              l16c.setResetOne(false);
                                            }
                                            l16c.addRowBet(
                                                context, index);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: width*0.008),
                                            padding:
                                            EdgeInsets.only(
                                                top: width*0.008, left: width*0.03),
                                            alignment: Alignment.center,
                                            height: AppConstant.luckyColHi,
                                            width: width * 0.07,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(l16c
                                                    .rowBetList[index]),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: l16c.tapedRowList
                                                .isNotEmpty &&
                                                l16c.tapedRowList
                                                    .where((e) =>
                                                e["index"] ==
                                                    index)
                                                    .isNotEmpty
                                                ? Container(
                                              alignment:
                                              Alignment.center,
                                              height: height *
                                                  0.052,
                                              width: height *
                                                  0.052,
                                              padding:
                                              const EdgeInsets
                                                  .fromLTRB(
                                                  1, 2.5, 1, 1),
                                              decoration:
                                              getBoxDecoration(
                                                l16c.tapedRowList
                                                    .where((e) =>
                                                e["index"] ==
                                                    index)
                                                    .first["amount"]!,
                                              ),
                                              child: Text(
                                                l16c.tapedRowList
                                                    .where((e) =>
                                                e["index"] ==
                                                    index)
                                                    .first["amount"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: l16c
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
                                                    fontFamily:
                                                    'dangrek',
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            )
                                                : Text(
                                              !l16c.showBettingTime
                                                  ? 'Play'
                                                  : '',
                                              style:  TextStyle(
                                                  fontSize:AppConstant.luckyKaFont,
                                                  color:
                                                  Colors.white,
                                                  fontFamily:
                                                  'dancing'),
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
                                    Lucky16Result(),
                                    Lucky16CoinList()
                                  ],
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Lucky16Timer()
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: height * 0.30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Lucky16Btn(
                                  title: 'INFO',
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const Lucky16InfoD();
                                      },
                                    );
                                  },
                                ),
                                Stack(
                                  children: [
                                    Lucky16Btn(
                                      title: 'CLEAR',
                                      onTap: () {
                                        if (l16c.addLucky16Bets.isNotEmpty) {
                                          l16c.clearAllBet(context);
                                        }
                                      },
                                    ),
                                    if (l16c.addLucky16Bets.isEmpty)
                                      shadowContainer()
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Lucky16Btn(
                                      title: 'REMOVE',
                                      onTap: () {
                                        if (l16c.addLucky16Bets.isNotEmpty) {
                                          l16c.setResetOne(true);
                                        }
                                      },
                                    ),
                                    if (l16c.addLucky16Bets.isEmpty)
                                      shadowContainer()
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Lucky16Btn(
                                      title: 'DOUBLE',
                                      onTap: () {
                                        if (l16c.addLucky16Bets.isNotEmpty) {
                                          l16c.doubleAllBets(context);
                                        }
                                      },
                                    ),
                                    if (l16c.addLucky16Bets.isEmpty)
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
              const Lucky16Top()
            ],
          ),
        ),
      );
    });
  }

  Widget shadowContainer() {
    return Container(
      height: height * 0.06,
      width: width * 0.08,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  Widget _buildVerticalLayout(
      Lucky16Controller l16c, Lucky16ResultViewModel lucky16resultViewModel) {
    final card = l16c.getCardForIndex(
        lucky16resultViewModel.lucky16ResultList.first.cardIndex!);
    final color = l16c.getColorForIndex(
        lucky16resultViewModel.lucky16ResultList.first.colorIndex!);
    final jackpot = l16c.getJackpotForIndex(
        lucky16resultViewModel.lucky16ResultList.first.jackpot!);
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
        if(jackpot!=null)
          _buildJackpotImage(jackpot),
      ],
    );
  }

  Widget _buildImageContainer(String assetPath) {
    return Container(
      height: height*0.1,
      width: width*0.04,
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
