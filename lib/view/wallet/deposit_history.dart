import 'dart:convert';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/deposit_model_new.dart';
import 'package:game_on/model/transaction_type_model.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:game_on/utils/filter_date_format.dart';
import 'package:game_on/utils/routes/routes_name.dart';
import '../../model/deposit_model.dart';
import '../account/History/betting_history.dart';

class DepositHistory extends StatefulWidget {
  const DepositHistory({super.key});

  @override
  State<DepositHistory> createState() => _DepositHistoryState();
}

class _DepositHistoryState extends State<DepositHistory>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    depositHistory();
    getWaySelect();
    fetchTransactionTypes(context);
    super.initState();
    selectedCatIndex = "1";
  }

  bool isLoading = false;

  int? responseStatusCode;

  String selectedCatIndex = "1";
  int selectedId = 0;
  String typeName = 'All';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: textWidget(
          text: 'Deposit history',
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: AppColors.whiteColor,
        ),
        centerTitle: true,
        gradient: AppColors.unSelectedColor,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              height: 70,
              width: width * 0.93,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCatIndex = items[index].type;
                        });
                        depositHistory();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          gradient: selectedCatIndex == items[index].type
                              ? AppColors.loginSecondaryGrad
                              : AppColors.unSelectedColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: NetworkImage('${items[index].image}'),
                              height: 25,
                            ),
                            textWidget(
                              text: items[index].name,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selectedCatIndex == items[index].type
                                  ? AppColors.whiteColor
                                  : AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return allTransactionType(context);
                        },
                      );
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: AppColors.unSelectedColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: textWidget(
                                text: typeName,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: AppColors.dividerColor,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.dividerColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                          color: AppColors.contLightColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(
                              text: _selectedDate == null
                                  ? 'Select date'
                                  : '   ${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                              fontSize: 18,
                              color: AppColors.whiteColor),
                          FilterDateFormat(
                            onDateSelected: (DateTime selectedDate) {
                              setState(() {
                                _selectedDate = selectedDate;
                              });
                              depositHistory();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            responseStatusCode == 400
                ? const Notfounddata()
                : depositItems.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: depositItems.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: AppColors.unSelectedColor,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: width * 0.30,
                                              decoration: BoxDecoration(
                                                  color: AppColors.methodBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: textWidget(
                                                  text: 'Deposit',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.whiteColor),
                                            ),
                                            textWidget(
                                                text: depositItems[index]
                                                            .status ==
                                                        1
                                                    ? "Processing"
                                                    : depositItems[index]
                                                                .status ==
                                                            2
                                                        ? "Complete"
                                                        : "Rejected",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: depositItems[index]
                                                            .status ==
                                                        1
                                                    ? AppColors.whiteColor
                                                    : depositItems[index]
                                                                .status ==
                                                            2
                                                        ? Colors.green
                                                        : AppColors.whiteColor)
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.5,
                                        indent: 10,
                                        endIndent: 10,
                                        color: AppColors.whiteColor,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            textWidget(
                                                text: "Balance",
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.whiteColor),
                                            textWidget(
                                                text:
                                                    "🪙${depositItems[index].cash}",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.whiteColor),
                                          ],
                                        ),
                                      ),
                                      selectedCatIndex == "2"
                                          ? const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              // child: Row(
                                              //   mainAxisAlignment:
                                              //   MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     textWidget(
                                              //         text: "USDT Amount",
                                              //         fontSize: width * 0.04,
                                              //         fontWeight: FontWeight.w600,
                                              //         color: AppColors.whiteColor),
                                              //     textWidget(
                                              //         text: "${depositItems[index].usdtAmount}",
                                              //         fontSize: 14,
                                              //         fontWeight: FontWeight.w600,
                                              //         color: AppColors.btnColor),
                                              //   ],
                                              // ),
                                            )
                                          : Container(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            textWidget(
                                                text: "Type",
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.whiteColor),
                                            textWidget(
                                                text: depositItems[index]
                                                            .status ==
                                                        0
                                                    ? "INR"
                                                    : "INR",
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.whiteColor),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            textWidget(
                                                text: "Time",
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.whiteColor),
                                            textWidget(
                                                text: DateFormat(
                                                        "dd-MMM-yyyy, hh:mm a")
                                                    .format(DateTime.parse(
                                                        depositItems[index]
                                                            .createdAt
                                                            .toString())),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.whiteColor),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            textWidget(
                                                text: "Order number",
                                                fontSize: width * 0.04,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.whiteColor),
                                            Row(
                                              children: [
                                                textWidget(
                                                    text: depositItems[index]
                                                        .orderId
                                                        .toString(),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.whiteColor),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Image.asset(Assets.iconsCopy,
                                                    color: Colors.grey,
                                                    height: height * 0.03)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))
          ],
        ),
      ),
    );
  }

  UserViewModel userProvider = UserViewModel();

  List<DepositModel> depositItems = [];

  Future<void> depositHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(
        Uri.parse('${ApiUrl.depositHistory}$token&type=$selectedCatIndex'));
    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        depositItems =
            responseData.map((item) => DepositModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        depositItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

  Widget allTransactionType(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: AppColors.darkColor,
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: textWidget(
                    text: 'Cancel',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppColors.dividerColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      depositHistory();
                    });
                    Navigator.pop(context);
                  },
                  child: textWidget(
                    text: 'Confirm',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactionTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final type = transactionTypes[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedId = index;
                            typeName = type.name.toString();
                          });
                          if (kDebugMode) {
                            print(selectedId);
                          }
                        },
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                type.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: selectedId == index
                                      ? Colors.blue
                                      : AppColors.whiteColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<TransctionTypeModel> transactionTypes = [];
  Future<void> fetchTransactionTypes(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await http.get(Uri.parse(ApiUrl.depositWithdrawlStatusList));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          transactionTypes = responseData
              .map((item) => TransctionTypeModel.fromJson(item))
              .toList();
        });
      } else if (response.statusCode == 401) {
        Navigator.pushNamed(context, RoutesName.loginScreen);
      } else {
        throw Exception('Failed to load transaction types');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching transaction types: $e');
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  ///gateway select api
  List<GetwayModel> items = [];

  Future<void> getWaySelect() async {
    final response = await http.get(
      Uri.parse(ApiUrl.getWayList),
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => GetwayModel.fromJson(item)).toList();
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }
}
