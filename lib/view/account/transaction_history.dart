import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/account/all_bet_history/avaitor_all_bet_history.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/all_transaction_model.dart';
import 'package:globalbet/model/transaction_type_model.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/utils/filter_date-formate.dart';
import 'package:globalbet/utils/routes/routes_name.dart';

class TransctionHistory extends StatefulWidget {
  const TransctionHistory({Key? key}) : super(key: key);

  @override
  State<TransctionHistory> createState() => _TransctionHistoryState();
}

class _TransctionHistoryState extends State<TransctionHistory> {
  int selectedId = 0;
  String typeName = 'All';
  DateTime? _selectedDate;
  List<AllTransactionModel> allTransactions = [];
  List<TransctionTypeModel> transctionTypes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTransactionTypes();
    allTransctionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
        title: textWidget(
          text: 'Transaction history',
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: AppColors.whiteColor,
        ),
        centerTitle: true,
        gradient: AppColors.unSelectedColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
                        return allTransctionType(context);
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
                            width: width*0.3,
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
                Container(
                  height: height * 0.08,
                    width: width * 0.45,
                  decoration: BoxDecoration(
                      color: AppColors.contLightColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                          text:   _selectedDate==null?'Select date':
                          '   ${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                          fontSize: 18,
                          color: AppColors.whiteColor),
                      FilterDateFormat(
                        onDateSelected: (DateTime selectedDate) {


                          setState(() {
                            _selectedDate = selectedDate;
                          });
                          allTransctionHistory();
                          if (kDebugMode) {
                            print('Selected Date: $selectedDate');
                            print('object');
                          }
                        },
                      )
                    ],
                  ),
                ),

              ],
            ),
            responseStatusCode==400?const Notfounddata():
            allTransactions.isEmpty?const Center(child: CircularProgressIndicator()) :
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: allTransactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final transaction = allTransactions[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.darkColor,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.06,
                              width: width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                gradient: AppColors.loginSecondaryGrad,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: textWidget(
                                    text: transaction.type.toString(),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            historyDetails(
                              'Detail',
                              transaction.type.toString(),
                              Colors.white,
                            ),
                            historyDetails(
                              'Time',
                              transaction.datetime.toString(),
                              Colors.white,
                            ),
                            historyDetails(
                              'balance',
                             '₹${transaction.amount!.toStringAsFixed(2)}',
                              Colors.red,
                            ),
                            SizedBox(height: height * 0.015),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allTransctionType(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        color: AppColors.darkColor,
      ),
      height: MediaQuery.of(context).size.height * 0.6,
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
                    color: selectedId == 0
                        ? Colors.blue
                        : AppColors.dividerColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      allTransctionHistory();
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
              itemCount: transctionTypes.length,
              itemBuilder: (BuildContext context, int index) {
                final transactionType = transctionTypes[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedId = transactionType.id;
                      typeName=transactionType.name;
                    });
                    if (kDebugMode) {
                      print(selectedId);
                    }
                  },
                  child: Column(
                    children: [
                      Center(
                        child: textWidget(
                          text: transactionType.name,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: selectedId == index.toString()
                              ? Colors.blue
                              : AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(
                        height:
                        MediaQuery.of(context).size.height * 0.02,
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

  Widget historyDetails(String title, String subtitle, Color subColor) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            height: height * 0.05,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.unSelectColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: subColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  UserViewModel userProvider = UserViewModel();

  Future<void> fetchTransactionTypes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(ApiUrl.allTransactionType));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          transctionTypes = responseData
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

  int? responseStatusCode;
  Future<void> allTransctionHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(

      Uri.parse(_selectedDate==null?'${ApiUrl.allTransaction}$token&subtypeid=$selectedId':'${ApiUrl.allTransaction}$token&subtypeid=$selectedId&created_at=$_selectedDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      responseStatusCode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        allTransactions = responseData
            .map((item) => AllTransactionModel.fromJson(item))
            .toList();
      });
    } else if (response.statusCode == 400) {
    } else {
      setState(() {
        allTransactions = [];
      });
      throw Exception('Failed to load transaction history');
    }
  }
}


