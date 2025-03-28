import 'dart:math';

import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/person_profile.dart';
import 'package:game_on/view/home/rummy/teen_patti/user_interface/components/slideshow_overlay.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:provider/provider.dart';

import '../../../../../../material_imports.dart';

class UserControlPanelSection extends StatelessWidget {
  const UserControlPanelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      final mePlayer = gameCon.gameData!['players']
          .firstWhere((e) => e['id'] == gameCon.currentUserData!.id);
      bool isBlind = mePlayer['isBlind'];
      bool isMyTurn = mePlayer['id'] == gameCon.gameData!['current_turn'];
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          ContBox(
            height: Sizes.screenHeight / 4.5,
            padding: const EdgeInsets.all(0),
            clipBehavior: Clip.none,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                actionButton("Slide show", isButtonEnabled: isMyTurn,
                    onTap: () {
                  gameCon.getSlideShow();
                }),
                actionButton("See card", isButtonEnabled: isMyTurn, onTap: () {
                  gameCon.playerSeenCard(mePlayer['id']);
                }),
                Sizes.spaceW10,
                Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(Sizes.screenWidth > 1000 ? (-pi / 7) : (-pi / 6)),
                  child: ContBox(
                    width: Sizes.screenWidth / 4,
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        // Positioned(
                        //     top: -Sizes.screenHeight / 5.3,
                        //     child: HalfCircleArc()),
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children:
                              List.generate(mePlayer['hand'].length, (index) {
                            final card = mePlayer['hand'][index]['imageUrl'];
                            double top = -50.0;
                            double left = 0.0;
                            double angle = 0.0;

                            if (index == 0) {
                              top = -48;
                              left = Sizes.screenWidth / 13;
                              angle = -0.5;
                            } else if (index == 1) {
                              top = -52;
                              angle = 0.0;
                              left = Sizes.screenWidth / 10;
                            } else if (index == 2) {
                              top = -47;
                              left = Sizes.screenWidth / 8;
                              angle = 0.4;
                            }
                            return Positioned(
                              top: top,
                              left: left,
                              child: Transform.rotate(
                                angle: angle,
                                child: cardImage(
                                    isBlind ? Assets.diamondsBack : card),
                              ),
                            );
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addSubButton("—", onTap: () {
                              gameCon.updateBetAmount('-');
                            }),
                            Column(
                              children: [
                                PersonProfile(
                                  Assets.teenPattiLadyImg,
                                  isPlayerTurn: isMyTurn,
                                  isPlaying: mePlayer['playerStatus'] == 1,
                                  playerId: mePlayer['id'],
                                ),
                                ContBox(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 1),
                                    child: CText(
                                      "${gameCon.betPlacedAmount}",
                                      color: Colors.black,
                                      size: Sizes.fontSize8,
                                    )),
                                Sizes.spaceH1P5,
                              ],
                            ),
                            addSubButton("+", onTap: () {
                              gameCon.updateBetAmount(
                                '+',
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Sizes.spaceW10,
                actionButton("Pack", isButtonEnabled: isMyTurn),
                actionButton("Place bet", onTap: () {
                  gameCon.placeBet(isBlind);
                }, isButtonEnabled: isMyTurn),
              ],
            ),
          ),
          const SlideshowOverlay()
        ],
      );
    });
  }

  Widget cardImage(String cardImage) {
    return ContBox(
      height: Sizes.screenWidth / 14,
      width: Sizes.screenWidth / 21,
      boxShadow: const [BoxShadow(offset: Offset(-.5, 0), color: Colors.grey)],
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(image: AssetImage(cardImage), fit: BoxFit.fill),
    );
  }

  Widget actionButton(String label,
      {void Function()? onTap, bool isButtonEnabled = true}) {
    return ContBox(
      onTap: isButtonEnabled ? onTap : null,
      gradient: LinearGradient(
        colors: isButtonEnabled
            ? [
                const Color(0xffD4145A),
                const Color(0xffFBB03B),
              ]
            : [Colors.grey, Colors.grey.shade500],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      height: Sizes.screenWidth / 25,
      width: Sizes.screenWidth / 8,
      radius: 5,
      color: Colors.lightBlue,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: CText(
        label,
        size: Sizes.fontSize(7),
        color: Colors.white,
        weight: FontWeight.w600,
      ),
    );
  }

  Widget addSubButton(String val, {void Function()? onTap}) {
    return ContBox(
      onTap: onTap,
      color: Colors.white,
      gradient: const LinearGradient(
        colors: [
          Color(0xffD4145A),
          Color(0xffFBB03B),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      boxShadow: const [
        BoxShadow(
            offset: Offset(
              1,
              1,
            ),
            color: Colors.black54,
            blurRadius: 3,
            spreadRadius: 0)
      ],
      height: 25,
      width: 40,
      padding: const EdgeInsets.all(0),
      child: CText(
        val,
        size: Sizes.fontSize10,
        color: Colors.white,
        weight: FontWeight.w700,
      ),
    );
  }
}
