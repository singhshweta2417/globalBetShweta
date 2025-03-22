import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_bet_api.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_bool_provider.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/api/kino_result_api.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/closed_bet.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/keno_appbar.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/keno_colors.dart';
import 'package:globalbet/view/home/mini/kino_home_directory/view_all_result.dart';
import 'package:provider/provider.dart';


class KenoGame extends StatefulWidget {
  const KenoGame({super.key});

  @override
  _KenoGameState createState() => _KenoGameState();
}

class _KenoGameState extends State<KenoGame> {
  final List<int> items = [10, 50, 100, 200, 500, 1000];
  
  String? number;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resultProvider = Provider.of<KinoResultApi>(context, listen: false);
      resultProvider.resultFetch();
      final betProvider = Provider.of<KiNoBoolProvider>(context, listen: false);
      betProvider.startCountdown(context,resultProvider);
      Provider.of<KinoResultApi>(context,listen: false).resultFetch();
      final profileProvider = Provider.of<ProfileViewModel>(context, listen: false);
      profileProvider.profileApi(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final betPlaced = Provider.of<KiNoBoolProvider>(context);
    final betApi = Provider.of<KinoBetApi>(context);
    final resultApi = Provider.of<KinoResultApi>(context);
    final displayedList = betPlaced.getDisplayedList();
    print(displayedList);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: KiNoColors.kiNoBg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.035,),
            KiNoAppbar(betPlaced: betPlaced),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.032),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    height: height * 0.036,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26),
                    child: Center(
                        child: Text(
                      'SNo.${resultApi.response.first.gamesno+1}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
                  ),
                  Container(
                    height: height * 0.036,
                    width: width * 0.26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26),
                    child: Center(
                      child: Text(
                        "00:${betPlaced.countdownSeconds}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: betPlaced.kinoMinuteTime < 11
                                ? Colors.red
                                : Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            lastResult(betPlaced),
            mainGridNumber(betPlaced),
            selectedNumberWin(displayedList),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonWidget(() {
                  setState(() {
                    if (betPlaced.selectedNumbers.length < 10) {
                      int remaining = 10 - betPlaced.selectedNumbers.length;
                      for (int i = 0; i < remaining; i++) {
                        int randomNum;
                        do {
                          randomNum = Random().nextInt(40) + 1;
                        } while (betPlaced.selectedNumbers.contains(randomNum));
                        betPlaced.selectedNumbers.add(randomNum);
                      }
                    }
                  });
                }, 'Random'),
                buttonWidget(() {
                  setState(() {
                    betPlaced.selectedNumbers.clear();
                  });
                }, 'clear'),
                buttonWidget(() {}, 'Pay table'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                radioButtons(1, "Normal Risk", betPlaced),
                radioButtons(2, "Medium", betPlaced),
                radioButtons(3, "High Risk", betPlaced),
              ],
            ),
            const Spacer(),
            betPlaced.betStop == true
                ? const ClosedBet()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                betApi.kinoBetPlacedApi(
                                    context: context,
                                    riskLevel: betPlaced.selectedValue.toString(),
                                    selectedNumber: betPlaced.selectedNumbers,
                                    betAmount: betPlaced.selectedNumber.toString()
                                );
                              },
                              child: Container(
                                height: height * 0.055,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 1, color: Colors.black),
                                  gradient: betPlaced.kiNoBetPlaced != true
                                      ? KiNoColors.greenButton
                                      : KiNoColors.redBtn,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 8,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      betPlaced.kiNoBetPlaced != true
                                          ? Icons.play_arrow_outlined
                                          : Icons.pause,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      betPlaced.kiNoBetPlaced != true
                                          ? 'BET'
                                          : 'CANCEL',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: width*0.1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.08,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: height * 0.01),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.black),
                                color: const Color(0xff569123),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 12, left: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'BET INR',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        Container(
                                          height: height*0.04,
                                          width: width*0.38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color(0xff2b7009),
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                          ),
                                          child: Center(
                                              child: Text(
                                            '${betPlaced.selectedNumber}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white),
                                          )),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: betPlaced.decrement,
                                      child: Container(
                                          height: height*0.048,
                                          width: width*0.1,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.black),
                                              gradient: KiNoColors.kiNoBtn),
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
                                            builder: (context) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  AlertDialog(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    backgroundColor:
                                                        const Color(0xff2b7009),
                                                    content: Column(
                                                      children: [
                                                        const Text(
                                                          'BET INR',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Container(
                                                          color:
                                                              const Color(0xff2b7009),
                                                          height: 100,
                                                          width:
                                                              double.maxFinite,
                                                          child:
                                                              GridView.builder(
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                items.length,
                                                            gridDelegate:
                                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                              mainAxisSpacing:
                                                                  10,
                                                              crossAxisSpacing:
                                                                  10,
                                                              childAspectRatio:
                                                                  4 / 2,
                                                            ),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final isSelected =
                                                                  betPlaced
                                                                          .selectedNumber ==
                                                                      items[
                                                                          index];
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    betPlaced.setSelectedNumber(
                                                                        items[
                                                                            index]);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 20,
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    color: const Color(
                                                                        0xff569123),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${items[index]}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        color: isSelected
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 150,
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                          height: height*0.048,
                                          width: width*0.1,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.black),
                                              gradient: KiNoColors.kiNoBtn),
                                          child: const Icon(
                                            Icons.dynamic_feed_rounded,
                                            size: 20,
                                            color: Colors.white,
                                          )),
                                    ),

                                    InkWell(
                                      onTap: betPlaced.increment,
                                      child: Container(
                                          height: height*0.048,
                                          width: width*0.1,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.black),
                                              gradient: KiNoColors.kiNoBtn),
                                          child: const Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget lastResult(KiNoBoolProvider betPlaced) {
    return Consumer<KinoResultApi>(
      builder: (context, krv, child) {
        if (krv.response.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        var filteredData = krv.response.take(2).toList();

        return InkWell(
          onTap: (){
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return const KinoAllResult();
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.035, vertical: height * 0.01),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: height * 0.12,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: filteredData.map((data) {
                  List<dynamic> numbers = data.number
                      .replaceAll(RegExp(r'[\[\]]'), '')
                      .split(',')
                      .map((e) => e.trim())
                      .toList();
                  return Wrap(
                    children: numbers.map((num) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            gradient: KiNoColors.greenGradient,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          width: width * 0.07,
                          height: height * 0.035,
                          child: InkWell(
                            onTap: (){
                              print(betPlaced.selectedNumbers.contains(num));
                              print("betPlaced.selectedNumbers.contains(num)");
                            },
                            child: Center(
                              child: Text(
                                num,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget mainGridNumber(KiNoBoolProvider betPlaced) {
    return Wrap(
      children: List.generate(
        40,
        (index) {
          int number = index + 1;
          bool isSelected = betPlaced.selectedNumbers.contains(number);

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  betPlaced.selectedNumbers.remove(number);
                } else if (betPlaced.selectedNumbers.length < 10) {
                  betPlaced.selectedNumbers.add(number);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? KiNoColors.whiteGradient
                      : KiNoColors.greenGradient,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.yellowAccent
                        : Colors.black,
                    width: 3, // Border width
                  ),
                ),
                width: width * 0.095,
                height: height * 0.05,
                child: Center(
                  child: Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget selectedNumberWin(List<String> displayedList) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: height * 0.1,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 0.8, color: Colors.white),
        ),
        child: displayedList.isEmpty
            ? const Center(
                child: Text(
                  'No numbers selected',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Wrap(
                runSpacing: 5,
                children: List.generate(
                  displayedList.length,
                  (index) => SizedBox(
                    width: width * 0.23,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff1c4b07),
                            ),
                            child: Center(
                              child: Text(
                                index.toString(),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            displayedList[index],
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buttonWidget(void Function()? onTap, String text) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.04,
        width: width * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff039803),
            border: Border.all(width: 1, color: Colors.black)),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget radioButtons(int value, String text, KiNoBoolProvider betPlaced) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          fillColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.greenAccent;
              }
              return Colors.white;
            },
          ),
          groupValue: betPlaced.selectedValue,
          onChanged: (value) {
            betPlaced.setSelectedValue(value!);
          },
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
