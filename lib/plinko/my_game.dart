import 'dart:convert';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/plinko_list_model.dart';
import 'package:game_on/model/plinko_result.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/plinko/lesson_02/objects/ball_dynamic.dart';
import 'package:game_on/plinko/routes.dart';
import 'package:game_on/plinko/utils/plinko_pop_up.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/utils/utils.dart';
import 'lesson_02/objects/balance_hud.dart';
import 'package:http/http.dart' as http;

final screenSize = Vector2(1300, 2000);

final worldSize = Vector2(12.8, 20.0);

class MyGame extends Forge2DGame with KeyboardEvents {
  // Keep track of the number of bodies in the world.
  final totalBodies = TextComponent(position: Vector2(5, 790))
    ..positionType = PositionType.viewport;

  final totalBalance = TextComponent(position: Vector2(5, 690))
    ..positionType = PositionType.viewport;

  // Keep track of the frames per second
  final fps = FpsTextComponent(position: Vector2(5, 765));

  // Scale the screenSize by 100 and set the gravity of 15
  MyGame() : super(zoom: 100, gravity: Vector2(0, 40));

  // late final Hud hud;
  late MyTextBox hud;

  @override
  Future<void> onLoad() async {
    // Set the FixedResolutionViewport
    camera.viewport = FixedResolutionViewport(screenSize);

    // Adds a black background to the viewport
    add(_Background(size: screenSize)..positionType = PositionType.viewport);

    // add(fps);
    // add(totalBodies);
    // add(totalBalance);
  }

  @override
  void update(double dt) {
    super.update(dt);
    totalBodies.text = 'Bodies: ${world.bodies.length}';
    totalBalance.text = 'Balance: ${world.bodies.length}';
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set keysPressed) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.escape)) {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(Routes.menu, (r) => false);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Color backgroundColor() {
    return const Color(0xFF117ea7);
  }

  void onTapDown() {
    final randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0); // Generate a random color
    add(BallDynamic(randomColor));
    // Provide the random color to BallDynamic constructor
  }
}

// Helper component that paints a black background
class _Background extends PositionComponent {
  _Background({super.size});

  @override
  void render(Canvas canvas) {
    final Rect rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final Paint customPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF117ea7),
          Color(0xFF19a99f),
          Color(0xFF117ea7),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(rect);
    canvas.drawRect(rect, customPaint);
  }
}

///

class MyGameWidget extends StatefulWidget {
  final MyGame game;

  const MyGameWidget({super.key, required this.game});

  @override
  State<MyGameWidget> createState() => _MyGameWidgetState();
}

class _MyGameWidgetState extends State<MyGameWidget> {
  int selectedBalls = 1;

  List<String> number = [
    '0.29x',
    '1.39x',
    '2.43x',
    '3.42x',
    '4.39x',
    '5.45x',
    '6.39x',
    '7.52x',
    '8.38x',
    '9.37x',
    '10.39x',
    '11.5x',
    '12.5x',
  ];

  String gameId = "11";

  void decrementCounter() {
    setState(() {
      if (selectedIndex >= initValue) {
        selectedIndex -= initValue;
        amount.text = selectedIndex.toString();
      }
    });
  }

  int selectedIndex = 10;

  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    amount.text = selectedIndex.toString();
    super.initState();
    plinkoRedList(context);
    plinkoYellowList(context);
    plinkoGreenList(context);
    fetchPlinkoBetHistory();
    fetchPlinkoBetHistoryTwo();
  }

  var initValue = 0;

  void incrementCounter() {
    setState(() {
      selectedIndex += initValue;
      amount.text = selectedIndex.toString();
    });
  }

  List<int> list = [
    10,
    20,
    50,
    100,
    200,
    500,
    1000,
    5000,
  ];

  int _selectedIndexes = -1;

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  bool isExpanded = false;
  bool tapValue = false;

  bool loaderOne = false;
  bool loaderTwo = false;
  bool loaderThree = false;

  int? responseStatusCode;

  @override
  Widget build(BuildContext context) {
    final profileView = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF107baa),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const AppBackBtn(),
        title: const Text(
          'PLINKO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textWidget(text: '🪙 ',fontWeight: FontWeight.w900,
                      fontSize: 20),
                  textWidget(
                      text: profileView.balance == null
                          ? ""
                          : profileView.balance.toStringAsFixed(2),
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          Provider.of<ProfileViewModel>(context)
                              .profileApi(context);
                          Utils.flushBarSuccessMessage(
                              'Wallet refresh ✔', context, Colors.white);
                        });
                      },
                      child: Image.asset(Assets.iconsTotalBal, height: 20))
                ],
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PlinkoPopUpPage();
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  height: height * 0.03,
                  width: width * 0.10,
                  decoration: BoxDecoration(
                    // color: Colors.teal,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(
                            0, 3), // Adjust the shadow's position here
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(Assets.iconsBetHistory),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: Container(
          height: height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF095273),
                Color(0xFF117e67),
                Color(0xFF095273),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.8,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: const Color(0xFF097c7f),
                        // Colors.greenAccent,
                        borderRadius: BorderRadius.circular(35)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              '                 Bet',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height: height * 0.03,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(4),
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      color: const Color(0xFF015759),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                    ),
                                    child: Text(
                                      '$selectedIndex 🪙',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    )),
                              ],
                            ),
                            const SizedBox()
                          ],
                        ),
                        InkWell(
                          onTap: decrementCounter,
                          child: Container(
                              margin: EdgeInsets.zero,
                              alignment: Alignment.center,
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(0,
                                          3), // Adjust the shadow's position here
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)),
                              child: const Icon(
                                Icons.remove,
                                size: 20,
                                color: Colors.white,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => betPopUp());
                          },
                          child: Container(
                              margin: EdgeInsets.zero,
                              alignment: Alignment.center,
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(0,
                                          3), // Adjust the shadow's position here
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)),
                              child: Image.asset(
                                'assetss/images/coin/stack.png',
                                height: 20,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            incrementCounter();
                          },
                          child: Container(
                              margin: EdgeInsets.zero,
                              alignment: Alignment.center,
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(0,
                                          3), // Adjust the shadow's position here
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                width: width * 0.9,
                height: height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    loaderOne == false
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                tapValue = !tapValue;
                                _selectedIndexes = 1;
                              });
                              plinkoBet(
                                  amount.text, _selectedIndexes.toString());
                              if (kDebugMode) {
                                print(_selectedIndexes);
                                print("_selectedIndex");
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff337a04),
                                    Color(0xff52960c),
                                    Color(0xff337a04),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(0,
                                        3), // Adjust the shadow's position here
                                  ),
                                ],
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _selectedIndexes == 0
                                      ? Colors.teal
                                      : Colors.black,
                                ),
                              ),
                              child: const Text(
                                'GREEN',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    loaderTwo == false
                        ? InkWell(
                            onTap: () async {
                              // for (int i = 0; i < selectedBalls; i++) {
                              //   await Future.delayed(
                              //       const Duration(seconds: 1));
                              //   widget.game.onTapDown();
                              // }
                              setState(() {
                                tapValue = !tapValue;
                                _selectedIndexes = 2;
                                plinkoBet(
                                    amount.text, _selectedIndexes.toString());
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFc56f00),
                                    Color(0xFFca8605),
                                    Color(0xFFc56f00),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(0,
                                        3), // Adjust the shadow's position here
                                  ),
                                ],
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _selectedIndexes == 1
                                      ? Colors.teal
                                      : Colors.black,
                                ),
                              ),
                              child: const Text(
                                'YELLOW',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    loaderThree == false
                        ? InkWell(
                            onTap: () async {
                              // for (int i = 0; i < selectedBalls; i++) {
                              //   await Future.delayed(
                              //       const Duration(seconds: 1));
                              //   widget.game.onTapDown();
                              // }
                              setState(() {
                                tapValue = !tapValue;
                                _selectedIndexes = 3;
                                plinkoBet(
                                    amount.text, _selectedIndexes.toString());
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFb80118),
                                    Color(0xFFdd0016),
                                    Color(0xFFb80118),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(0,
                                        3), // Adjust the shadow's position here
                                  ),
                                ],
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _selectedIndexes == 2
                                      ? Colors.teal
                                      : Colors.black,
                                ),
                              ),
                              child: const Text(
                                'RED',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GameWidget(
            // addRepaintBoundary: true,
            game: widget.game,
          ),
          // Text('${contact.bodyB.position}'),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 70, 0, 0),
            child: expansionWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.7, left: width * 0.02),
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: plinkoRedItem.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFb80118),
                                Color(0xFFdd0016),
                                Color(0xFFb80118),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: _selectedIndexes == 3
                                  ? const Color(0xffff1f1f)
                                  : Colors.transparent,
                            ),
                          ),
                          margin: const EdgeInsets.all(1),
                          width: width * 0.11,
                          height: height * 0.02,
                          child: Text(
                            plinkoRedItem[index].multiplier.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.65, left: width * 0.02),
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: plinkoYellowItem.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFc56f00),
                                Color(0xFFca8605),
                                Color(0xFFc56f00),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: _selectedIndexes == 2
                                  ? const Color(0xfffff026)
                                  : Colors.transparent,
                            ),
                          ),
                          // color:const Color(0xFFc56f00),
                          margin: const EdgeInsets.all(1),
                          width: width * 0.11,
                          height: height * 0.02,
                          child: Text(
                            plinkoYellowItem[index].multiplier.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.6, left: width * 0.02),
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: plinkoGreenItem.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff337a04),
                                Color(0xff52960c),
                                Color(0xff337a04),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: _selectedIndexes == 1
                                  ? const Color(0xff80ff00)
                                  : Colors.transparent,
                            ),
                          ),
                          // color:const Color(0xFFc56f00),
                          margin: const EdgeInsets.all(1),
                          width: width * 0.11,
                          height: height * 0.02,
                          child: Text(
                            plinkoGreenItem[index].multiplier.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget betPopUp() {
    return Dialog(
      child: Container(
        height: 270,
        width: 300,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF117ea7),
              Color(0xFF19a99f),
              Color(0xFF117ea7),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Bet',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Container(
                height: 240,
                width: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF117ea7),
                      Color(0xFF19a99f),
                      Color(0xFF117ea7),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            crossAxisSpacing: 10, // Spacing between columns
                            mainAxisSpacing: 15, // Spacing between rows
                            childAspectRatio: 3.5),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            initValue = list[index];
                            selectedIndex = initValue;
                            amount.text = initValue.toString();
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: selectedIndex == list[index]
                                    ? const Color(0xFF017c80)
                                    : const Color(0xFF006366),
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(list[index].toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ))),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  Widget expansionWidget() {
    return Container(
      height: isExpanded ? height * 0.2 : height * 0.09,
      width: width,
      decoration: BoxDecoration(
          color: const Color(0xFF0d6e70),
          borderRadius: BorderRadius.circular(25)),
      child: ExpansionTile(
        title: isExpanded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Last Results:",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  GridView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    shrinkWrap: true,
                    itemCount: fetchPlinkoBetTwo.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 2,
                      childAspectRatio: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      const double price = 2; //number[index].price
                      if (price > 1 && price < 2) {
                      } else if (price >= 2 && price < 10) {
                      } else {
                      }
                      return Container(
                        height: height * 0.02,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          gradient: fetchPlinkoBetTwo[index].type == 1
                              ? const LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Colors.green,
                                    Colors.green,
                                  ],
                                )
                              : fetchPlinkoBetTwo[index].type == 2
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFc56f00),
                                        Color(0xFFca8605),
                                        Color(0xFFc56f00),
                                      ],
                                    )
                                  : const LinearGradient(
                                      colors: [
                                        Color(0xFFb80118),
                                        Color(0xFFdd0016),
                                        Color(0xFFb80118),
                                      ],
                                    ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            fetchPlinkoBetTwo[index]
                                .multipler
                                .toString(), //${number[index].price.toStringAsFixed(2)}
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            : SizedBox(
                height: height * 0.04,
                width: width,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: fetchPlinkoBet.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      const double price = 1; //number[index].price
                      if (price > 1 && price < 2) {
                      } else if (price >= 2 && price < 10) {
                      } else {
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
                        child: Container(
                          width: width * 0.08, //529f05 //479103
                          decoration: BoxDecoration(
                            gradient: fetchPlinkoBet[index].type == 1
                                ? const LinearGradient(
                                    colors: [
                                      Colors.green,
                                      Colors.green,
                                      Colors.green,
                                    ],
                                  )
                                : fetchPlinkoBet[index].type == 2
                                    ? const LinearGradient(
                                        colors: [
                                          Color(0xFFc56f00),
                                          Color(0xFFca8605),
                                          Color(0xFFc56f00),
                                        ],
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color(0xFFb80118),
                                          Color(0xFFdd0016),
                                          Color(0xFFb80118),
                                        ],
                                      ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text(
                              fetchPlinkoBet[index].multipler.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
        onExpansionChanged: (value) {
          setState(() {
            fetchPlinkoBetHistoryTwo();
            isExpanded = value;
          });
        },
        trailing: Container(
          alignment: Alignment.center,
          height: height * 0.04,
          width: width * 0.15,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(color: Colors.black.withOpacity(0.5)),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.history,
                size: 18,
                color: Colors.white,
              ),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  UserViewModel userProvider = UserViewModel();
  plinkoBet(String amount, String type) async {
    setState(() {
      if (type == '1') {
        loaderOne = true;
      } else if (type == '2') {
        loaderTwo = true;
      } else {
        loaderThree = true;
      }
    });
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.post(
      Uri.parse(ApiUrl.plinkoBet),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid": token,
        "game_id": gameId,
        "amount": amount,
        "type": type
      }),
    );
    print(gameId);
    print("gameid");
    print(amount);
    print("amount plinko");
    print(type);
    print("type");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      for (int i = 0; i < selectedBalls; i++) {
        await Future.delayed(const Duration(seconds: 1));
        widget.game.onTapDown();
      }
      setState(() {
        Provider.of<ProfileViewModel>(context).profileApi(context);

        if (type == '1') {
          loaderOne = false;
        } else if (type == '2') {
          loaderTwo = false;
        } else {
          loaderThree = false;
        }
      });

      Fluttertoast.showToast(msg: responseData['message']);
      await Future.delayed(const Duration(seconds: 15), () {
        fetchPlinkoBetHistory();
        setState(() {
          Provider.of<ProfileViewModel>(context).profileApi(context);
        });
      });
    } else {
      //setRegLoading(false);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      setState(() {
        if (type == '1') {
          loaderOne = false;
        } else if (type == '2') {
          loaderTwo = false;
        } else {
          loaderThree = false;
        }
      });
      return Fluttertoast.showToast(msg: responseData['message']);
    }
  }

  List<PlinkoIndexModal> plinkoRedItem = [];
  Future<void> plinkoRedList(context) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.plinkoList}3"),
    );
    if (kDebugMode) {
      print("${ApiUrl.plinkoList}3");
      print('okay in plinko');
    }

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      Provider.of<ProfileViewModel>(context).profileApi(context);
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        plinkoRedItem = responseData
            .map((item) => PlinkoIndexModal.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        plinkoRedItem = [];
      });
      throw Exception('Failed to load data');
    }
  }

  List<PlinkoIndexModal> plinkoYellowItem = [];
  Future<void> plinkoYellowList(context) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.plinkoList}2"),
    );
    if (kDebugMode) {
      print("${ApiUrl.plinkoList}2");
      print('plinkoList');
    }

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      Provider.of<ProfileViewModel>(context).profileApi(context);
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        plinkoYellowItem = responseData
            .map((item) => PlinkoIndexModal.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        plinkoYellowItem = [];
      });
      throw Exception('Failed to load data');
    }
  }

  List<PlinkoIndexModal> plinkoGreenItem = [];
  Future<void> plinkoGreenList(context) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.plinkoList}1"),
    );
    if (kDebugMode) {
      print("${ApiUrl.plinkoList}1");
      print('plinkoList');
    }

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      Provider.of<ProfileViewModel>(context).profileApi(context);
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        plinkoGreenItem = responseData
            .map((item) => PlinkoIndexModal.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        plinkoGreenItem = [];
      });
      throw Exception('Failed to load data');
    }
  }

  List<PlinkoBetHistory> fetchPlinkoBet = [];
  Future<void> fetchPlinkoBetHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse("${ApiUrl.plinkoBetHistory}userid=$token&limit=7"),
    );

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        fetchPlinkoBet = responseData
            .map((item) => PlinkoBetHistory.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        fetchPlinkoBet = [];
      });
      throw Exception('Failed to load data');
    }
  }
  List<PlinkoBetHistory> fetchPlinkoBetTwo = [];
  Future<void> fetchPlinkoBetHistoryTwo() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse("${ApiUrl.plinkoBetHistory}userid=$token&limit=15"),
    );

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        fetchPlinkoBetTwo = responseData
            .map((item) => PlinkoBetHistory.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        fetchPlinkoBetTwo = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
