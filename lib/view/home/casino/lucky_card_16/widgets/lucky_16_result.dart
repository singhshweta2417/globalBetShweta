import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/casino/lucky_card_16/controller/lucky_16_controller.dart';
import 'package:game_on/view/home/casino/lucky_card_16/view_model/lucky_16_result_view_model.dart';
import 'package:provider/provider.dart';

class Lucky16Result extends StatelessWidget {
  const Lucky16Result({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final lucky16ResultViewModel = Provider.of<Lucky16ResultViewModel>(context);
    return Consumer<Lucky16Controller>(builder: (context, l16c, child) {
      return Container(
        height: height * 0.14,
        width: width * 0.32,
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.lucky16HBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            lucky16ResultViewModel.lucky16ResultList.length,
            (index) {
              final number = lucky16ResultViewModel.lucky16ResultList[index];
              final card = l16c.getCardForIndex(number.cardIndex!);
              final color = l16c.getColorForIndex(number.colorIndex!);
              final jackpot = l16c.getJackpotForIndex(number.jackpot!);
              return _buildResultItem(card, color, index,jackpot,context);
            },
          ),
        ),
      );
    });
  }

  Widget _buildResultItem(String card, String color, int index,String? jackpot,context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.12,
      width: index == 0 ? width * 0.06 : width * 0.025,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.lucky16Ee),
          fit: BoxFit.fill,
        ),
      ),
      child: index == 0
          ? _buildHorizontalLayout(card, color,jackpot,context)
          : _buildVerticalLayout(card, color,jackpot,context),
    );
  }

  Widget _buildHorizontalLayout(String card, String color,String? jackpot,context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImageContainer(card,context),
            _buildImageContainer(color,context),
          ],
        ),
        if(jackpot!=null)
          Positioned(
              bottom: -10,
              child: _buildJackpotImage(jackpot))
      ],
    );
  }

  Widget _buildVerticalLayout(String card, String color,String? jackpot,context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImageContainer(card,context),
            _buildImageContainer(color,context),
          ],
        ),
        if(jackpot!=null)
          Positioned(
              bottom: -10,
              child: _buildJackpotImage(jackpot))
      ],
    );
  }

  Widget _buildJackpotImage(String assetPath) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.fill),
      ),
    );
  }

  Widget _buildImageContainer(String assetPath,context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.04,
      width: width*0.02,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath),
          // fit: BoxFit.fill
        ),
      ),
    );
  }
}
