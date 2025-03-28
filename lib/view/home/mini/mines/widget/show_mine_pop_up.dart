import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/view/home/mini/mines/controller/mine_controller.dart';
import 'package:game_on/view/home/mini/mines/res/mine_color.dart';
import 'package:provider/provider.dart';

class ShowMinePopUp extends StatelessWidget {
  const ShowMinePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MineController>(builder: (context, mic, child) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
        content: SizedBox(
          height: height * 0.55,
          width: width * 0.55,
          child: Column(
            children: [
              Container(
                height: 40,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.minesHowToPlayHeader),
                        fit: BoxFit.fill)),
                child: const Center(
                    child: Text(
                      'You Lose',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    )),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: mic.rows * mic.columns,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: mic.columns,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ mic.columns;
                  final col = index % mic.columns;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                          image: AssetImage(mic.selectedCells[index]
                              ? Assets.minesVault
                              : mic.isTapped &&
                              mic.grid[row][col] &&
                              mic.gameLost
                              ? Assets.minesMine
                              : Assets.minesMineGrid),
                          fit: BoxFit.fill),
                    ),
                  );
                },
              ),
              Container(
                height: height * 0.085,
                decoration: const BoxDecoration(
                  color: MineColor.whiteColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 15),
                  child: AppBtn(
                      title: 'Close',
                      fontSize: 15,
                      onTap: () {
                        mic.refreshGame();
                        Navigator.pop(context);
                      },
                      hideBorder: true,
                      gradient: MineColor.primaryGradient),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}