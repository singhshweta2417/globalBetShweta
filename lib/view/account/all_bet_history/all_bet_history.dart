import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/view/account/all_bet_history/aviator_all_bet_history.dart';
import 'package:game_on/view/account/all_bet_history/dragon_tiger_all_history.dart';
import 'package:game_on/view/account/all_bet_history/plinko_history.dart';
import 'package:game_on/view/account/all_bet_history/trx_all_history.dart';
import 'package:game_on/view/account/all_bet_history/wingo_all_history.dart';

class AllBetHistory extends StatefulWidget {
  const AllBetHistory({super.key});

  @override
  State<AllBetHistory> createState() => _AllBetHistoryState();
}

class _AllBetHistoryState extends State<AllBetHistory> {
  int selectedIndex = 0;

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                )),
          ),
          centerTitle: true,
          title: textWidget(
            text: 'All Bet History',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
          gradient: AppColors.unSelectedColor),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            width: 400,
            height: 80,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                selectableContainer(
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    selectIndex(0);
                  },
                  text: 'Wingo',
                  imagePath: Assets.categoryWingoCoin1,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    selectIndex(2);
                  },
                  text: 'Dragon Tiger',
                  imagePath: Assets.dragontigerDragonTigerAni,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 3,
                  onTap: () {
                    selectIndex(3);
                  },
                  text: 'Aviator',
                  imagePath: Assets.aviatorFanAviator,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 4,
                  onTap: () {
                    selectIndex(4);
                  },
                  text: 'Plinko',
                  imagePath: Assets.iconsPlonkoicon,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 5,
                  onTap: () {
                    selectIndex(5);
                  },
                  text: 'Andar Bahar',
                  imagePath: Assets.andarbaharHomeAndharBhar,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 6,
                  onTap: () {
                    selectIndex(6);
                  },
                  text: 'Mine',
                  imagePath: Assets.minesMine,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 7,
                  onTap: () {
                    selectIndex(7);
                  },
                  text: 'FunTarget',
                  imagePath: Assets.funTargetBadaChakra,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 8,
                  onTap: () {
                    selectIndex(8);
                  },
                  text: 'Trx',
                  imagePath: Assets.categoryTrxCoin1,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 9,
                  onTap: () {
                    selectIndex(9);
                  },
                  text: '7UpDown',
                  imagePath: Assets.sevenUpDownNewLoading7,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 10,
                  onTap: () {
                    selectIndex(10);
                  },
                  text: '16 Card',
                  imagePath: Assets.lucky16L16SecondWheel,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 11,
                  onTap: () {
                    selectIndex(11);
                  },
                  text: '12 Card',
                  imagePath: Assets.lucky12L12FirstWheel,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 12,
                  onTap: () {
                    selectIndex(12);
                  },
                  text: 'Triple Chance',
                  imagePath: Assets.tripleChanceThirdWheel,
                ),
                selectableContainer(
                  isSelected: selectedIndex ==13,
                  onTap: () {
                    selectIndex(13);
                  },
                  text: 'Spin to win',
                  imagePath: Assets.spinSSecondWheel,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 14,
                  onTap: () {
                    selectIndex(14);
                  },
                  text: 'Kino',
                  imagePath: Assets.categoryKeno,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 15,
                  onTap: () {
                    selectIndex(15);
                  },
                  text: 'Titli Kabootar',
                  imagePath: Assets.titliButterFly,
                ),
                selectableContainer(
                  isSelected: selectedIndex == 16,
                  onTap: () {
                    selectIndex(16);
                  },
                  text: 'Head and Tail',
                  imagePath: Assets.headTailHomeHeadTales,
                ),
                // selectableContainer(
                //   isSelected: selectedIndex == 17,
                //   onTap: () {
                //     selectIndex(17);
                //   },
                //   text: 'Pool Rummy',
                //   imagePath: Assets.iconsPlonkoicon,
                // ),
                // selectableContainer(
                //   isSelected: selectedIndex == 18,
                //   onTap: () {
                //     selectIndex(18);
                //   },
                //   text: 'Deal Rummy',
                //   imagePath: Assets.iconsPlonkoicon,
                // ),
                // selectableContainer(
                //   isSelected: selectedIndex == 19,
                //   onTap: () {
                //     selectIndex(19);
                //   },
                //   text: 'Point Rummy',
                //   imagePath: Assets.iconsPlonkoicon,
                // ),
                // selectableContainer(
                //   isSelected: selectedIndex == 20,
                //   onTap: () {
                //     selectIndex(20);
                //   },
                //   text: 'Call Break',
                //   imagePath: Assets.iconsPlonkoicon,
                // ),
                // selectableContainer(
                //   isSelected: selectedIndex == 21,
                //   onTap: () {
                //     selectIndex(21);
                //   },
                //   text: 'Block chain lottery',
                //   imagePath: Assets.iconsPlonkoicon,
                // ),
                selectableContainer(
                  isSelected: selectedIndex == 22,
                  onTap: () {
                    selectIndex(22);
                  },
                  text: 'Teen Patti',
                  imagePath: Assets.teenPattiTossImg,
                ),
                // selectableContainer(
                //   isSelected: selectedIndex == 23,
                //   onTap: () {
                //     selectIndex(23);
                //   },
                //   text: 'Box live Betting',
                //   imagePath: Assets.iconsPlonkoicon,
                // ),
                // selectableContainer(
                //   isSelected: selectedIndex == 24,
                //   onTap: () {
                //     selectIndex(24);
                //   },
                //   text: 'Red and Black',
                //   imagePath: Assets.iconsPlonkoicon,
                // ),
              ],
            ),
          ),
          selectedIndex == 0
              ? const WingoMyHis()
              : selectedIndex == 1
                  ? const TrxAllHistory()
                  : selectedIndex == 2
                      ? const DragonTigerHistory(
                          gameid: '10',
                        )
                      : selectedIndex == 3
                          ? const AvaitorAllHistory(
                              gameid: '5',
                            )
                          : selectedIndex == 4
                              ? const PlinkobetHistoryPage(gameid: '11')
                              :
                              // selectedIndex == 5
                              // ?const AndharBaharPopUpPage(gameId: '13',):
                              //     selectedIndex == 6
                              // ?const AndharBaharPopUpPage(gameId: '14',):
                              Container()
        ],
      ),
    );
  }

  Widget selectableContainer({
    required bool isSelected,
    required VoidCallback onTap,
    required String text,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.blackColor : AppColors.contLightColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 60,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
