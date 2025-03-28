import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/plinko_result.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;

class PlinkoPopUpPage extends StatefulWidget {
  const PlinkoPopUpPage({super.key});

  @override
  State<PlinkoPopUpPage> createState() => _PlinkoPopUpPageState();
}

class _PlinkoPopUpPageState extends State<PlinkoPopUpPage> {
  @override
  void initState() {
    super.initState();
    fetchPlinkoBethistoryTwo();
  }

  int limitResult = 0;
  int pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: height * 0.8,
          width: width,
          color: const Color(0xff495b65),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'GAME HISTORY',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: height,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: width * 0.25,
                                child: const Center(
                                  child: Text(
                                    'Time',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: width*0.05,
                              // ),
                              SizedBox(
                                width: width * 0.15,
                                child: const Center(
                                  child: Text(
                                    'Bet',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Cash out',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.18,
                                child: const Text(
                                  'Multiplier',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          responseStatuscode == 400
                              ? const NotFoundData()
                              : fetchPlinkoBetTwo.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : SizedBox(
                                      height: height * 0.55,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemCount: fetchPlinkoBetTwo.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    height: height * 0.05,
                                                    width: width,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff394c54),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          width: width * 0.25,
                                                          child: Center(
                                                            child: Text(
                                                              fetchPlinkoBetTwo[
                                                                      index]
                                                                  .datetime
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.15,
                                                          child: Center(
                                                            child: Text(
                                                              "${fetchPlinkoBetTwo[index].amount}.00🪙",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: int.parse(fetchPlinkoBetTwo[index]
                                                                            .winAmount
                                                                            .toString()) >
                                                                        int.parse(fetchPlinkoBetTwo[index]
                                                                            .amount
                                                                            .toString())
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.2,
                                                          child: Center(
                                                            child: Text(
                                                              "+${fetchPlinkoBetTwo[index].winAmount}.00🪙",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: int.parse(fetchPlinkoBetTwo[index]
                                                                            .winAmount
                                                                            .toString()) >
                                                                        int.parse(fetchPlinkoBetTwo[index]
                                                                            .amount
                                                                            .toString())
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.18,
                                                          child: Center(
                                                            child: Text(
                                                              "${fetchPlinkoBetTwo[index].multipler}x",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: int.parse(fetchPlinkoBetTwo[index]
                                                                            .winAmount
                                                                            .toString()) >
                                                                        int.parse(fetchPlinkoBetTwo[index]
                                                                            .amount
                                                                            .toString())
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: limitResult == 0
                                    ? () {}
                                    : () {
                                        setState(() {
                                          pageNumber--;
                                          limitResult = limitResult - 10;
                                          offsetResult = offsetResult - 10;
                                        });
                                        setState(() {});
                                        fetchPlinkoBethistoryTwo();
                                      },
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff394c54),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.navigate_before,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              textWidget(
                                text: '$pageNumber/${fetchPlinkoBetTwo.length}',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                                maxLines: 1,
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    limitResult = limitResult + 10;
                                    offsetResult = offsetResult + 10;
                                    pageNumber++;
                                  });
                                  setState(() {});
                                  fetchPlinkoBethistoryTwo();
                                },
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff394c54),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.navigate_next,
                                      color: Colors.white),
                                ),
                              ),
                            ],
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
      ),
    );
  }

  int? responseStatuscode;

  UserViewModel userProvider = UserViewModel();
  int offsetResult = 0;
  List<PlinkoBetHistory> fetchPlinkoBetTwo = [];
  Future<void> fetchPlinkoBethistoryTwo() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(
      Uri.parse(
          "${ApiUrl.plinkoBetHistory}userid=$token&offset=$offsetResult&limit=10"),
    );

    setState(() {
      responseStatuscode = response.statusCode;
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

class NotFoundData extends StatelessWidget {
  const NotFoundData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.05,
        ),
        Image.asset(
          Assets.imagesNoDataAvailable,
          height: height * 0.21,
        ),
        const Text(
          "No data (:",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
