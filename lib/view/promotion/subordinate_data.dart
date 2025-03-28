import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/subordinate_data_model.dart';
import 'package:game_on/model/tier_model.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/clipboard.dart';
import 'package:game_on/res/components/text_field.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;

class SubOrdinateDataScreen extends StatefulWidget {
  const SubOrdinateDataScreen({super.key});

  @override
  State<SubOrdinateDataScreen> createState() => _SubOrdinateDataScreenState();
}

class _SubOrdinateDataScreenState extends State<SubOrdinateDataScreen> {
  TextEditingController searchCon = TextEditingController();

  @override
  void initState() {
    tierData();
    subData();
    // TODO: implement initState
    super.initState();
  }

  int? responseStatusCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Subordinate Data', fontSize: 25, color: Colors.white),
          leading: const AppBackBtn(),
          centerTitle: true,
          gradient: AppColors.unSelectedColor),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.2),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Container(
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        gradient: AppColors.loginSecondaryGrad,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              addTextColumn(
                                  depositNumber == null
                                      ? "0"
                                      : depositNumber.toString(),
                                  'Deposit Number',
                                  Colors.white),
                              addTextColumn(
                                  numberOfBet == null
                                      ? "0"
                                      : numberOfBet.toString(),
                                  'Number of bettor',
                                  Colors.white),
                              addTextColumn(
                                  noFirstDeposit == null
                                      ? "0"
                                      : noFirstDeposit.toString(),
                                  'Number of People making\n            first deposit',
                                  Colors.white),
                            ],
                          ),
                          Column(
                            children: [
                              addTextColumn(
                                  depositAmount == null
                                      ? "0"
                                      : depositAmount.toString(),
                                  'Deposit Amount',
                                  Colors.white),
                              addTextColumn(
                                  totalBet == null ? "0" : totalBet.toString(),
                                  'Total bet',
                                  Colors.white),
                              addTextColumn(
                                  firstDepositAmount == null
                                      ? "0"
                                      : firstDepositAmount.toString(),
                                  'first deposit amount',
                                  Colors.white),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.04,
                      )
                    ]),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subDataItem.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        height: height * 0.25,
                        width: width * 0.93,
                        decoration: BoxDecoration(
                            color: AppColors.contLightColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                textWidget(
                                    text: '  UID:${subDataItem[index].uId}',
                                    fontSize: 18,
                                    color: AppColors.whiteColor),
                                IconButton(
                                    onPressed: () {
                                      copyToClipboard(
                                          subDataItem[index].uId.toString(),
                                          context);
                                    },
                                    icon: const Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: AppColors.whiteColor,
                                    )),
                              ],
                            ),
                            Container(
                              width: width * 0.9,
                              height: 0.5,
                              color: AppColors.whiteColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Level',
                                      fontSize: 16,
                                      color: AppColors.whiteColor),
                                  textWidget(
                                      text: selectedTierIndex == -1
                                          ? '  All'
                                          : 'Tier ${selectedTierIndex + 1}',
                                      fontSize: 16,
                                      color: AppColors.whiteColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Deposit amount',
                                      fontSize: 16,
                                      color: AppColors.whiteColor),
                                  textWidget(
                                      text: "🪙${subDataItem[index].totalCash}",
                                      fontSize: 16,
                                      color: AppColors.whiteColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Bet amount',
                                      fontSize: 18,
                                      color: AppColors.whiteColor),
                                  textWidget(
                                      text: "🪙${subDataItem[index].betAmount}",
                                      fontSize: 18,
                                      color: AppColors.whiteColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Commission',
                                      fontSize: 18,
                                      color: AppColors.whiteColor),
                                  textWidget(
                                      text: subDataItem[index]
                                          .commission
                                          .toString(),
                                      fontSize: 18,
                                      color: AppColors.whiteColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: 'Date',
                                      fontSize: 18,
                                      color: AppColors.whiteColor),
                                  textWidget(
                                      text: subDataItem[index]
                                          .yesterdayDate
                                          .toString(),
                                      fontSize: 18,
                                      color: AppColors.whiteColor),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
          SizedBox(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: CustomTextField(
                    fieldRadius: BorderRadius.circular(10),
                    fillColor: Colors.white.withOpacity(0.01),
                    controller: searchCon,
                    onChanged: (val) {},
                    maxLines: 1,
                    hintText: 'Search subordinate UID',
                    suffixIcon: InkWell(
                      onTap: () {
                        searchData(searchCon.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.03,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: AppColors.loginSecondaryGrad,
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Container(
                    height: height * 0.065,
                    decoration: BoxDecoration(
                        color: AppColors.contLightColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: textWidget(
                              text: selectedTierIndex == -1
                                  ? '  All'
                                  : 'Tier ${selectedTierIndex + 1}',
                              fontSize: 18,
                              color: AppColors.whiteColor),
                        ),
                        IconButton(
                            onPressed: () {
                              showSubordinateFilterBottomSheet(context);
                            },
                            icon: const Icon(Icons.keyboard_arrow_down_outlined,
                                color: AppColors.whiteColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int selectedTierIndex = 0;

  String type = 'all';

  showSubordinateFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.contLightColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: textWidget(
                        text: 'Cancel', fontSize: 16, color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, selectedTierIndex);
                      tierData();
                      subData();
                    },
                    child: textWidget(
                        text: 'Confirm', fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                    selectionOverlay:
                        const CupertinoPickerDefaultSelectionOverlay(
                      background: CupertinoDynamicColor.withBrightness(
                        color: Colors.transparent,
                        darkColor: Colors.transparent,
                      ),
                    ),
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedTierIndex,
                    ),
                    itemExtent: 50,
                    onSelectedItemChanged: (tierIndex) {
                      setState(() {
                        selectedTierIndex = tierIndex;
                        type = tierIndex == 0 ? 'all' : 'Tier $tierIndex';
                      });
                    },
                    children: [
                      for (var data in tierItem)
                        Text(
                          data.name,
                          style: const TextStyle(color: Colors.white),
                        )
                    ]),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        if (kDebugMode) {
          print('Selected Tier: $value');
        }
      }
    });
  }

  addTextColumn(String number, String subtext, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
          ),
          Text(
            subtext,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }

  List<TierModel> tierItem = [];
  Future<void> tierData() async {
    final response = await http.get(
      Uri.parse(ApiUrl.tierApi),
    );
    if (kDebugMode) {
      print(ApiUrl.tierApi);
      print('TierApi');
    }

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        tierItem =
            responseData.map((item) => TierModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        tierItem = [];
      });
      throw Exception('Failed to load data');
    }
  }

  UserViewModel userProvider = UserViewModel();

  int? depositNumber;
  String? depositAmount;
  int? numberOfBet;
  int? totalBet;
  int? noFirstDeposit;
  int? firstDepositAmount;

  List<SubordinateModel> subDataItem = [];
  Future<void> subData() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(
      Uri.parse("${ApiUrl.subDataApi}$token&tier=${selectedTierIndex + 1}"),
    );

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(response.body)['subordinates_data'];

      setState(() {
        subDataItem = responseData
            .map((item) => SubordinateModel.fromJson(item))
            .toList();
        noFirstDeposit = json.decode(response.body)['first deposit '];
        depositNumber = json.decode(response.body)['number of deposit'];
        depositAmount = json.decode(response.body)['payin amount'];
        numberOfBet = json.decode(response.body)['number of bettor'];
        totalBet = json.decode(response.body)['bet amount'];
        firstDepositAmount = json.decode(response.body)['first deposit amount'];
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        subDataItem = [];
      });
      throw Exception('Failed to load data');
    }
  }

  Future<void> searchData(String search) async {
    try {
      UserModel user = await userProvider.getUser();
      String token = user.id.toString();

      final response = await http.get(
        Uri.parse(
            "${ApiUrl.subDataApi}$token&tier=${selectedTierIndex + 1}&u_id=$search"),
      );

      if (kDebugMode) {
        print(
            "${ApiUrl.subDataApi}$token&tier=${selectedTierIndex + 1}&u_id=$search");
        print("HTTP GET request sent");
      }

      setState(() {
        responseStatusCode = response.statusCode;
      });

      if (response.statusCode == 200) {
        List<SubordinateModel> searchResult = subDataItem
            .where((data) => data.uId.toString().contains(search))
            .toList();

        setState(() {
          subDataItem = searchResult;
        });
      } else if (response.statusCode == 400) {
        if (kDebugMode) {
          print("Data not found");
        }
      } else {
        setState(() {
          subDataItem = [];
        });
        throw Exception("Failed to load data");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error in searchData function: $error");
      }
      throw Exception("Error in searchData function: $error");
    }
  }
}
