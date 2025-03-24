import 'dart:async';
import 'package:flutter/services.dart';
import 'package:globalbet/Plinko/my_game.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/plinko/lesson_02/game_lesson_02.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/view/home/casino/AndarBahar/andar_home_page.dart';
import 'package:globalbet/view/home/casino/dragon_tiger_new/dragon_tiger.dart';
import 'package:globalbet/view/home/casino/lucky_card_12/lucky_card_12.dart';
import 'package:globalbet/view/home/casino/lucky_card_16/lucky_card_16.dart';
import 'package:globalbet/view/home/casino/triple_chance/triple_chance.dart';
import 'package:globalbet/view/home/lottery/trx/trx.dart';
import 'package:globalbet/view/home/lottery/wingo/win_go.dart';
import 'package:globalbet/view/home/mini/Aviator/home_page_aviator.dart';
import 'package:globalbet/view/home/mini/HeadTail/head_tail_home.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/keno_home.dart';
import 'package:globalbet/view/home/mini/mines/mines.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view/titli_home.dart';

class CategoryElement extends StatefulWidget {
  final int selectedCategoryIndex;
  const CategoryElement({super.key, required this.selectedCategoryIndex});

  @override
  State<CategoryElement> createState() => _CategoryElementState();
}

class _CategoryElementState extends State<CategoryElement> {
  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  int countdownSeconds = 60;
  Timer? countdownTimer;
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
      if (countdownSeconds == 60) {
      } else if (countdownSeconds == 1) {
        // Do something
      }
      countdownSeconds = (countdownSeconds - 1) % 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MiniGameModel> originalGameList = [
      MiniGameModel(
          image: Assets.categoryPlinko,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyGameWidget(game: PlinkoMains())),
            );
          }),
      MiniGameModel(
          image: Assets.titliGamePic,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TitliHomeScreen()),
            );
          }),
      MiniGameModel(
          image: Assets.categoryMines,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Mines()),
            );
          }),
      MiniGameModel(
          image: Assets.categoryAviator,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const GameAviator()),
            );
          }),
      MiniGameModel(
          image: Assets.categoryKeno,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const KenoGame()),
            );
          }),
      MiniGameModel(
          image: Assets.categoryHeadsTailsCat,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HeadTailHome(gameId: '14', tittle: 'Head & Tail',)),
            );
          }),
    ];
    List<MiniGameModel> lotteryGameList = [
      MiniGameModel(
          image: Assets.categoryWingo,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WinGo()));
          }),
      MiniGameModel(
          image: Assets.categoryTrxCol,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Trx()),
            );
          }),
    ];
    List<MiniGameModel> casinoGameList = [
      MiniGameModel(
          image: Assets.categoryLimbo,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DragonTiger(gameId: '10')));
          }),
      MiniGameModel(
          image: Assets.categoryAndarBaharCat,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AndarBaharHome(gameId: '13',)),
            );
          }),
      MiniGameModel(
          image: Assets.categoryDLucky12,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LuckyCard12()),
            );
          }),
      MiniGameModel(
          image: Assets.categoryDLucky16,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LuckyCard16()),
            );
          }),
      MiniGameModel(
          image: Assets.categoryDTripleChance,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TripleChance()),
            );
          }),
    ];
    return widget.selectedCategoryIndex == 0
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: AppColors.primaryContColor,
                      size: 30,
                    ),
                    Text(
                      "Lottery".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: lotteryGameList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: lotteryGameList[index].onTap,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          height: height * 0.25,
                          width: width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  lotteryGameList[index].image,
                                ),
                              )),
                          //  color: Colors.deepPurpleAccent,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        : widget.selectedCategoryIndex == 1
            ?
            Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    height: height * 0.05,
                                    width: width * 0.05,
                                    child: const VerticalDivider(
                                      thickness: 3,
                                      color: AppColors.gradientFirstColor,
                                    )),
                                Text(
                                  " Original".toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 9.0,
                                // childAspectRatio: 1.5
                              ),
                              shrinkWrap: true,
                              itemCount: originalGameList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: originalGameList[index].onTap,
                                  child: Center(
                                    child: Container(
                                      height: height * 0.25,
                                      width: width * 0.5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              originalGameList[index].image,
                                            ),
                                          )),
                                      //  color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
            : widget.selectedCategoryIndex == 2
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: height * 0.05,
                                width: width * 0.05,
                                child: const VerticalDivider(
                                  thickness: 3,
                                  color: AppColors.gradientFirstColor,
                                )),
                            Text(
                              " Casino".toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // crossAxisSpacing: 8.0,
                            // mainAxisSpacing: 2.0,
                            // childAspectRatio: 1.6
                          ),
                          shrinkWrap: true,
                          itemCount: casinoGameList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: casinoGameList[index].onTap,
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  height: height * 0.25,
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          casinoGameList[index].image,
                                        ),
                                      )),
                                  //  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Image.asset(
                    Assets.imagesCommingsoon,
                    fit: BoxFit.cover,
                    height: height * 0.25,
                    width: width * 0.8,
                  );
  }

  lotteryContainer(double height, double width, String title, String subtitle,
      VoidCallback onTap, String imagePath) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.2,
        width: width * 0.9,
        decoration: BoxDecoration(
            gradient: AppColors.primaryUnselectedGradient,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.15,
              width: width * 0.24,
              decoration: BoxDecoration(
                  gradient: AppColors.btnBlueGradient,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(imagePath),
            ),
            SizedBox(
              height: height * 0.15,
              width: width * 0.55,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Container(
                        height: height * 0.04,
                        width: width * 0.22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: AppColors.loginSecondaryGrad,
                        ),
                        child: const Center(
                          child: Text(
                            "GO →",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: height * 0.04,
                      width: width * 0.52,
                      decoration: BoxDecoration(
                          gradient: AppColors.buttonGradient,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "   The Hightest bonus in history",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8),
                          ),
                          Container(
                            height: height * 0.03,
                            width: width * 0.005,
                            color: Colors.white,
                          ),
                          const Text(
                            "0.00",
                            style: TextStyle(
                                color: AppColors.gradientFirstColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.02,
                        width: width * 0.005,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: width * 0.48,
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LotteryModel {
  final String titleText;
  final String subTitleText;
  final String gameText;
  final String? member;
  final String? memberImage;
  final String decorationImage;
  final String? decoImage;
  final String? winAmount;
  final VoidCallback? onTap;
  LotteryModel(
      {required this.titleText,
      required this.subTitleText,
      required this.gameText,
      this.member,
      this.memberImage,
      required this.decorationImage,
      this.decoImage,
      this.winAmount,
      this.onTap});
}

class MiniGameModel {
  final String image;
  final VoidCallback? onTap;
  MiniGameModel({required this.image, this.onTap});
}

class RummylistModel {
  final String image;
  final VoidCallback? onTap;
  RummylistModel({required this.image, this.onTap});
}
