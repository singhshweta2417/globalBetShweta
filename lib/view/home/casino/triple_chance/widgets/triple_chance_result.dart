import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/casino/triple_chance/view_model/triple_chance_result_view_model.dart';
import 'package:provider/provider.dart';

class TripleChanceResult extends StatelessWidget {
  const TripleChanceResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tcr = Provider.of<TripleChanceResultViewModel>(context);
    return Container(
        height: height * 0.14,
        width: width * 0.25,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.tripleChanceTCResultBg),
                fit: BoxFit.fill)),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tcr.tripleChanceResultList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 3, bottom: 3),
                width: MediaQuery.of(context).size.width * 0.024,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tcr.tripleChanceResultList[index].wheel1Result
                            .toString(),
                        style: TextStyle(
                          color: index == 0 ? Colors.green : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: height*0.024,
                        ),
                      ),
                      Text(
                        tcr.tripleChanceResultList[index].wheel2Result
                            .toString(),
                        style: TextStyle(
                          color: index == 0 ? Colors.green : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: height*0.024,
                        ),
                      ),
                      Text(
                        tcr.tripleChanceResultList[index].wheel3Result
                            .toString(),
                        style: TextStyle(
                          color: index == 0 ? Colors.green : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: height*0.024,
                        ),
                      ),
                    ]),
              );
            }));
  }
}
