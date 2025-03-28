import 'dart:math';

import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/person_profile.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/players_positioning.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/card_throw_animaton.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:provider/provider.dart';

import '../../../../../material_imports.dart';

class CardDistributionScreenActivity extends StatefulWidget {
  final int cardPerPlayer;
  final bool isAnimationAllowed;

  const CardDistributionScreenActivity(
      {super.key,
      required this.cardPerPlayer,
      this.isAnimationAllowed = false});

  @override
  State<CardDistributionScreenActivity> createState() =>
      _CardDistributionScreenActivityState();
}

class _CardDistributionScreenActivityState
    extends State<CardDistributionScreenActivity>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (widget.isAnimationAllowed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<CardThrowAnimation>(context, listen: false)
            .startAnimation(this, widget.cardPerPlayer);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardThrow = Provider.of<CardThrowAnimation>(context);
    if (cardThrow.animation == null || cardThrow.controller == null) {
      return const Scaffold();
    }
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      final mePlayer = gameCon.gameData!['players']
          .firstWhere((e) => e['id'] == gameCon.currentUserData!.id);
      return Scaffold(
        body: ContBox(
          height: Sizes.screenWidth,
          width: Sizes.screenWidth,
          alignment: Alignment.center,
          image: const DecorationImage(
              image: AssetImage('assets/home_bg.png'), fit: BoxFit.fill),
          padding: EdgeInsets.fromLTRB(Sizes.screenWidth * 0.03, 0,
              Sizes.screenWidth * 0.03, Sizes.screenWidth * 0.005),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: Sizes.screenHeight / 8,
                child: Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(Sizes.screenWidth > 1000 ? (-pi / 4) : (-pi / 4)),
                  child: ContBox(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.all(0),
                    height: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                        ? Sizes.screenWidth / 2.5
                        : Sizes.screenWidth / 3,
                    width: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                        ? Sizes.screenWidth / 1.15
                        : Sizes.screenWidth / 1.4,
                    alignment: Alignment.topCenter,
                    image: const DecorationImage(
                        image: AssetImage(Assets.teenPattiGameB),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter),
                    child: Image.asset(
                      Assets.teenPattiLadyImg,
                      width: Sizes.screenWidth < 1000
                          ? Sizes.screenWidth / 10
                          : Sizes.screenWidth / 8.5,
                    ),
                  ),
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                ContBox(
                    height: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                        ? Sizes.screenWidth / 3.45
                        : Sizes.screenWidth / 4.5,
                    clipBehavior: Clip.none,
                    child: const PlayerPositioning()),
                // UserControlPanelSection(),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    if (gameCon.gameData!['game_event']['status'] == 3)
                      Positioned(
                          top: -Sizes.screenHeight / 9,
                          child: cardImage(
                              mePlayer['tossCard'],
                              gameCon.gameData!['toss_winner_id'] ==
                                  mePlayer['id'])),
                    PersonProfile(
                      Assets.personPersonLady,
                      playerId: mePlayer['id'],
                    ),
                  ],
                ),
                Sizes.spaceH15
              ])
            ],
          ),
        ),
      );
    });
  }

  Widget cardImage(String cardImg, bool isWinner) {
    return ContBox(
      border: isWinner ? Border.all(color: Colors.green, width: 3) : null,
      // height: Sizes.screenWidth / 14,
      // width: Sizes.screenWidth / 21,
      height: Sizes.screenWidth / 20,
      width: Sizes.screenWidth / 30,
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(image: AssetImage(cardImg), fit: BoxFit.fill),
    );
  }
}

class ThreeCardDistributionScreenActivity extends StatefulWidget {
  final int cardPerPlayer;
  final bool isAnimationAllowed;

  const ThreeCardDistributionScreenActivity(
      {super.key,
      required this.cardPerPlayer,
      this.isAnimationAllowed = false});

  @override
  State<ThreeCardDistributionScreenActivity> createState() =>
      _ThreeCardDistributionScreenActivityState();
}

class _ThreeCardDistributionScreenActivityState
    extends State<ThreeCardDistributionScreenActivity>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (widget.isAnimationAllowed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<CardThrowAnimation>(context, listen: false)
            .startAnimation(this, widget.cardPerPlayer);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardThrow = Provider.of<CardThrowAnimation>(context);
    if (cardThrow.animation == null || cardThrow.controller == null) {
      return const Scaffold();
    }
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      final mePlayer = gameCon.gameData!['players']
          .firstWhere((e) => e['id'] == gameCon.currentUserData!.id);
      return Scaffold(
        body: ContBox(
          height: Sizes.screenWidth,
          width: Sizes.screenWidth,
          alignment: Alignment.center,
          image: const DecorationImage(
              image: AssetImage('assets/home_bg.png'), fit: BoxFit.fill),
          padding: EdgeInsets.fromLTRB(Sizes.screenWidth * 0.03, 0,
              Sizes.screenWidth * 0.03, Sizes.screenWidth * 0.005),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: Sizes.screenHeight / 8,
                child: Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(Sizes.screenWidth > 1000 ? (-pi / 4) : (-pi / 4)),
                  child: ContBox(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.all(0),
                    height: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                        ? Sizes.screenWidth / 2.5
                        : Sizes.screenWidth / 3,
                    width: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                        ? Sizes.screenWidth / 1.15
                        : Sizes.screenWidth / 1.4,
                    alignment: Alignment.topCenter,
                    image: const DecorationImage(
                        image: AssetImage(Assets.teenPattiGameB),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter),
                    child: Image.asset(
                      Assets.teenPattiLadyImg,
                      width: Sizes.screenWidth < 1000
                          ? Sizes.screenWidth / 10
                          : Sizes.screenWidth / 8.5,
                    ),
                  ),
                ),
              ),

              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                ContBox(
                    height: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
                        ? Sizes.screenWidth / 3.45
                        : Sizes.screenWidth / 4.5,
                    clipBehavior: Clip.none,
                    child: const PlayerPositioning()),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    if (gameCon.gameData!['game_event']['status'] == 3)
                      Positioned(
                          top: -Sizes.screenHeight / 8,
                          child: cardImage(mePlayer['tossCard'])),
                    PersonProfile(
                      Assets.personPersonLady,
                      playerId: mePlayer['id'],
                    ),
                  ],
                ),
                Sizes.spaceH15
              ])

              // PlayerPositioning(),
              // Column(
              //   children: [
              //     Positioned(
              //       bottom: 50,
              //       left: 2,
              //       child: ContBox(
              //         width: Sizes.screenWidth,
              //         color: Colors.red.withOpacity(0.4),
              //       child: PlayerPositioning(),
              //       ),
              //     ),
              //   ],
              // )
              // ContBox(
              //   // color: Colors.red,
              //     height: Sizes.screenHeight / 2,
              //     clipBehavior: Clip.none,
              //     child: Stack(
              //       alignment: Alignment.center,
              //       children: [
              //         PlayerPositioning(),
              //         Builder(builder: (context) {
              //           if (gameCon.gameData!['game_event']['status'] == 2) {
              //             return ContBox(
              //               width: Sizes.screenWidth / 7,
              //               height: Sizes.screenWidth / 9,
              //               child: Image.asset(Assets.assetsTossImg),
              //             );
              //           }
              //           final tossWinnerData = gameCon.gameData!['players']
              //               .firstWhere((e) =>
              //                   gameCon.gameData!['toss_winner_id'] == e['id']);
              //
              //           return Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               CText("Toss winner card"),
              //               ContBox(
              //                 width: Sizes.screenWidth / 7,
              //                 height: Sizes.screenWidth / 9,
              //                 child:
              //                     cardImage(tossWinnerData['tossCard'], false),
              //               ),
              //             ],
              //           );
              //         })
              //       ],
              //     )),
              // Spacer(),
              // Stack(
              //   alignment: Alignment.center,
              //   clipBehavior: Clip.none,
              //   children: [
              //     if (gameCon.gameData!['game_event']['status'] == 3)
              //       Positioned(
              //           top: -Sizes.screenHeight / 8,
              //           child: cardImage(
              //               mePlayer['tossCard'],
              //               gameCon.gameData!['toss_winner_id'] ==
              //                   mePlayer['id'])),
              //     PersonProfile(
              //       Assets.personPersonLady,
              //       playerId: mePlayer['id'],
              //     ),
              //   ],
              // )

              // Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              //   ContBox(
              //       height: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
              //           ? Sizes.screenWidth / 3.45
              //           : Sizes.screenWidth / 4.5,
              //       clipBehavior: Clip.none,
              //       child: PlayerPositioning()),
              // ])
              // ContBox(
              //     height: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
              //         ? Sizes.screenWidth / 3.45
              //         : Sizes.screenWidth / 4.5,
              //     clipBehavior: Clip.none,
              //     child: PlayerPositioning()),
              // Center(
              //   child: ContBox(
              //     onTap: () {},
              //     color: Colors.black,
              //     padding: EdgeInsets.all(0),
              //     height: Sizes.screenWidth > 1000
              //         ? Sizes.screenHeight / 1.25
              //         : Sizes.screenHeight,
              //     width: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
              //         ? Sizes.screenWidth
              //         : Sizes.screenWidth,
              //     alignment: Alignment.bottomCenter,
              //     image: DecorationImage(
              //         image: AssetImage(Assets.assetsGameB),
              //         fit: BoxFit.contain,
              //         alignment: Alignment.topCenter),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             CText(
              //               "Game room: ${gameCon.roomCode}",
              //               color: Colors.white,
              //               width: Sizes.screenWidth / 4,
              //               margin: EdgeInsets.only(top: 10),
              //               weight: FontWeight.w600,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 Provider.of<CardThrowAnimation>(context,
              //                         listen: false)
              //                     .startAnimation(this, 3);
              //               },
              //               child: Image.asset(
              //                 Assets.assetsLadyImg,
              //                 width: Sizes.screenWidth / 9,
              //               ),
              //             ),
              //             CText(
              //               alignment: Alignment.centerRight,
              //               "Wallet balance: ${gameCon.walletBalance}",
              //               color: Colors.white,
              //               width: Sizes.screenWidth / 4,
              //               margin: EdgeInsets.only(top: 10),
              //               weight: FontWeight.w600,
              //             ),
              //           ],
              //         ),
              //         // Spacer(),
              //         ContBox(
              //             height: Sizes.screenHeight / 2,
              //             clipBehavior: Clip.none,
              //             child: Stack(
              //               alignment: Alignment.center,
              //               children: [
              //                 PlayerPositioning(),
              //                 Builder(builder: (context) {
              //                   if (gameCon.gameData!['game_event']['status'] ==
              //                       2) {
              //                     return ContBox(
              //                       width: Sizes.screenWidth / 7,
              //                       height: Sizes.screenWidth / 9,
              //                       child: Image.asset(Assets.assetsTossImg),
              //                     );
              //                   }
              //                   final tossWinnerData = gameCon.gameData!['players']
              //                       .firstWhere((e) =>
              //                           gameCon.gameData!['toss_winner_id'] ==
              //                           e['id']);
              //
              //                   return Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       CText("Toss winner card"),
              //                       ContBox(
              //                         width: Sizes.screenWidth / 7,
              //                         height: Sizes.screenWidth / 9,
              //                         child: cardImage(
              //                             tossWinnerData['tossCard'], false),
              //                       ),
              //                     ],
              //                   );
              //                 })
              //               ],
              //             )),
              //         Spacer(),
              //         Stack(
              //           alignment: Alignment.center,
              //           clipBehavior: Clip.none,
              //           children: [
              //             if (gameCon.gameData!['game_event']['status'] == 3)
              //               Positioned(
              //                   top: -Sizes.screenHeight / 8,
              //                   child: cardImage(
              //                       mePlayer['tossCard'],
              //                       gameCon.gameData!['toss_winner_id'] ==
              //                           mePlayer['id'])),
              //             PersonProfile(
              //               Assets.personPersonLady,
              //               playerId: mePlayer['id'],
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        // ContBox(
        //   color: Colors.black,
        //   height: Sizes.screenWidth,
        //   width: Sizes.screenWidth,
        //   alignment: Alignment.center,
        //   image: DecorationImage(
        //       image: AssetImage('assets/home_bg.png'), fit: BoxFit.fill),
        //   padding: EdgeInsets.fromLTRB(Sizes.screenWidth * 0.03, 0,
        //       Sizes.screenWidth * 0.03, Sizes.screenWidth * 0.005),
        //   child: ContBox(
        //     padding: EdgeInsets.all(0),
        //     height: Sizes.screenWidth > 1000
        //         ? Sizes.screenHeight / 1.25
        //         : Sizes.screenHeight,
        //     width: Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
        //         ? Sizes.screenWidth
        //         : Sizes.screenWidth,
        //     alignment: Alignment.bottomCenter,
        //     image: DecorationImage(
        //         image: AssetImage(Assets.assetsGameB),
        //         fit: BoxFit.contain,
        //         alignment: Alignment.topCenter),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             CText(
        //               "Game room: ${gameCon.roomCode}",
        //               color: Colors.white,
        //               width: Sizes.screenWidth / 4,
        //               margin: EdgeInsets.only(top: 10),
        //               weight: FontWeight.w600,
        //             ),
        //             InkWell(
        //               onTap: () {
        //                 Provider.of<CardThrowAnimation>(context,
        //                         listen: false)
        //                     .startAnimation(this, 3);
        //               },
        //               child: Image.asset(
        //                 Assets.assetsLadyImg,
        //                 width: Sizes.screenWidth / 9,
        //               ),
        //             ),
        //             CText(
        //               alignment: Alignment.centerRight,
        //               "Wallet balance: ${gameCon.walletBalance}",
        //               color: Colors.white,
        //               width: Sizes.screenWidth / 4,
        //               margin: EdgeInsets.only(top: 10),
        //               weight: FontWeight.w600,
        //             ),
        //           ],
        //         ),
        //         // Spacer(),
        //         ContBox(
        //             height: Sizes.screenHeight / 2,
        //             clipBehavior: Clip.none,
        //             child: Stack(
        //               alignment: Alignment.center,
        //               children: [
        //                 PlayerPositioning(),
        //                 Builder(builder: (context) {
        //                   if (gameCon.gameData!['game_event']['status'] ==
        //                       2) {
        //                     return ContBox(
        //                       width: Sizes.screenWidth / 7,
        //                       height: Sizes.screenWidth / 9,
        //                       child: Image.asset(Assets.assetsTossImg),
        //                     );
        //                   }
        //                   final tossWinnerData = gameCon.gameData!['players']
        //                       .firstWhere((e) =>
        //                           gameCon.gameData!['toss_winner_id'] ==
        //                           e['id']);
        //
        //                   return ContBox(
        //                     width: Sizes.screenWidth / 7,
        //                     height: Sizes.screenWidth / 9,
        //                     child: cardImage(tossWinnerData['tossCard']),
        //                   );
        //                 })
        //               ],
        //             )),
        //         Spacer(),
        //
        //         Stack(
        //           alignment: Alignment.center,
        //           clipBehavior: Clip.none,
        //           children: [
        //             // if (gameCon.gameData!['game_event']['status'] == 3)
        //               Positioned(
        //                   top: -Sizes.screenHeight / 8,
        //                   child: cardImage(mePlayer['tossCard'])),
        //             PersonProfile(
        //               Assets.personPersonLady,
        //               playerId: mePlayer['id'],
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      );
    });
  }

  Widget cardImage(String cardImg) {
    return ContBox(
      height: Sizes.screenWidth / 20,
      width: Sizes.screenWidth / 30,
      // height: Sizes.screenWidth / 14,
      // width: Sizes.screenWidth / 21,
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(image: AssetImage(cardImg)),
    );
  }
}
