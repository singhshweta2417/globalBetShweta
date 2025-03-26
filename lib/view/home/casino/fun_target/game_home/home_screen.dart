import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/orientation.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/view/bottom/bottom_nav_bar.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/SharedPreference.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/audio-player.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/color.dart';
import 'package:globalbet/view/home/casino/fun_target/Model/result-history-model.dart';
import 'package:globalbet/view/home/casino/fun_target/Provider/result_history_provider.dart';
import 'package:globalbet/view/home/casino/fun_target/Provider/result_provider.dart';
import 'package:globalbet/view/home/casino/fun_target/api/bet_service.dart';
import 'package:globalbet/view/home/casino/fun_target/api/take_winning_amount_service.dart';
import 'package:globalbet/view/home/casino/fun_target/constant_widgets/container_widget.dart';
import 'package:globalbet/view/home/casino/fun_target/constant_widgets/small_text_style.dart';
import 'package:globalbet/view/home/casino/fun_target/constant_widgets/title_style.dart';
import 'package:globalbet/view/home/casino/fun_target/game_home/big_chakra.dart';
import 'package:globalbet/view/home/casino/fun_target/game_home/blinking.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/utils.dart';
import '../../triple_chance/widgets/exit_pop_up.dart';

class ButtonChips {
  final String buttonColor;
  final String price;
  ButtonChips(this.buttonColor, this.price);
}

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  WheelSpinController wheelSpinController = WheelSpinController();
  int selectedChip = 0;
  int amount = 0;
  int result = 0;
  int placeBetValue = 0;
  int winnerAmount = 0;
  int totalBetApplied = 0;
  int countdownSeconds = 60;
  bool isBetOk = false;
  bool isBetAllowed = true;
  bool isViewResult = false;
  bool reach5SecondTimer = false;
  bool needToTake = false;
  bool? isTimerDone = true;
  Timer? countdownTimer;
  List<BetOnNumbers> betNumbersList = [
    BetOnNumbers(number: 1, betApplied: 0),
    BetOnNumbers(number: 2, betApplied: 0),
    BetOnNumbers(number: 3, betApplied: 0),
    BetOnNumbers(number: 4, betApplied: 0),
    BetOnNumbers(number: 5, betApplied: 0),
    BetOnNumbers(number: 6, betApplied: 0),
    BetOnNumbers(number: 7, betApplied: 0),
    BetOnNumbers(number: 8, betApplied: 0),
    BetOnNumbers(number: 9, betApplied: 0),
    BetOnNumbers(number: 0, betApplied: 0),
  ];
  List<BetOnNumbers> getBetOnNumber = [];
  List<BetOnNumbers> repeatBetList = [];

  List<ButtonChips> chipsButtonListLeft = [
    ButtonChips(Assets.funTarget1, "1"),
    ButtonChips(Assets.funTarget5, "5"),
    ButtonChips(Assets.funTarget10, "10"),
    ButtonChips(Assets.funTarget50, "50"),
  ];
  List<ButtonChips> chipsButtonListRight = [
    ButtonChips(Assets.funTargetTestChip, "100"),
    ButtonChips(Assets.funTarget500, "500"),
    ButtonChips(Assets.funTarget1000, "1000"),
    ButtonChips(Assets.funTarget5000, "5000"),
  ];

  stopAudio() async {
    await audioPlayer.pause();
  }

  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int initialSeconds = 60 - now.second;
    setState(() {
      countdownSeconds = initialSeconds;
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 55) {
        setState(() {
          isTimerDone = true;
        });
        stopNetworkSound();
        matchResultWithUserBet();
      } else if (countdownSeconds == 59) {
        setState(() {
          int resultValue = 20 - result * 2;
          wheelSpinController.stopWheel(resultValue);
        });
      } else if (countdownSeconds == 10) {
        setState(() {
          reach5SecondTimer = false;
          isBetAllowed = false;
        });
        if (isBetOk == false &&
            getBetOnNumber.isNotEmpty &&
            totalBetApplied != 0) {
          hitInsertBetApiAndInsertBetData();
        } else {
          if (kDebugMode) {
            print("bet already placed");
          }
        }
      } else if (countdownSeconds == 15) {
        setState(() {
          reach5SecondTimer = true;
        });
      } else if (countdownSeconds == 1) {
        pauseNetworkSound();
        // playNetworkSound("${AppUrls.BaseUrl}assets/music/movechakra.mp3");
      } else if (countdownSeconds == 0) {
        SharedPreferencesUtil.clearLastResult();
        wheelSpinController.startWheel();
        setState(() {
          isTimerDone = false;
          isViewResult = false;
          isBetAllowed = true;
          repeatBetList = List.from(getBetOnNumber);
        });
        _fetchApiData();
        setState(() {
          reach5SecondTimer = false;
        });
      }
      countdownSeconds = (countdownSeconds - 1) % 60;
    });
  }

  hitInsertBetApiAndInsertBetData() async {
    List<Map<String, dynamic>> jsonList =
        getBetOnNumber.map((bet) => bet.toJson()).toList();
    await context
        .read<BetService>()
        .insertBetApi(context, jsonList)
        .then((value) {
      setState(() {
        isBetOk = true;
      });
      if (kDebugMode) {
        print("jsonList:$jsonList");
      }
    }).catchError((err) {
      if (kDebugMode) {
        print("failed to insert");
      }
    });
  }

  void matchResultWithUserBet() {
    if (isBetOk) {
      bool foundWinner = false;
      for (BetOnNumbers bet in getBetOnNumber) {
        if (bet.number.toString() == result.toString()) {
          pauseNetworkSound();
          setState(() {
            winnerAmount = bet.betApplied * 9;
            needToTake = true;
            countdownTimer!.cancel();
            isViewResult = true;
            isBetOk = false;
          });
          Utils.flushBarSuccessMessage("YOU WON", context, Colors.green);
          _focusNode2.requestFocus();
          foundWinner = true;
          break;
        }
      }
      if (!foundWinner) {
        setState(() {
          winnerAmount = 0;
          isBetOk = false;
          selectedChip = 0;
          totalBetApplied = 0;
          for (var element in betNumbersList) {
            element.betApplied = 0;
          }
        });
        Utils.flushBarErrorMessage("YOU LOSE", context, Colors.red);
      }
      getBetOnNumber.clear();
    } else {
      setState(() {
        isBetOk = false;
        winnerAmount = 0;
        selectedChip = 0;
        for (var element in betNumbersList) {
          element.betApplied = 0;
        }
      });
      getBetOnNumber.clear();
    }
  }

  Future<void> _fetchApiData() async {
    try {
      await Future.wait([
        Provider.of<ResultHistoryProvider>(context, listen: false)
            .fetchResultHistoryData(context),
        Provider.of<ResultProvider>(context, listen: false)
            .fetchResultData(context),
        Provider.of<ProfileViewModel>(context, listen: false)
            .profileApi(context),
      ]);

      final profileData = Provider.of<ProfileViewModel>(context, listen: false);

      if (profileData.balance != "null") {
        setState(() {
          amount = int.parse(profileData.balance);
        });
      } else {
        if (kDebugMode) {
          print("the profile data is empty");
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching data: $e');
        print(stackTrace);
      }
    }
    setState(() {
      selectedChip = 0;
      for (var element in betNumbersList) {
        element.betApplied = 0;
      }
    });
  }

  betOkButtonAction() {
    if (getBetOnNumber.isNotEmpty && reach5SecondTimer == false) {
      if (isBetOk == false) {
        hitInsertBetApiAndInsertBetData();
      } else {
        Utils.flushBarSuccessMessage(
            "You are already confirm bet", context, Colors.green);
      }
    } else {
      Utils.flushBarErrorMessage(
          "Must be enter bet to continue", context, Colors.red);
    }
  }

  void updateBetValue(int number) {
    setState(() {
      if (number >= 0 && number <= 9) {
        tapToPlaceBetOnNumberActionKeyboard(number);
      }
    });
  }

  void tapToPlaceBetOnNumberActionKeyboard(int number) {
    if (!isBetOk && isBetAllowed) {
      setState(() {
        placeBetValue = selectedChip;

        if (placeBetValue <= amount) {
          amount -= placeBetValue;

          // Find the index corresponding to the number in betNumbersList
          int index = betNumbersList.indexWhere((bet) => bet.number == number);

          if (index != -1) {
            betNumbersList[index].betApplied += placeBetValue;

            // Handle getBetOnNumber updates
            int elementIndex =
                getBetOnNumber.indexWhere((bet) => bet.number == number);

            if (elementIndex != -1) {
              getBetOnNumber[elementIndex].betApplied += placeBetValue;
            } else {
              getBetOnNumber.add(
                BetOnNumbers(number: number, betApplied: placeBetValue),
              );
            }

            totalBetApplied = betNumbersList.fold(
              0,
              (previousValue, element) => previousValue + element.betApplied,
            );
          }
        } else {
          Utils.flushBarErrorMessage(
              "You have low balance", context, Colors.red);
        }
      });
    } else {
      Utils.flushBarErrorMessage("Bet not allowed", context, Colors.red);
    }
  }

  void tapToPlaceBetOnNumberAction(int index) {
    if (!isBetOk && isBetAllowed) {
      setState(() {
        // Use the selected chip value as the bet value
        placeBetValue = selectedChip;

        // Check if the user has enough balance to place the bet
        if (placeBetValue <= amount) {
          // Deduct the bet amount from the user's balance
          amount -= placeBetValue;

          // Retrieve the actual number associated with the selected index
          int actualNumber = betNumbersList[index].number;

          // Update the bet amount applied for the selected number
          betNumbersList[index].betApplied += placeBetValue;

          // Handle bets in the getBetOnNumber list
          if (getBetOnNumber.isNotEmpty) {
            pauseNetworkSound();
            // playNetworkSound("https://kgfgold.in/assets/music/placechip.mp3");

            // Check if the number already exists in getBetOnNumber
            int elementIndex =
                getBetOnNumber.indexWhere((bet) => bet.number == actualNumber);

            if (elementIndex != -1) {
              pauseNetworkSound();
              // playNetworkSound("https://kgfgold.in/assets/music/placechip.mp3");
              setState(() {
                // Update the existing bet amount for the number
                getBetOnNumber[elementIndex].betApplied += placeBetValue;
              });
            } else {
              pauseNetworkSound();
              setState(() {
                // Add a new entry for the number in getBetOnNumber
                getBetOnNumber.add(
                  BetOnNumbers(number: actualNumber, betApplied: placeBetValue),
                );
              });
            }
          } else {
            pauseNetworkSound();
            // playNetworkSound("https://kgfgold.in/assets/music/placechip.mp3");
            setState(() {
              // Add the first entry for the number in getBetOnNumber
              getBetOnNumber.add(
                BetOnNumbers(number: actualNumber, betApplied: placeBetValue),
              );
            });
          }

          // Recalculate the total bets applied
          totalBetApplied = betNumbersList.fold(
            0,
            (previousValue, element) => previousValue + element.betApplied,
          );
        } else {
          // Show an error message if the balance is insufficient
          Utils.flushBarErrorMessage(
              "You have low balance", context, Colors.red);
        }
      });
    } else {
      // Show a snackbar message if betting is not allowed
      Utils.flushBarErrorMessage("Bet not allowed", context, Colors.red);
    }
  }

  void repeatPreviousBet() {
    if (isBetOk == false &&
        repeatBetList.isNotEmpty &&
        reach5SecondTimer == false) {
      setState(() {
        getBetOnNumber = List.from(repeatBetList);
      });
      pauseNetworkSound();
      playNetworkSound("https://kgfgold.in/assets/music/placechip.mp3");
      for (var bet in getBetOnNumber) {
        if (bet.number >= 0 && bet.number <= betNumbersList.length) {
          setState(() {
            betNumbersList[bet.number].betApplied = bet.betApplied;
            totalBetApplied += bet.betApplied;
          });
        } else {}
      }
      hitInsertBetApiAndInsertBetData();
      repeatBetList.clear();
    }
  }

  @override
  void initState() {
    OrientationLandscapeUtil.setLandscapeOrientation();
    _focusNode1.addListener(() {
      if (!_focusNode1.hasFocus) {
        _focusNode2.requestFocus();
      }
    });

    _focusNode2.addListener(() {
      if (!_focusNode2.hasFocus) {
        _focusNode1.requestFocus();
      }
    });
    super.initState();
    startCountdown();
    _fetchApiData();
  }

  Widget sectionOne() {
  
    return CustomContainer(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              yellowButton(
                  SmallText(
                    title: amount.toString() == "null" ? "" : amount.toString(),
                    textColor: ColorConstant.textColorBrown,
                    style: GoogleFonts.dmSerifDisplay(
                      textStyle: TextStyle(
                        fontSize: widthFun/ 55,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: ColorConstant.textColorBrown,
                      ),
                    ),
                  ),
                  "Score",
                  const EdgeInsets.only(left: 10)),
              SizedBox(
                height: heightFun/ 20,
              ),
              Stack(
                children: [
                  BlinkingTimerBg(
                    isTimeToStartBlinking: reach5SecondTimer,
                  ),
                  yellowButton(
                      SmallText(
                        title:
                            "00 : ${countdownSeconds.toString().padLeft(2, '0')}",
                        textColor: Colors.brown,
                        fontWeight: FontWeight.bold,
                        style: TextStyle(
                            height: 0.6,
                            fontFamily: "MyFont",
                            fontSize: widthFun/ 50,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                            color: Colors.brown),
                      ),
                      "Time",
                      const EdgeInsets.only(left: 10)),
                ],
              ),
              SizedBox(
                height: heightFun/ 20,
              ),
            ],
          ),
          const Spacer(),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              yellowButton(Consumer<ResultProvider>(
                builder: (context, resultProvider, child) {
                  final resultData = resultProvider.result;
                  result = int.parse(resultData!.result);
                  if (isViewResult == true) {
                    return SmallText(
                        title: winnerAmount.toString() != "null"
                            ? "$winnerAmount"
                            : resultData.result,
                        style: GoogleFonts.dmSerifDisplay(
                          textStyle: TextStyle(
                            fontSize: widthFun/ 55,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.textColorBrown,
                          ),
                        ));
                  } else {
                    return SmallText(
                        title: "0",
                        fontSize: widthFun/ 55,
                        style: GoogleFonts.dmSerifDisplay(
                          textStyle: TextStyle(
                            fontSize: widthFun/ 55,
                            fontStyle: FontStyle.normal,
                            color: ColorConstant.textColorBrown,
                          ),
                        ));
                  }
                },
              ), "Winner", const EdgeInsets.only(right: 10)),
              SizedBox(
                height: heightFun/ 20,
              ),
              yellowButton(Consumer<ResultHistoryProvider>(
                builder: (context, resultProvider, child) {
                  ResultHistoryModel? result = resultProvider.result;
                  if (result != null) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: result.data.length,
                            itemBuilder: (context, index) {
                              final lastResult = result.data[index].result;
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: widthFun/ 310),
                                child: SmallText(
                                    title: lastResult.toString(),
                                    style: GoogleFonts.dmSerifDisplay(
                                      textStyle: TextStyle(
                                        fontSize: widthFun/ 58,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        color: ColorConstant.textColorBrown,
                                      ),
                                    )),
                              );
                            }));
                  } else {
                    return SmallText(
                      title: "waiting",
                      textColor: ColorConstant.textColorBrown,
                      fontWeight: FontWeight.bold,
                      fontSize: widthFun/ 55,
                    );
                  }
                },
              ), "Last 10 Data", const EdgeInsets.only(right: 10)),
              SizedBox(
                height: heightFun/ 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionTwo() {
  
    return CustomContainer(
      padding: const EdgeInsets.only(top: 8),
      clipBehavior: Clip.none,
      height: heightFun/ 2.4,
      widths: widthFun/ 1.2,
      image: const DecorationImage(
        image: AssetImage(Assets.funTargetBadge),
        fit: BoxFit.fill,
      ),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform(
                transform: Matrix4.identity()..rotateX(0.8),
                alignment: FractionalOffset.center,
                child: sideButtons(
                  const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      chipsButtonListLeft.length,
                      (index) => InkWell(
                        onTap: () {
                          if (!isBetOk) {
                            _focusNode1.requestFocus();
                            setState(() {
                              selectedChip =
                                  int.parse(chipsButtonListLeft[index].price);
                            });
                            // SharedPreferencesUtil.setChipsValue(selectedChip);
                          } else {
                            Utils.flushBarErrorMessage(
                                "Bet already placed", context, Colors.red);
                          }
                        },
                        child: chipButton(
                          chipsButtonListLeft[index].price,
                          chipsButtonListLeft[index].buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  KeyboardListener(
                    focusNode: _focusNode2,
                    autofocus: true,
                    onKeyEvent: (event) async {
                      if (event is KeyDownEvent) {
                        // Handle the Space Key Press
                        if (event.logicalKey == LogicalKeyboardKey.space) {
                          _focusNode2.requestFocus();
                          if (needToTake) {
                            try {
                              await context
                                  .read<WinningAmountService>()
                                  .insertWinningAmount(context, winnerAmount);
                              setState(() {
                                amount += winnerAmount;
                                needToTake = false;
                                isBetOk = false;
                                totalBetApplied = 0;
                                selectedChip = 0;
                                for (var element in betNumbersList) {
                                  element.betApplied = 0;
                                }
                                startCountdown();
                              });
                            } catch (err) {
                              if (kDebugMode) {
                                print("Failed to insert winner amount");
                              }
                            }
                          } else {
                            Utils.flushBarErrorMessage(
                                "Must play and win to take",
                                context,
                                Colors.red);
                          }
                        }
                      }

                      if (kDebugMode) {
                        print("Key Pressed: ${event.logicalKey}");
                      }
                    },
                    child: InkWell(
                      onTap: () async {
                        _focusNode2.requestFocus();
                        if (needToTake) {
                          try {
                            await context
                                .read<WinningAmountService>()
                                .insertWinningAmount(context, winnerAmount);
                            setState(() {
                              amount += winnerAmount;
                              needToTake = false;
                              isBetOk = false;
                              totalBetApplied = 0;
                              selectedChip = 0;
                              for (var element in betNumbersList) {
                                element.betApplied = 0;
                              }
                              startCountdown();
                            });
                          } catch (err) {
                            if (kDebugMode) {
                              print("Failed to insert winner amount");
                            }
                          }
                        } else {
                          Utils.flushBarErrorMessage(
                              "Must play and win to take", context, Colors.red);
                        }
                      },
                      child: BlinkingTakeOption(
                        isSide: "left",
                        isTimeToStartBlinking: needToTake,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      if (!isBetOk && !reach5SecondTimer) {
                        setState(() {
                          for (var element in betNumbersList) {
                            element.betApplied = 0;
                          }
                          getBetOnNumber.clear();
                        });
                      } else {
                        Utils.flushBarErrorMessage(
                            "Not allowed to cancel bet after placed",
                            context,
                            Colors.red);
                      }
                    },
                    child: BlinkingCancelRepeat(
                      isSide: "left",
                      title: "Cancel Bet",
                      isTimeToStartBlinking:
                          getBetOnNumber.isNotEmpty && !isBetOk,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform(
                transform: Matrix4.identity()..rotateX(0.8),
                alignment: FractionalOffset.center,
                child: sideButtons(
                  const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      chipsButtonListRight.length,
                      (index) => InkWell(
                        onTap: () {
                          _focusNode1.requestFocus();
                          setState(() {
                            selectedChip =
                                int.parse(chipsButtonListRight[index].price);
                          });
                        },
                        child: chipButton(
                          chipsButtonListRight[index].price,
                          chipsButtonListRight[index].buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      repeatPreviousBet();
                    },
                    child: BlinkingCancelRepeat(
                      isSide: "right",
                      title: "Repeat",
                      isTimeToStartBlinking: !needToTake &&
                          getBetOnNumber.isEmpty &&
                          !isBetOk &&
                          repeatBetList.isNotEmpty,
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      betOkButtonAction();
                    },
                    child: BlinkingTakeOption(
                      isSide: "right",
                      isTimeToStartBlinking:
                          getBetOnNumber.isNotEmpty && !isBetOk,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBetItem(int index) {
    int betValue = betNumbersList[index].betApplied;
    bool isBetPlaced = betValue != 0;
    return KeyboardListener(
      focusNode: _focusNode1,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          _focusNode1.requestFocus();
          // Detect if the key pressed is from the standard number row (0-9)
          if (event.logicalKey == LogicalKeyboardKey.digit0 ||
              event.logicalKey == LogicalKeyboardKey.digit1 ||
              event.logicalKey == LogicalKeyboardKey.digit2 ||
              event.logicalKey == LogicalKeyboardKey.digit3 ||
              event.logicalKey == LogicalKeyboardKey.digit4 ||
              event.logicalKey == LogicalKeyboardKey.digit5 ||
              event.logicalKey == LogicalKeyboardKey.digit6 ||
              event.logicalKey == LogicalKeyboardKey.digit7 ||
              event.logicalKey == LogicalKeyboardKey.digit8 ||
              event.logicalKey == LogicalKeyboardKey.digit9) {
            int index = int.parse(event.character ?? '0');
            updateBetValue(index);
            if (kDebugMode) {
              print(index);
              print("number hua keyboard se");
            }
          }
          // Detect if the key pressed is from the numeric keypad (NumLock)
          else if (event.logicalKey == LogicalKeyboardKey.numpad0 ||
              event.logicalKey == LogicalKeyboardKey.numpad1 ||
              event.logicalKey == LogicalKeyboardKey.numpad2 ||
              event.logicalKey == LogicalKeyboardKey.numpad3 ||
              event.logicalKey == LogicalKeyboardKey.numpad4 ||
              event.logicalKey == LogicalKeyboardKey.numpad5 ||
              event.logicalKey == LogicalKeyboardKey.numpad6 ||
              event.logicalKey == LogicalKeyboardKey.numpad7 ||
              event.logicalKey == LogicalKeyboardKey.numpad8 ||
              event.logicalKey == LogicalKeyboardKey.numpad9) {
            int index = int.parse(event.character ?? '0');
            updateBetValue(index);
          }

          if (kDebugMode) {
            print("Key Pressed number : ${event.logicalKey}");
          }
        }
      },
      child: InkWell(
        onTap: () {
          _focusNode1.requestFocus();
          tapToPlaceBetOnNumberAction(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomContainer(
              widths: widthFun/ 13,
              height: widthFun/ 35,
              alignment: Alignment.center,
              image: const DecorationImage(
                image: AssetImage(
                  Assets.funTargetCircleButton2,
                ),
                fit: BoxFit.fill,
              ),
              child: SmallText(
                  alignment: Alignment.center,
                  title: isBetPlaced ? "$betValue" : "",
                  fontSize: widthFun/ 60,
                  style: GoogleFonts.dmSerifDisplay(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widthFun/ 60,
                      fontStyle: FontStyle.normal,
                      color: ColorConstant.textColorBrown,
                    ),
                  )),
            ),
            CustomContainer(
              padding: const EdgeInsets.all(5),
              widths: widthFun/ 16,
              height: widthFun/ 20,
              image: const DecorationImage(
                image: AssetImage(
                  Assets.funTargetCircleButton,
                ),
                fit: BoxFit.fill,
              ),
              child: BlinkingWinnerNumber(
                isTimeToStartBlinking: needToTake == true && result - 1 == index
                    ? needToTake
                    : false,
                index: betNumbersList[index].number.toString(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: betValue == 0 ? Colors.transparent : Colors.green,
                  ),
                  child: SmallText(
                      alignment: Alignment.center,
                      title: betNumbersList[index].number.toString(),
                      style: GoogleFonts.dmSerifDisplay(
                        textStyle: TextStyle(
                          fontSize: widthFun/ 50,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: ColorConstant.whiteColor,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionThree() {
    return CustomContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          10,
          (index) => buildBetItem(index),
        ),
      ),
    );
  }

  Widget sectionFour() {
    return CustomContainer(
      height: heightFun/ 14.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomContainer(
            widths: widthFun/ 9,
            height: heightFun/ 11,
            image: const DecorationImage(
                image: AssetImage(Assets.funTargetLeftTake),
                fit: BoxFit.fitWidth),
            child: SmallText(
              fontWeight: FontWeight.bold,
              fontSize: widthFun/ 60,
              title: totalBetApplied.toString(),
              textColor: ColorConstant.whiteColor,
            ),
          ),
          CustomContainer(
            height: heightFun/ 16,
            widths: widthFun/ 2.2,
            alignment: Alignment.bottomCenter,
            image: const DecorationImage(
                image: AssetImage(Assets.funTargetBottomBig),
                fit: BoxFit.fitWidth),
            child: SmallText(
              alignment: Alignment.bottomCenter,
              title: winnerAmount == 0
                  ? "Better luck next time!! You Loss "
                  : winnerAmount == -1
                      ? "You are not placed bet in this match"
                      : "Boohoo!! Congrats Winner no is $result and You Won - $winnerAmount",
              textColor: ColorConstant.textColorBrown,
              fontSize: widthFun/ 60,
            ),
          ),
          CustomContainer(
            onTap: () {
              countdownTimer!.cancel();
              pauseNetworkSound();
              Navigator.of(context).pop();
            },
            widths: widthFun/ 9,
            height: heightFun/ 11,
            image: const DecorationImage(
                image: AssetImage(Assets.funTargetBetOkRight),
                fit: BoxFit.fitWidth),
            child: SmallText(
              fontWeight: FontWeight.bold,
              fontSize: widthFun/ 60,
              title: "Exit",
              textColor: ColorConstant.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return ExitPopUp(
              title: 'Are you sure You want to\ngoto Lobby?',
              yes: () {
                OrientationPortraitUtil.setPortraitOrientation();
                FeedbackProvider.navigateToHome(context);
              },
              image: const DecorationImage(
                  image: AssetImage(Assets.tripleChanceCloseBg),
                  fit: BoxFit.fill),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: ColorConstant.darkBlackColor,
        body: Center(
          child: CustomContainer(
            widths: widthFun/ 1.2,
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 3),
            alignment: Alignment.center,
            image: const DecorationImage(
                image: AssetImage(Assets.funTargetHomeBgFun),
                fit: BoxFit.cover),
            height: height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sectionOne(),
                    const Spacer(),
                    sectionThree(),
                    sectionFour(),
                  ],
                ),
                CustomContainer(
                  padding: const EdgeInsets.only(top: 0),
                  height: widthFun/ 3.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      WheelSpin(
                        controller: wheelSpinController,
                        pathImage: Assets.funTargetBadaChakra,
                        withWheel: widthFun/ 1.5,
                        pieces: 20,
                        speed: 600,
                        isShowTextTest: false,
                      ),
                      CustomContainer(
                          alignment: Alignment.center,
                          widths: widthFun/ 11,
                          child: isTimerDone == false
                              ? Image.asset(Assets.funTargetMain)
                              : Image.asset(Assets.funTargetStaticCoin))
                    ],
                  ),
                ),
                Positioned(
                  top: -9,
                  child: CustomContainer(
                    widths: widthFun/ 16,
                    height: widthFun/ 21,
                    clipBehavior: Clip.none,
                    image: const DecorationImage(
                        image: AssetImage(
                          Assets.funTargetScorpio,
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                Positioned(top: heightFun/ 2.9, child: sectionTwo()),
                Positioned(
                    top: heightFun/ 2.15,
                    left: widthFun/ 2.4,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2.2,
                    left: widthFun/ 2.8,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2,
                    left: widthFun/ 4.5,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2.3,
                    left: widthFun/ 4,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 3.03,
                    left: widthFun/ 3.6,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2,
                    right: widthFun/ 4.5,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2.3,
                    right: widthFun/ 4,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 3.03,
                    right: widthFun/ 3.6,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2.6,
                    right: widthFun/ 3,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2.6,
                    left: widthFun/ 3,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2.15,
                    right: widthFun/ 3.3,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 2.15,
                    left: widthFun/ 3.3,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.83,
                    left: widthFun/ 24,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.75,
                    left: widthFun/ 9,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.7,
                    left: widthFun/ 5.5,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.65,
                    left: widthFun/ 4,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.83,
                    right: widthFun/ 24,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.75,
                    right: widthFun/ 9,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.7,
                    right: widthFun/ 5.5,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.65,
                    right: widthFun/ 3.8,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.68,
                    right: widthFun/ 2.105,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.68,
                    left: widthFun/ 2.105,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.46,
                    right: widthFun/ 2.05,
                    child: const BlinkingStar()),
                Positioned(
                    top: heightFun/ 1.46,
                    left: widthFun/ 2.05,
                    child: const BlinkingStar()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget yellowButton(
      Widget? innerText, outerText, EdgeInsetsGeometry padding) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: padding,
      child: Column(
        children: [
          TitleStyle(
            title: outerText,
            fontSize: widthFun/ 55,
            fontWeight: FontWeight.bold,
            lineHeight: 0.6,
          ),
          const SizedBox(
            height: 5,
          ),
          CustomContainer(
              padding: const EdgeInsets.all(2),
              widths: widthFun/ 5.8,
              height: widthFun/ 28,
              image: const DecorationImage(
                  image: AssetImage(Assets.funTargetYellowButtons),
                  fit: BoxFit.fill),
              child: innerText)
        ],
      ),
    );
  }

  Widget sideButtons(
    BorderRadiusGeometry? borderRadius,
    Widget child,
  ) {
    final width = MediaQuery.of(context).size.width;
    return CustomContainer(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 3, top: 3),
      widths: widthFun/ 5,
      borderRadius: borderRadius,
      gradient: LinearGradient(
        colors: [
          Colors.yellow.shade400.withOpacity(0.8),
          Colors.orange.withOpacity(0.7),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      child: child,
    );
  }

  Widget chipButton(String price, imageName) {
  
    return CustomContainer(
      alignment: Alignment.topCenter,
      borderRadius: BorderRadius.circular(60),
      border: Border.all(
          width: 1.5,
          color: selectedChip.toString() == price
              ? Colors.yellowAccent
              : Colors.transparent),
      widths: widthFun/ 23,
      height: heightFun/ 15,
      image: DecorationImage(image: AssetImage(imageName), fit: BoxFit.fill),
      child: SmallText(
        alignment: Alignment.center,
        fontSize: widthFun/ 75,
        title: "",
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    stopAudio();
    stopNetworkSound();
    releaseNetworkSoundResources();
    audioPlayer.pause();
    audioPlayer.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }
}

class BetOnNumbers {
  int number;
  int betApplied;
  BetOnNumbers({required this.number, required this.betApplied});
  Map<String, int> toJson() {
    return {
      'number': number,
      'amount': betApplied,
    };
  }
}
