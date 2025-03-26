import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/res/orientation.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/view/bottom/bottom_nav_bar.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/res/stroke_text.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/exit_pop_up.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/info_spin_d.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/spin_bet_grid.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/spin_btn.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/spin_coin_list.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/spin_result.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/spin_wheel.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/widgets/spin_wheel_bulb.dart';
import 'package:provider/provider.dart';
import 'controller/spin_controller.dart';
import 'view_model/spin_result_view_model.dart';

class SpinToWin extends StatefulWidget {
  const SpinToWin({super.key});

  @override
  State<SpinToWin> createState() => _SpinToWinState();
}

class _SpinToWinState extends State<SpinToWin> {
  bool isSoundOn = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OrientationLandscapeUtil.setLandscapeOrientation();
      final resTimer = Provider.of<SpinController>(context, listen: false);
      resTimer.connectToServer(context);
      final spinResultViewModel =
          Provider.of<SpinResultViewModel>(context, listen: false);
      spinResultViewModel.spinResultApi(context, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final spinResultViewModel = Provider.of<SpinResultViewModel>(context);
    return Consumer<SpinController>(builder: (context, stc, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (_) {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (BuildContext context) {
              return ExitPopUp(yes: () {
                OrientationPortraitUtil.setPortraitOrientation();
                FeedbackProvider.navigateToHome(context);
                stc.disConnectToServer(context);
              });
            },
          );
        },
        child: Scaffold(
          body: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.spinSpinBg),
                        fit: BoxFit.fill)),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.15,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'POINTS',
                                  style: TextStyle(
                                      color: const Color(0xff6f3400),
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConstant.spinUsFont),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: height * 0.075,
                                  width: width * 0.1,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.005),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1.2, color: Colors.black),
                                    color: const Color(0xff865b00),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      profileViewModel.balance
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: AppConstant.spinResFont),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Welcome,  ${profileViewModel.userName}',
                                style: TextStyle(
                                    color: const Color(0xff6f3400),
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppConstant.spinUsFont),
                              ),
                            ),
                            Text(
                              'HISTORY',
                              style: TextStyle(
                                  color: const Color(0xff6f3400),
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstant.spinBetAmFont),
                            ),
                            Container(
                              height: height * 0.11,
                              width: width * 0.47,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xff865b00),
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              ),
                              child: const SpinResult(),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSoundOn = !isSoundOn;
                                });
                              },
                              child: Container(
                                height: height * 0.10,
                                width: width * 0.05,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      isSoundOn
                                          ? Assets.spinSpSound
                                          : Assets
                                              .spinSpinSoundOff, // Conditional image
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (!stc.isDialogOpen) {
                                  stc.setIsDialogOpen(true);
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const InfoSpinDialog();
                                    },
                                  );
                                }
                              },
                              child: Container(
                                height: height * 0.10,
                                width: width * 0.05,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(Assets.spinSpIndicate),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return ExitPopUp(yes: () {
                                      OrientationPortraitUtil
                                          .setPortraitOrientation();
                                      FeedbackProvider.navigateToHome(context);
                                      stc.disConnectToServer(context);
                                    });
                                  },
                                );
                              },
                              child: Container(
                                height: height * 0.10,
                                width: width * 0.05,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(Assets.spinSpCancel)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: height * 0.2,
                            width: width * 0.38,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                color: const Color(0xff461902)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'PLAY',
                                      style: TextStyle(
                                          fontSize: AppConstant.spinResFont,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: height * 0.1,
                                      width: width * 0.14,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xffba9d42)),
                                        color: const Color(0xff6b4b02),
                                      ),
                                      child: Text(
                                        stc.totalBetAmount.toString(),
                                        style: TextStyle(
                                            fontSize: AppConstant.spinResFont,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'WIN',
                                      style: TextStyle(
                                          fontSize: AppConstant.spinResFont,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: height * 0.1,
                                      width: width * 0.14,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xffba9d42)),
                                        color: const Color(0xff6b4b02),
                                      ),
                                      child: Text(
                                        spinResultViewModel.winAmount
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: AppConstant.spinResFont,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SpinBetGrid(),
                              const SpinCoinList(),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: SizedBox(
                                      height: height * 0.26,
                                      width: width * 0.40,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SpinBtn(
                                                title: 'ODDS',
                                                onTap: () {
                                                  if (stc
                                                      .isPlayAllowed(context)) {
                                                    stc.oddBets(context);
                                                  }
                                                },
                                                color: stc
                                                        .isPlayAllowed(context)
                                                    ? const Color(0xffcf0101)
                                                    : const Color(0xff545453),
                                              ),
                                              SpinBtn(
                                                title: 'EVENS',
                                                onTap: () {
                                                  if (stc
                                                      .isPlayAllowed(context)) {
                                                    stc.evenBets(context);
                                                  }
                                                },
                                                color: stc
                                                        .isPlayAllowed(context)
                                                    ? const Color(0xffcf0101)
                                                    : const Color(0xff545453),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SpinBtn(
                                                title: 'DOUBLE',
                                                onTap: () {
                                                  if (stc.isPlayAllowed(
                                                          context) &&
                                                      stc.spinBets.isNotEmpty) {
                                                    stc.doubleAllBets(context);
                                                  }
                                                },
                                                color: stc.isPlayAllowed(
                                                            context) &&
                                                        stc.spinBets.isNotEmpty
                                                    ? const Color(0xffcf0101)
                                                    : const Color(0xff545453),
                                              ),
                                              SpinBtn(
                                                title: 'REPEAT',
                                                onTap: () {
                                                  if (stc.spinBets.isEmpty &&
                                                      stc.isPlayAllowed(
                                                          context) &&
                                                      stc.repeatBets
                                                          .isNotEmpty) {
                                                    stc.spinRepeatBet(context);
                                                  }
                                                },
                                                color: stc.spinBets.isEmpty &&
                                                        stc.isPlayAllowed(
                                                            context) &&
                                                        stc.repeatBets
                                                            .isNotEmpty
                                                    ? const Color(0xffcf0101)
                                                    : const Color(0xff545453),
                                              ),
                                              SpinBtn(
                                                title: 'CLEAR',
                                                onTap: () {
                                                  if (stc.isPlayAllowed(
                                                          context) &&
                                                      stc.spinBets.isNotEmpty) {
                                                    stc.clearAllBet(context);
                                                  }
                                                },
                                                color: stc.isPlayAllowed(
                                                            context) &&
                                                        stc.spinBets.isNotEmpty
                                                    ? const Color(0xffcf0101)
                                                    : const Color(0xff545453),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.30,
                                    width: width * 0.20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      color: const Color(0xff444131),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: height * 0.18,
                                          width: width * 0.16,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: const Color(0xff665239),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.black,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  height: height * 0.075,
                                                  width: width * 0.15,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(5),
                                                      topLeft:
                                                          Radius.circular(5),
                                                    ),
                                                    color: Color(0xffb00100),
                                                  ),
                                                  child: Text(
                                                    stc.timerStatus == 1
                                                        ? '00:${stc.timerBetTime.toString().padLeft(2, '0')}'
                                                        : '00:00',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            height * 0.06),
                                                  )),
                                              Container(
                                                height: height * 0.075,
                                                width: width * 0.15,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                  ),
                                                  color: Color(0xff6a403f),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.black)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: ShaderMask(
                                                        shaderCallback:
                                                            (Rect bounds) {
                                                          return const LinearGradient(
                                                            colors: [
                                                              Color(0xff0bce1a),
                                                              Color(0xffe5fd01),
                                                              Color(0xfffd6501)
                                                            ],
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                          ).createShader(
                                                              bounds);
                                                        },
                                                        child:
                                                            LinearProgressIndicator(
                                                          value: stc.timerStatus ==
                                                                  1
                                                              ? (40 - stc.timerBetTime) /
                                                                  40
                                                              : 0,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          spinResultViewModel
                                                  .spinResultList.isNotEmpty
                                              ? (spinResultViewModel
                                                          .spinResultList
                                                          .first
                                                          .periodNo! +
                                                      1)
                                                  .toString()
                                              : '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  AppConstant.spinBetAmFont),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: AppConstant.spinWheelPosition,
                left: width * 0.022,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: width * 0.35,
                      width: width * 0.35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(Assets.spinSFirstWheel))),
                    ),
                    SpinWheel(
                      controller: stc,
                      pathImage: Assets.spinSSecondWheel,
                      withWheel: width * 0.322,
                      pieces: 10,
                    ),
                    Container(
                        height: width * 0.12,
                        width: width * 0.12,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(Assets.spinSThirdWheel))),
                        child: stc.timerStatus == 2 && stc.timerBetTime <= 8
                            ? strokeWidget(stc, spinResultViewModel)
                            : null),
                    Container(
                      height: width * 0.37,
                      width: width * 0.37,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(Assets.spinShowRes),
                            fit: BoxFit.cover),
                      ),
                    ),
                    if (stc.isAnimationOpen) ...[
                      Positioned(
                        top: width * 0.014,
                        left: width * 0.12,
                        child: const SpinWheelBulb(),
                      ),
                      // Positioned(
                      //   top: width * 0.008,
                      //   left: width * 0.17,
                      //   child: const SpinWheelBulb(),
                      // ),
                      Positioned(
                        top: width * 0.014,
                        left: width * 0.22,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.039,
                        left: width * 0.265,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.075,
                        left: width * 0.3,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.12,
                        left: width * 0.325,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.175,
                        left: width * 0.335,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.23,
                        left: width * 0.325,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.27,
                        left: width * 0.3,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.31,
                        left: width * 0.265,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.335,
                        left: width * 0.22,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.34,
                        left: width * 0.165,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.335,
                        left: width * 0.11,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.31,
                        left: width * 0.065,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.275,
                        left: width * 0.03,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.23,
                        left: width * 0.008,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.17,
                        left: -width * 0.003,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.12,
                        left: width * 0.003,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.072,
                        left: width * 0.03,
                        child: const SpinWheelBulb(),
                      ),
                      Positioned(
                        top: width * 0.04,
                        left: width * 0.065,
                        child: const SpinWheelBulb(),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget strokeWidget(
      SpinController stc, SpinResultViewModel spinResultViewModel) {
    if (spinResultViewModel.spinResultList.isEmpty) {
      return const SizedBox(); // Return an empty widget if no data is available
    }

    final jackpot = stc.getJackpotForIndex(
        spinResultViewModel.spinResultList.first.jackpot!);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StrokeText(
          text: spinResultViewModel.spinResultList.first.winNumber.toString(),
          fontSize: 40,
          strokeWidth: 3,
          fontWeight: FontWeight.w900,
        ),
        if (jackpot != null) _buildJackpotImage(jackpot),
      ],
    );
  }


  Widget _buildJackpotImage(String assetPath) {
    return Container(
      height: 20,
      width: 30,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.fill),
      ),
    );
  }
}
