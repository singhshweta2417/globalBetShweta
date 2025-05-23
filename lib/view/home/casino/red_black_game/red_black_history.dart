import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/view/home/casino/fun_target/Constant/color.dart';
import 'package:game_on/view/home/casino/red_black_game/red_black_viewmodel/rb_game_history_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RedBlackGameHistoryScreen extends StatefulWidget {
  const RedBlackGameHistoryScreen({super.key});

  @override
  RedBlackGameHistoryScreenState createState() =>
      RedBlackGameHistoryScreenState();
}

class RedBlackGameHistoryScreenState extends State<RedBlackGameHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameHistory =
          Provider.of<RedBlackGameHistoryViewModel>(context, listen: false);
      gameHistory.redBlackGameHistoryApi(context);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: height * 0.6,
            width: width * 0.99,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.redBlackImgBgPicture1),
                    fit: BoxFit.fill)),
            child: Consumer<RedBlackGameHistoryViewModel>(
                builder: (context, jgh, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 20,
                          width: 40,
                        ),
                        const Text(
                          'MY HISTORY',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const SizedBox(
                            height: 20,
                            width: 60,
                            child: Center(
                                child: Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.white,
                              weight: 40,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ListView.builder(
                        itemCount: jgh.redBlackGameHistoryModel!.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = jgh.redBlackGameHistoryModel!.data;
                          return Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.035, left: 8, right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.textColor4),
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10)),
                              height: height * 0.16,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Status',
                                          style: TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          data![index].status == 0
                                              ? 'Pending'
                                              : data[index].status == 1
                                                  ? 'Win'
                                                  : 'Loss',
                                          style: TextStyle(
                                            color: data[index].status == 0
                                                ? Colors.blue
                                                : data[index].status == 1
                                                    ? Colors.green
                                                    : Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Game S.no',
                                          style: TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          data[index].gamesNo.toString(),
                                          style: const TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Bet Amount',
                                          style: TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '₹${data[index].amount}',
                                          style: const TextStyle(
                                            color: ColorConstant.textColor2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Win Amount',
                                          style: TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '₹${data[index].winAmount}',
                                          style: const TextStyle(
                                            color: ColorConstant.textColor2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding:
                                  //   const EdgeInsets.symmetric(horizontal: 8.0),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       const Text(
                                  //         'Win Number',
                                  //         style: TextStyle(
                                  //           color: ColorConstant.textColor1,
                                  //           fontSize: 10,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //       CircleAvatar(
                                  //         radius: height / 55,
                                  //         backgroundImage: AssetImage(data[
                                  //         index]
                                  //             .number ==
                                  //             1
                                  //             ? AppAssets.imageIcDtD
                                  //             : data[index].number == 2
                                  //             ? AppAssets.imageIcDtT
                                  //             : AppAssets.backgroundIcDtTie),
                                  //       ),
                                  //
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Bet Card',
                                          style: TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          data[index]
                                              .virtualGameName
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            color: ColorConstant.textColor2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Win Card',
                                          style: TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          data[index].winNumber == 1
                                              ? "Heart"
                                              : data[index].winNumber == 2
                                                  ? "CLUB"
                                                  : data[index].winNumber == 3
                                                      ? "SPADE"
                                                      : data[index].winNumber ==
                                                              4
                                                          ? "DIAMOND"
                                                          : data[index]
                                                                      .winNumber ==
                                                                  5
                                                              ? "RED"
                                                              : "BLACK",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Date',
                                          style: TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          DateFormat("dd/MM/yyyy")
                                              .format(DateTime.parse(
                                            data[index].updatedAt.toString(),
                                          )),
                                          style: const TextStyle(
                                            color: ColorConstant.textColor1,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }
}

class NotFoundData extends StatelessWidget {
  const NotFoundData({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.calendar_month_sharp, size: 120, color: Colors.white),
        Text(
          "Data not found",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
