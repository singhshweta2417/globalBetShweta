import 'dart:async';
import 'dart:math';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/view/home/casino/7up_down_new/res/widget/seven_up_loading.dart';
import 'package:globalbet/view/home/casino/7up_down_new/seven_updown_game_history.dart';
import 'package:globalbet/view/home/casino/7up_down_new/view_model/seven_updown_bet_view_model.dart';
import 'package:globalbet/view/home/casino/7up_down_new/view_model/seven_updown_result_view_model.dart';
import 'package:globalbet/view/home/casino/andar_bahar/andar_bahar_assets.dart';
import 'package:globalbet/view/home/casino/andar_bahar/constant/coins_sign_new.dart';
import 'package:globalbet/view/home/casino/andar_bahar/constant/hide_coins.dart';
import 'package:globalbet/view/home/casino/dragon_tiger_new/coin/set_coin.dart';
import 'package:globalbet/view/home/casino/dragon_tiger_new/widgets/dragon_tiger_assets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../../../utils/utils.dart';
import '../../mini/aviator/widget/image_toast.dart';

class SevenUpDownScreen extends StatefulWidget {
  const SevenUpDownScreen({super.key});

  @override
  State<SevenUpDownScreen> createState() => _SevenUpDownScreenState();
}

class _SevenUpDownScreenState extends State<SevenUpDownScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    startCountdown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultProvider =
          Provider.of<SevenUpDownResultViewModel>(context, listen: false);
      resultProvider.sevenResultApi(context, 10);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //  Audio.audioPlayer.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    wallet = double.parse(context.read<ProfileViewModel>().balance.toString());
  }

  bool dice = false;
  int countdownSeconds = 30;
  Timer? countdownTimer;
  bool fristCome = false;

  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int initialSeconds = 60 - now.second; // Calculate initial remaining seconds
    setState(() {
      countdownSeconds = initialSeconds;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 29) {
        wallet =
            double.parse(context.read<ProfileViewModel>().balance.toString());
        context.read<ProfileViewModel>().profileApi(context);

        ImageToast.show(
            imagePath: AppAssets.dragontigerStartbetting,
            heights: 100,
            context: context);
      } else if (countdownSeconds == 27) {
        generateRandomCoin();
        _addCoins(randomCoin);
      } else if (countdownSeconds == 20) {
        ImageToast.show(
            imagePath: AppAssets.twsecleft, heights: 100, context: context);
      } else if (countdownSeconds == 13) {
        ImageToast.show(
            imagePath: AppAssets.dragontigerStopbetting,
            heights: 100,
            context: context);
        hidebutton = true;
      } else if (countdownSeconds == 10) {
        final betProvider =
            Provider.of<SevenUpDownViewModel>(context, listen: false);
        betProvider.sevenUpDownBet(context, redCount.toString(),
            blueCount.toString(), greenCount.toString());
        print(redCount);
        print(blueCount);
        print(greenCount);
        print("sdf wrdwryd76w");
      } else if (countdownSeconds == 8) {
        // futurePopUp(context);
        dice = true;
      } else if (countdownSeconds == 7) {
        final resultProvider =
            Provider.of<SevenUpDownResultViewModel>(context, listen: false);
        resultProvider.sevenResultApi(context, 10);
      } else if (countdownSeconds == 4) {
        wallet =
            double.parse(context.read<ProfileViewModel>().balance.toString());
      } else if (countdownSeconds == 1) {
        if (fristCome == false) {
        } else {
          hidebutton = false;
          countandcoinclear();
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pop();
            dice = false;
          });
        }
        fristCome = true;
      }
      countdownSeconds = (countdownSeconds - 1) % 30;
    });
  }

  int randomCoin = 0;
  int randomPeople = 0;
  void generateRandomCoin() {
    setState(() {
      randomCoin = Random().nextInt(90) + 10;
      randomPeople = Random().nextInt(989) + 10;
    });
  }

  void countandcoinclear() {
    setState(() {
      redCoins.clear();
      blueCoins.clear();
      greenCoins.clear();
      redCount = 0;
      blueCount = 0;
      greenCount = 0;

      coinsRed.clear();
      coinsBlue.clear();
      coinsGreen.clear();
    });
  }

  int redCount = 0;
  int blueCount = 0;
  int greenCount = 0;

  List<int> list = [1, 5, 10, 50, 100, 500, 1000];

  bool hidebutton = false;
  dynamic wallet = 0;
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

  int selectedCart = 1;
  GlobalKey<CartIconKey> redKey = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> greenKey = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> blueKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey<CartIconKey>) runAddToCartAnimation;

  List<Widget> redCoins = [];
  List<Widget> blueCoins = [];
  List<Widget> greenCoins = [];

  Randomno(int min, int max) {
    Random random = Random();
    return double.parse((min + random.nextInt(max - min + 1)).toString());
  }

  var _cartQuantityItems = 0;
  void listClick(GlobalKey<CartIconKey> itemKey) async {
    await runAddToCartAnimation(itemKey);
    if (selectedCart == 1 && redKey.currentState != null) {
      redKey.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Dragon');
    } else if (selectedCart == 2 && blueKey.currentState != null) {
      blueKey.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Tie');
    } else if (selectedCart == 3 && greenKey.currentState != null) {
      greenKey.currentState!
          .runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Tie');
    }
  }

  List<Widget> coinsRed = [];
  List<Widget> coinsBlue = [];
  List<Widget> coinsGreen = [];
  void _addCoins(int count) {
    for (int i = 0; i < count; i++) {
      Timer(Duration(milliseconds: i * 200), () {
        setState(() {
          coinsRed.add(
            const _AnimatedCoin(
              type: 0,
            ),
          );
          coinsBlue.add(
            const _AnimatedCoin(
              type: 1,
            ),
          );
          coinsGreen.add(
            const _AnimatedCoin(
              type: 2,
            ),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return fristCome == false
        ? SevenUpLoading(time: int.parse(countdownSeconds.toString()))
        : AddToCartAnimation(
            cartKey: selectedCart == 1
                ? redKey
                : selectedCart == 2
                    ? blueKey
                    : greenKey,
            height: 15,
            width: 15,
            opacity: 0.85,
            dragAnimation: const DragToCartAnimationOptions(
              rotation: false,
            ),
            jumpAnimation: const JumpAnimationOptions(),
            createAddToCartAnimation: (runAddToCartAnimation) {
              this.runAddToCartAnimation = runAddToCartAnimation;
            },
            child: Scaffold(
                body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.sevenUpDownNewSevenBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Consumer<SevenUpDownResultViewModel>(
                      builder: (context, srv, child) {
                    return Column(
                      children: [
                        headerWidget(
                          redCount.toString(),
                          blueCount.toString(),
                          greenCount.toString(),
                        ),
                        Container(
                          height: height * 0.04,
                          width: width * 0.5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  AndarAssets.andarbaharGamebuttonbg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height / 20,
                                width: width * 0.4,
                                child: ListView.builder(
                                  itemCount: srv.sevenResultModel!.data!.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(right: width * 0.02),
                                      child: Center(
                                        child: ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            int number = int.parse(srv
                                                .sevenResultModel!
                                                .data![index]
                                                .randomCard);
                                            if (number >= 2 && number <= 6) {
                                              // Red gradient for numbers between 2 to 6
                                              return ui.Gradient.linear(
                                                const Offset(0.0, 0.0),
                                                const Offset(200.0, 70.0),
                                                [Colors.red, Colors.deepOrange],
                                              );
                                            } else if (number == 7) {
                                              // Blue gradient for number 7
                                              return ui.Gradient.linear(
                                                const Offset(0.0, 0.0),
                                                const Offset(200.0, 70.0),
                                                [
                                                  Colors.blue,
                                                  Colors.deepPurple
                                                ],
                                              );
                                            } else if (number >= 8 &&
                                                number <= 12) {
                                              // Green gradient for numbers between 8 to 12
                                              return ui.Gradient.linear(
                                                const Offset(0.0, 0.0),
                                                const Offset(200.0, 70.0),
                                                [
                                                  Colors.green,
                                                  Colors.lightGreen
                                                ],
                                              );
                                            } else {
                                              // Default yellow gradient
                                              return ui.Gradient.linear(
                                                const Offset(0.0, 0.0),
                                                const Offset(200.0, 70.0),
                                                [
                                                  Colors.amber,
                                                  Colors.deepOrange
                                                ],
                                              );
                                            }
                                          },
                                          child: Text(
                                            srv.sevenResultModel!.data![index]
                                                .randomCard,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Image.asset(AppAssets.buttonsIcArrowZigzag,
                                  height: height * 0.03),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.73,
                          width: width * 0.99,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage(Assets.sevenUpDownNewBoard),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.2,
                                width: width * 0.18,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        Assets.sevenUpDownNewRedboard),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: SizedBox(
                                  height: height * 0.24,
                                  width: width * 0.35,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedCart = 1;
                                      });
                                    },
                                    child: Container(
                                      key: redKey,
                                      height: height * 0.24,
                                      width: width * 0.35,
                                      decoration: BoxDecoration(
                                        //color: Colors.indigo,

                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(45),
                                            topLeft: Radius.circular(59)),
                                        border: Border.all(
                                          width: 2,
                                          color: selectedCart == 1
                                              ? Colors.green
                                              : Colors.transparent,
                                        ),
                                        color: selectedCart == 1
                                            ? Colors.blue.withOpacity(0.5)
                                            : null,
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: -120,
                                            top: 30,
                                            child: Stack(
                                              children: coinsRed,
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              for (var data in redCoins) data,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // color: Colors.red,
                              ),
                              Container(
                                height: height * 0.2,
                                width: width * 0.14,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        Assets.sevenUpDownNewBlueboard),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: SizedBox(
                                  height: height * 0.24,
                                  width: width * 0.35,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedCart = 2;
                                      });
                                    },
                                    child: Container(
                                      key: blueKey,
                                      height: height * 0.24,
                                      width: width * 0.35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: selectedCart == 2
                                              ? Colors.green
                                              : Colors.transparent,
                                        ),
                                        color: selectedCart == 2
                                            ? Colors.blue.withOpacity(0.5)
                                            : null,
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: -120,
                                            top: 30,
                                            child: Stack(
                                              children: coinsBlue,
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              for (var data in blueCoins) data,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.2,
                                width: width * 0.18,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        Assets.sevenUpDownNewGreenboard),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: SizedBox(
                                  height: height * 0.24,
                                  width: width * 0.35,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedCart = 3;
                                      });
                                    },
                                    child: Container(
                                      key: greenKey,
                                      height: height * 0.24,
                                      width: width * 0.35,
                                      decoration: BoxDecoration(
                                        //color: Colors.indigo,

                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(45),
                                            topRight: Radius.circular(59)),
                                        border: Border.all(
                                          width: 2,
                                          color: selectedCart == 3
                                              ? Colors.green
                                              : Colors.transparent,
                                        ),
                                        color: selectedCart == 3
                                            ? Colors.blue.withOpacity(0.5)
                                            : null,
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: -120,
                                            top: 30,
                                            child: Stack(
                                              children: coinsGreen,
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              for (var data in greenCoins) data,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // color: Colors.red,
                        ),
                        const Spacer(),
                        walletRefresh(),
                        betAmount()
                      ],
                    );
                  }),
                  dice == false
                      ? Positioned(
                          left: width * 0.58,
                          top: height * 0.07,
                          child: Container(
                            height: height * 0.13,
                            width: width * 0.07,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        Assets.sevenUpDownNewDiceTwo))),
                          ),
                        )
                      : Container()
                ],
              ),
            )),
          );
  }

  Widget headerWidget(String redCount, String blueCount, String greenCount) {
    return SizedBox(
      height: height * 0.078,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
              left: width * 0.03,
            ),
            child: InkWell(
              onTap: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ]);
                Navigator.pop(context);
              },
              child: Container(
                height: height * 0.03,
                width: width * 0.07,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AndarAssets.andarbaharBack),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.075,
            width: width * 0.2,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.buttonsRuppePannel),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                headerBlueBoxWidget(redCount, Colors.red),
                headerBlueBoxWidget(blueCount, Colors.blue),
                headerBlueBoxWidget(greenCount, Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerBlueBoxWidget(String count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(radius: height * 0.0085, backgroundColor: color),
        Text(
          count,
          style: const TextStyle(
              fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ],
    );
  }

  Widget betAmount() {
    return SizedBox(
      height: height * 0.08,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext, int index) {
          final GlobalKey<CartIconKey> itemKey = GlobalKey<CartIconKey>();
          return hidebutton == true
              ? hidecoins(list[index])
              : InkWell(
                  onTap: () async {
                    wallet == null
                        ? Utils.flushBarErrorMessage(
                            'Please Recharge', context, Colors.red)
                        : wallet! < list[index]
                            ? Utils.flushBarErrorMessage(
                                'Low Balance', context, Colors.red)
                            : Future.delayed(const Duration(milliseconds: 1500),
                                () {
                                if (selectedCart == 1) {
                                  redCoins.add(Positioned(
                                      left: Randomno(1, 70),
                                      top: Randomno(10, 70),
                                      child: CoindesignNew(list[index])));
                                } else if (selectedCart == 2) {
                                  blueCoins.add(Positioned(
                                      left: Randomno(1, 70),
                                      top: Randomno(20, 70),
                                      child: CoindesignNew(list[index])));
                                } else if (selectedCart == 3) {
                                  greenCoins.add(Positioned(
                                      left: Randomno(1, 70),
                                      top: Randomno(10, 70),
                                      child: CoindesignNew(list[index])));
                                }
                                setState(() {
                                  if (selectedCart == 1) {
                                    redCount = redCount + list[index];
                                  } else if (selectedCart == 2) {
                                    blueCount = blueCount + list[index];
                                  } else {
                                    greenCount = greenCount + list[index];
                                  }
                                });
                              });
                    wallet! < list[index] ? '' : listClick(itemKey);

                    deductAmount(
                      list[index],
                    );
                  },
                  child: Container(
                      key: itemKey, child: CoindesignNew(list[index])),
                );
        },
      ),
    );
  }

  Widget walletRefresh() {
    return SizedBox(
      height: height * 0.06,
      width: width * 0.79,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: height * 0.035,
            width: width * 0.07,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AndarAssets.andarbaharIcOnlineUser),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            randomPeople.toString(),
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Container(
            height: height * 0.043,
            width: width * 0.43,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.sevenUpDownNewSlideSideButton),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: height * 0.036,
                  width: width * 0.29,
                  child: Center(
                      child: Text(
                    wallet.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white),
                  )),
                ),
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
                            image: AssetImage(Assets.sevenUpDownNewReload),
                            fit: BoxFit.fill)),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: SevenUpDownGameHistoryScreen(),
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
          Container(
            height: height * 0.05,
            width: width * 0.09,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppAssets.watch)),
            ),
            child: Center(
                child: Text(
              countdownSeconds.toString(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            )),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCoin extends StatefulWidget {
  final int type;

  const _AnimatedCoin({required this.type});
  @override
  _AnimatedCoinState createState() => _AnimatedCoinState();
}

class _AnimatedCoinState extends State<_AnimatedCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = widget.type == 1
        ? Tween<Offset>(
            begin: const Offset(-1, 120),
            end: _randomOffset(100, 150),
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutBack,
            ),
          )
        : _animation = widget.type == 2
            ? Tween<Offset>(
                begin: const Offset(-1, 120),
                end: _randomOffset(100, 150),
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOutBack,
                ),
              )
            : Tween<Offset>(
                begin: const Offset(-1, 120),
                end: _randomOffset(100, 150),
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOutBack,
                ),
              );
    _controller.forward();
  }

  doublepj(double start, double end) {
    Random random = Random();

    return start + random.nextDouble() * (end - start);
  }

  Offset _randomOffset(double start, double end) {
    double randomPositionX = doublepj(80, 120);
    double randomPositionY = doublepj(70, 120);
    return Offset(randomPositionX, randomPositionY);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value,
          child: const CoinSpringAnimation(),
        );
      },
    );
  }
}
