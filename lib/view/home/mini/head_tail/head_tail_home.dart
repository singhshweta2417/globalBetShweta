import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/home/casino/andar_bahar/andar_bahar_model/last_fifteen.dart';
import 'package:game_on/view/home/casino/andar_bahar/andar_bahar_assets.dart';
import 'package:game_on/view/home/casino/andar_bahar/constant/coins_sign_new.dart';
import 'package:game_on/view/home/casino/andar_bahar/constant/game_history.dart';
import 'package:game_on/view/home/casino/andar_bahar/constant/hide_coins.dart';
import 'package:game_on/view/home/casino/andar_bahar/constant/image_toast_wingo.dart';
import 'package:game_on/view/home/casino/dragon_tiger_new/coin/set_coin.dart';
import 'package:game_on/view/home/mini/head_tail/head_tail_assets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../generated/assets.dart';
import '../../../../res/aap_colors.dart';
import '../../../../res/api_urls.dart';
import '../../casino/andar_bahar/constant/andar_bahar_history.dart';
import '../../casino/dragon_tiger_new/widgets/dragon_tiger_assets.dart';
import '../Aviator/widget/image_toast.dart';
import 'loading_popup.dart';

const double kCoinRadius = 20.0;

class HeadTailHome extends StatefulWidget {
  final String gameId;
  final String tittle;
  const HeadTailHome({
    super.key,
    required this.gameId,
    required this.tittle,
  });

  @override
  HeadTailHomeState createState() => HeadTailHomeState();
}

class HeadTailHomeState extends State<HeadTailHome>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _toss;
  late Animation<Matrix4> _turn;

  @override
  void initState() {
    super.initState();
    startCountdown();
    fetchData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        }
      });
  }

  bool fristCome = false;
  @override
  void didChangeDependencies() {
    final userData = Provider.of<ProfileViewModel>(context, listen: false);
    super.didChangeDependencies();
    wallet = double.parse(userData.balance.toString());
    _toss = _TossTween(
      height: MediaQuery.of(context).size.height,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.slowMiddle,
      ),
    );

    _turn = _TurnTween().animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _controller.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  int countdownSeconds = 30;
  Timer? countdownTimer;
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
    final userData = Provider.of<ProfileViewModel>(context, listen: false);
    setState(() {
      if (countdownSeconds == 29) {
        if (fristCome == false) {
          wallet = double.parse(userData.balance.toString());
          userData.profileApi(context);
        } else {
          ImageToast.show(
              imagePath: AppAssets.dragontigerStartbetting,
              heights: 100,
              context: context);
        }

        generateRandomCoin();
      } else if (countdownSeconds == 26) {
        _addCoins(randomCoin);
      } else if (countdownSeconds == 20) {
        if (fristCome == false) {
        } else {
          ImageToast.show(
              imagePath: AppAssets.twsecleft, heights: 100, context: context);
        }
      } else if (countdownSeconds == 13) {
        if (fristCome == false) {
        } else {
          ImageToast.show(
              imagePath: AppAssets.dragontigerStopbetting,
              heights: 100,
              context: context);
          hideButton = true;
        }
      } else if (countdownSeconds == 10) {
        if (fristCome == false) {
        } else {
          if (headCount == 0 && tailCount == 0) {
          } else {
            bettingApi(context);
          }
        }
      } else if (countdownSeconds == 8) {
        if (fristCome == false) {
        } else {
          _controller.forward();
        }
      } else if (countdownSeconds == 4) {
        lastResultView(context);
      } else if (countdownSeconds == 3) {
        if (fristCome == false) {
        } else {
          futurePopUp(context);
          wallet = double.parse(userData.balance.toString());
          userData.profileApi(context);
        }
      } else if (countdownSeconds == 1) {
        fetchData();
        gameWinPopup(context);

        if (fristCome == false) {
        } else {
          Navigator.pop(context);
          hideButton = false;
          countAndCoinClear();
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

  void countAndCoinClear() {
    setState(() {
      headCoins.clear();
      headCount = 0;

      tailCoins.clear();
      tailCount = 0;

      coins1.clear();
      coins2.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userData = Provider.of<ProfileViewModel>(context);
    return fristCome == false
        ? HeadTailPopUp(time: int.parse(countdownSeconds.toString()))
        : AddToCartAnimation(
            cartKey: selectedCart == 1 ? head : tail,
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
              backgroundColor: const Color(0xff780202),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.01),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      gradient: AppColors.loginSecondaryGrad,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                countdownTimer?.cancel();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.whiteColor,
                              )),
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.14,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Assets.imagesSplashImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.14,
                        ),
                        const Text(
                          'HEAD TAIL',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AndarBaharHistory(
                                  gameid: widget.gameId,
                                ); //tittle: widget.tittle,
                              },
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.03,
                                width: height * 0.04,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image:
                                      AssetImage(Assets.andarbaharBetHistory),
                                  fit: BoxFit.fill,
                                )),
                              ),
                              const Text(
                                'History',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              body: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(HeadTailAssets.headTailIcBgTabelHead),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.25,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.05,
                            width: width * 0.9,
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
                                  width: width / 40,
                                ),
                                SizedBox(
                                  height: height / 20,
                                  width: width * 0.7,
                                  //  color: Colors.amber,
                                  child: ListView.builder(
                                    itemCount: items.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: CircleAvatar(
                                          radius: height / 55,
                                          backgroundImage: AssetImage(
                                              items[index].number == 1
                                                  ? HeadTailAssets.headTailHeads
                                                  : HeadTailAssets
                                                      .headTailTails),
                                        ),
                                      );
                                      // return Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(right: 5),
                                      //   child: CircleAvatar(
                                      //     radius: height / 55,
                                      //     backgroundImage: NetworkImage(
                                      //         items[index].images.toString()),
                                      //   ),
                                      // );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: width / 40,
                                ),
                                Image.asset(AppAssets.buttonsIcArrowZigzag,
                                    height: height / 19),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: height * 0.3,
                                width: width * 0.5,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        HeadTailAssets.headTailHeadBg),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCart = 1;
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      height: height * 0.255,
                                      width: width * 0.4,
                                      key: head,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3,
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
                                            top: 10,
                                            child: Stack(
                                              children: coins1,
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              for (var data in headCoins) data,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.3,
                                width: width * 0.5,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        HeadTailAssets.headTailTaleBg),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCart = 2;
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      height: height * 0.255,
                                      width: width * 0.4,
                                      key: tail,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3,
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
                                            top: 10,
                                            child: Stack(
                                              children: coins2,
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              for (var data in tailCoins) data,
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
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height / 9,
                                  width: width * 0.25,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          AppAssets.buttonsRuppePannel),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        gamesNo.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CircleAvatar(
                                                    radius: height / 80,
                                                    backgroundImage:
                                                        const AssetImage(
                                                            HeadTailAssets
                                                                .headTailHeads),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  CircleAvatar(
                                                    radius: height / 80,
                                                    backgroundImage:
                                                        const AssetImage(
                                                            HeadTailAssets
                                                                .headTailTails),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    headCount.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.02,
                                                  ),
                                                  Text(
                                                    tailCount.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: height * 0.1,
                                  width: width * 0.2,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(AppAssets.watch)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    countdownSeconds.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.05,
                              width: width * 0.1,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      AndarAssets.andarbaharIcOnlineUser),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text(
                              randomPeople.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// bottom
                    Container(
                      margin: EdgeInsets.only(top: height * 0.75),
                      height: height * 0.13,
                      width: width * 12,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(AndarAssets.andarbaharIcDtBottomStrip),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.03, top: height * 0.03),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.09, top: height * 0.02),
                              child: Container(
                                height: height * 0.04,
                                width: width * 0.15,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        AndarAssets.andarbaharPlayerWallet),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  wallet.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.22, top: height * 0.02),
                              child: Container(
                                height: height * 0.04,
                                width: width * 0.12,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        AndarAssets.andarbaharAddIconNew),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.32),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: GameHistoryPage(
                                              gameId: widget.gameId),
                                          type: PageTransitionType.topToBottom,
                                          duration: const Duration(
                                              milliseconds: 500)));
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.345,
                              ),
                              child: SizedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: list.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, int index) {
                                    final GlobalKey<CartIconKey> itemKey =
                                        GlobalKey<CartIconKey>();
                                    return hideButton == true
                                        ? HideCoins(list[index])
                                        : InkWell(
                                            onTap: () async {
                                              wallet == 0
                                                  ? Utils.flushBarErrorMessage(
                                                      'Please Recharge',
                                                      context,
                                                      Colors.white)
                                                  : wallet < list[index]
                                                      ? Utils
                                                          .flushBarErrorMessage(
                                                              'Low Balance',
                                                              context,
                                                              Colors.white)
                                                      : Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  1500), () {
                                                          if (selectedCart ==
                                                              1) {
                                                            headCoins.add(Positioned(
                                                                left: randomNo(
                                                                    1, 150),
                                                                top: randomNo(
                                                                    1, 50),
                                                                child: CoindesignNew(
                                                                    list[
                                                                        index])));
                                                          } else if (selectedCart ==
                                                              2) {
                                                            tailCoins.add(Positioned(
                                                                left: randomNo(
                                                                    1, 150),
                                                                top: randomNo(
                                                                    1, 50),
                                                                child: CoindesignNew(
                                                                    list[
                                                                        index])));
                                                          }
                                                          setState(() {
                                                            if (selectedCart ==
                                                                1) {
                                                              headCount =
                                                                  headCount +
                                                                      list[
                                                                          index];
                                                            } else {
                                                              tailCount =
                                                                  tailCount +
                                                                      list[
                                                                          index];
                                                            }
                                                          });
                                                        });
                                              wallet < list[index]
                                                  ? ''
                                                  : listClick(itemKey);

                                              deductAmount(
                                                list[index],
                                              );
                                            },
                                            child: Container(
                                                key: itemKey,
                                                child:
                                                    CoindesignNew(list[index])),
                                          );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.015),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: const AssetImage(
                                    AndarAssets.andarbaharIcons),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage(
                                      userData.userImage.toString()),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (_, Widget? child) => Transform.translate(
                        offset:
                            Offset(size.width / 2 - kCoinRadius, _toss.value),
                        child: Transform(
                          transform: _turn.value,
                          alignment: Alignment.center,
                          child: child,
                        ),
                      ),
                      child: const SizedBox(
                        width: kCoinRadius * 2,
                        height: kCoinRadius * 2,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(HeadTailAssets.headTailTails),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  int gameid = 14;

  List<LastFifteen> items = [];

  Future<void> fetchData() async {
    var gameIds = widget.gameId;
    final response =
        await http.get(Uri.parse("${ApiUrl.result}$gameIds&limit=15"));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => LastFifteen.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

  UserViewModel userProvider = UserViewModel();
  // *betting API*  //
  bettingApi(context) async {
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();

    final betList = [
      {'number': '1', 'amount': headCount.toString()},
      {'number': '2', 'amount': tailCount.toString()},
    ];

    final response = await http.post(
      Uri.parse(ApiUrl.dragonBet),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "userid": userId,
        "game_id": widget.gameId,
        "json": betList,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      ImageToast.show(
          imagePath: AppAssets.bettingplaceds, heights: 100, context: context);
      countAndCoinClear();
    } else {
      Utils.flushBarErrorMessage(
          data['message'].toString(), context, Colors.black);
    }
  }

  var winResult;
  int? gamesNo;

  List<String> stringList = [];
  lastResultView(context) async {
    var gameIds = widget.gameId;
    try {
      final url = Uri.parse('${ApiUrl.result}$gameIds&limit=1');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)["data"][0];
        setState(() {
          winResult = responseData["number"];
          gamesNo = responseData["games_no"] + 1;
          final List<dynamic> cardImage = json.decode(responseData["json"]);
          stringList =
              cardImage.map((dynamic item) => item.toString()).toList();
        });
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load data. $e");
    }
  }

  gameWinPopup(context) async {
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    final response = await http.get(
      Uri.parse('${ApiUrl.winAmount}$userId&game_id=$gameid&games_no=$gamesNo'),
    );

    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
    }
    if (data["status"] == 200) {
      var win = data["win"].toString();
      var result = data["result"].toString();
      var gsm = data["games_no"].toString();

      win == '0'
          ? ImageToastWingo.showloss(
              subtext: result, subtext1: gsm, subtext2: win, context: context)
          : ImageToastWingo.showwin(
              subtext: result,
              subtext1: gsm,
              subtext2: win,
              context: context,
            );
    } else {
      setState(() {
        // loadingGreen = false;
      });
    }
  }

  bool hideButton = false;
  double wallet = 0;

  void deductAmount(int amountToDeduct) {
    if (wallet >= amountToDeduct) {
      setState(() {
        // wallet = (wallet! - amountToDeduct).toInt();
        wallet = (wallet - amountToDeduct).toDouble();
      });
    } else {
      Utils.flushBarErrorMessage('Insufficient funds', context, Colors.white);
    }
  }

  int selectedCart = 1;
  GlobalKey<CartIconKey> head = GlobalKey<CartIconKey>();
  GlobalKey<CartIconKey> tail = GlobalKey<CartIconKey>();
  late Function(GlobalKey<CartIconKey>) runAddToCartAnimation;

  List<int> list = [5, 10, 50, 100, 500];
  int headCount = 0;
  int tailCount = 0;

  List<Widget> headCoins = [];
  List<Widget> tailCoins = [];

  randomNo(int min, int max) {
    Random random = Random();
    return double.parse((min + random.nextInt(max - min + 1)).toString());
  }

  var _cartQuantityItems = 0;

  void listClick(GlobalKey<CartIconKey> itemKey) async {
    await runAddToCartAnimation(itemKey);
    if (selectedCart == 1 && head.currentState != null) {
      head.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Dragon');
    } else if (selectedCart == 2 && tail.currentState != null) {
      tail.currentState!.runCartAnimation((++_cartQuantityItems).toString());
      debugPrint('Selected Cart: Tie');
    }
  }

  List<Widget> coins1 = [];
  List<Widget> coins2 = [];
  void _addCoins(int count) {
    for (int i = 0; i < count; i++) {
      Timer(Duration(milliseconds: i * 200), () {
        setState(() {
          coins1.add(
            const _AnimatedCoin(
              type: 0,
            ),
          );

          coins2.add(
            const _AnimatedCoin(
              type: 1,
            ),
          );
        });
      });
    }
  }

  Future<void> futurePopUp(BuildContext context) async {
    // Show the initial dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          content: SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(winResult == 2
                            ? HeadTailAssets.headTailTails
                            : HeadTailAssets.headTailHeads),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// toss Animation start-----
class _TossTween extends Tween<double> {
  _TossTween({required this.height})
      : super(begin: _lerp(height, 0.0), end: _lerp(height, 1.0));

  final double height;

  @override
  double lerp(double t) => _lerp(height, t);

  static double _lerp(double height, double t) {
    final double top = height / 6;
    final double rad = t * pi * 2 + pi / 2;
    return (height - top) / 2 + (height - top) / 2 * sin(rad) + top;
  }
}

class _TurnTween extends Tween<Matrix4> {
  _TurnTween() : super(begin: _lerp(0.0), end: _lerp(1.0));

  @override
  Matrix4 lerp(double t) => _lerp(t);

  static Matrix4 _lerp(double t) {
    return Matrix4.rotationY(t * pi * 20);
  }
}

/// toss Animation end-----

/// coin animation
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
            begin: const Offset(70, -250),
            end: _randomOffset(100, 150),
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutBack,
            ),
          )
        : Tween<Offset>(
            begin: const Offset(250, -250),
            end: _randomOffset(200, 250),
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOutBack,
            ),
          );

    _controller.forward();
  }

  doublePj(double start, double end) {
    Random random = Random();

    return start + random.nextDouble() * (end - start);
  }

  Offset _randomOffset(double start, double end) {
    double randomPositionX = doublePj(50, 170);
    double randomPositionY = doublePj(50, 130);
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
